import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/dungeon/dungeon_catalog.dart';
import '../../core/dungeon/dungeon_combat.dart';
import '../../core/dungeon/dungeon_models.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/rpg/shop_catalog.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import 'dungeon_run_screen.dart';

/// Nova aba **Raids** (Fase 6): Hub de Masmorras Procedurais + Inventário + Ferreiro.
class DungeonHubTab extends ConsumerStatefulWidget {
  const DungeonHubTab({super.key, required this.hero});

  final HeroProfile hero;

  @override
  ConsumerState<DungeonHubTab> createState() => _DungeonHubTabState();
}

class _DungeonHubTabState extends ConsumerState<DungeonHubTab> {
  int _subTab = 0; // 0: Masmorras, 1: Inventário, 2: Ferreiro
  DungeonItemSlot _smithFilter = DungeonItemSlot.weapon;
  late TextEditingController _seedController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _seedController = TextEditingController(
      text: '${100000 + Random().nextInt(899999)}',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _initOnOpen());
  }

  Future<void> _initOnOpen() async {
    if (_initialized) return;
    _initialized = true;
    final heroClass = HeroClass.fromKey(widget.hero.heroClass);
    await ref.read(dungeonRepositoryProvider).ensureStarterGear(heroClass);
    final gotDailyKey =
        await ref.read(heroRepositoryProvider).claimDailyExpeditionKeyIfNeeded();
    if (gotDailyKey && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: LifeOsColors.surfaceHighlight,
          content: Text(
            '🔑 +1 Chave de Expedição diária recebida!',
            style: TextStyle(color: LifeOsColors.gold, fontWeight: FontWeight.w800),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _seedController.dispose();
    super.dispose();
  }

  int _parseSeed() {
    final clean = _seedController.text.trim();
    final parsed = int.tryParse(clean);
    if (parsed != null && parsed > 0) return parsed;
    return clean.isEmpty
        ? (100000 + Random().nextInt(899999))
        : (clean.hashCode & 0x7FFFFFFF);
  }

  void _randomizeSeed() {
    setState(() {
      _seedController.text = '${100000 + Random().nextInt(899999)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(dungeonCatalogProvider);
    final attrsList = ref.watch(attributeStatsProvider).value ?? const [];
    final inventoryRows = ref.watch(dungeonInventoryProvider).value ?? const [];
    final progressRows = ref.watch(dungeonProgressProvider).value ?? const [];

    final attrMap = <RpgAttribute, int>{
      for (final attr in RpgAttribute.values) attr: 1,
      for (final row in attrsList) RpgAttribute.fromKey(row.attributeKey): row.level,
    };

    return catalogAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: LifeOsColors.gold),
      ),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Erro ao carregar bestiário: $e'),
        ),
      ),
      data: (catalog) {
        final equippedItems = <DungeonItem>[];
        for (final row in inventoryRows) {
          if (row.isEquipped) {
            final item = catalog.itemById(row.itemId);
            if (item != null) equippedItems.add(item);
          }
        }

        final heroClass = HeroClass.fromKey(widget.hero.heroClass);
        final combatStats = DungeonCombatEngine.computeHeroStats(
          heroLevel: widget.hero.level,
          heroClass: heroClass,
          attributes: attrMap,
          equippedItems: equippedItems,
        );

        final progressByBiome = {
          for (final p in progressRows) p.biomeKey: p,
        };

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: _buildSubTabBar(),
            ),
            Expanded(
              child: IndexedStack(
                index: _subTab,
                children: [
                  _buildDungeonsView(
                    catalog: catalog,
                    attrMap: attrMap,
                    equippedItems: equippedItems,
                    combatStats: combatStats,
                    progressByBiome: progressByBiome,
                  ),
                  _buildInventoryView(
                    catalog: catalog,
                    inventoryRows: inventoryRows,
                    equippedItems: equippedItems,
                    combatStats: combatStats,
                  ),
                  _buildBlacksmithView(
                    catalog: catalog,
                    inventoryRows: inventoryRows,
                    charismaLevel: attrMap[RpgAttribute.charisma] ?? 1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubTabBar() {
    const labels = ['MASMORRAS', 'INVENTÁRIO', 'FERREIRO'];
    return Row(
      children: List.generate(labels.length, (i) {
        final active = _subTab == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _subTab = i),
            child: Container(
              margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: active ? LifeOsColors.surfaceHighlight : LifeOsColors.surface,
                border: Border.all(
                  color: active ? LifeOsColors.gold : LifeOsColors.border,
                  width: active ? 2 : 1.5,
                ),
              ),
              child: Text(
                labels[i],
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(
                  size: 8.5,
                  color: active ? LifeOsColors.gold : LifeOsColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDungeonsView({
    required DungeonCatalog catalog,
    required Map<RpgAttribute, int> attrMap,
    required List<DungeonItem> equippedItems,
    required HeroCombatStats combatStats,
    required Map<String, DungeonProgressData> progressByBiome,
  }) {
    final keys = widget.hero.expeditionKeys;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      children: [
        // Card de Chaves de Expedição + Seed + Poder do Herói
        PixelPanel(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PixelIcon(
                    keys > 0
                        ? 'assets/images/dungeon/items/icon_key_gold.png'
                        : 'assets/images/dungeon/items/icon_key_iron.png',
                    size: 34,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHAVES DE EXPEDIÇÃO: $keys / 10',
                          style: LifeOsTheme.pixelTitle(
                            size: 9.5,
                            color: keys > 0 ? LifeOsColors.gold : LifeOsColors.danger,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Conclua tarefas, compromissos ou sidequests na aba Hoje para recarregar chaves (+1 grátis por dia).',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: LifeOsColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _seedController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Seed da Masmorra (compartilhável)',
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _randomizeSeed,
                    tooltip: 'Sortear nova Seed',
                    style: IconButton.styleFrom(
                      backgroundColor: LifeOsColors.bgDark,
                      side: const BorderSide(color: LifeOsColors.border),
                      shape: const RoundedRectangleBorder(),
                    ),
                    icon: const Icon(
                      Icons.casino_rounded,
                      color: LifeOsColors.gold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _MiniBadge('HP ${combatStats.maxHp}', LifeOsColors.danger),
                  _MiniBadge('MP ${combatStats.maxMana}', const Color(0xFF5DA9FF)),
                  _MiniBadge('ATQ ${combatStats.attackPower}', LifeOsColors.gold),
                  _MiniBadge('MAG ${combatStats.magicPower}', const Color(0xFFC078F8)),
                  _MiniBadge('DEF ${combatStats.defense}', LifeOsColors.success),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'ESCOLHA SUA MASMORRA',
          style: LifeOsTheme.pixelTitle(size: 10.5, color: LifeOsColors.gold),
        ),
        const SizedBox(height: 4),
        Text(
          'Os monstros escalam com o seu Nível (${widget.hero.level}) e ficam mais fortes a cada andar.',
          style: const TextStyle(fontSize: 12, color: LifeOsColors.textSecondary),
        ),
        const SizedBox(height: 10),
        for (final biome in DungeonBiome.values) ...[
          _buildBiomeCard(
            biome: biome,
            progress: progressByBiome[biome.key],
            keys: keys,
            onEnter: () => _startExpedition(
              biome: biome,
              catalog: catalog,
              attrMap: attrMap,
              equippedItems: equippedItems,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildBiomeCard({
    required DungeonBiome biome,
    required DungeonProgressData? progress,
    required int keys,
    required VoidCallback onEnter,
  }) {
    final bestFloor = progress?.bestFloor ?? 0;
    final clears = progress?.clearsCount ?? 0;

    return PixelPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Preview do tile + Boss sobreposto
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  border: Border.all(color: biome.accentColor, width: 2),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      biome.previewTileAsset,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                    Container(color: const Color(0x55120D0C)),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        biome.bossSpriteAsset,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      biome.name.toUpperCase(),
                      style: LifeOsTheme.pixelTitle(
                        size: 9.5,
                        color: biome.accentColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      biome.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: LifeOsColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${biome.maxFloors} andares • Boss: ${biome.bossName}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: LifeOsColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  bestFloor > 0
                      ? 'Recorde: Andar $bestFloor/${biome.maxFloors}${clears > 0 ? ' • 🏆 ${clears}x concluída' : ''}'
                      : 'Ainda não explorada',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: LifeOsColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          PixelButton(
            label: keys > 0
                ? 'ENTRAR (-1 CHAVE)'
                : 'SEM CHAVES (CONCLUA TAREFAS)',
            onPressed: keys > 0 ? onEnter : null,
          ),
        ],
      ),
    );
  }

  Future<void> _startExpedition({
    required DungeonBiome biome,
    required DungeonCatalog catalog,
    required Map<RpgAttribute, int> attrMap,
    required List<DungeonItem> equippedItems,
  }) async {
    final spent = await ref.read(heroRepositoryProvider).spendExpeditionKey();
    if (!spent || !mounted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você precisa de pelo menos 1 Chave de Expedição.'),
          ),
        );
      }
      return;
    }

    final seed = _parseSeed();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DungeonRunScreen(
          hero: widget.hero,
          attributes: attrMap,
          equippedItems: equippedItems,
          catalog: catalog,
          biome: biome,
          seed: seed,
        ),
      ),
    );
    // Sorteia uma nova seed pronta para a próxima aventura
    if (mounted) _randomizeSeed();
  }

  Widget _buildInventoryView({
    required DungeonCatalog catalog,
    required List<DungeonInventoryData> inventoryRows,
    required List<DungeonItem> equippedItems,
    required HeroCombatStats combatStats,
  }) {
    final heroClass = HeroClass.fromKey(widget.hero.heroClass);
    final armorTint = ArmorTint.fromKey(widget.hero.armorTint);

    DungeonItem? equippedIn(DungeonItemSlot slot) {
      for (final item in equippedItems) {
        if (item.slot == slot) return item;
      }
      return null;
    }

    final equipRows = inventoryRows
        .where((r) => r.slot != DungeonItemSlot.consumable.key)
        .toList();
    final consRows = inventoryRows
        .where((r) => r.slot == DungeonItemSlot.consumable.key)
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      children: [
        // Cartão do Personagem + 3 Slots Equipados + Status Reais
        PixelPanel(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: LifeOsColors.bgDark,
                      border: Border.all(color: LifeOsColors.gold, width: 2),
                    ),
                    child: Center(
                      child: HeroSpriteWidget(
                        assetPath: heroClass.spriteAsset,
                        armorTint: armorTint,
                        size: 68,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.hero.name.toUpperCase()} • NV.${widget.hero.level}',
                          style: LifeOsTheme.pixelTitle(
                            size: 9.5,
                            color: LifeOsColors.gold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 5,
                          children: [
                            _MiniBadge('HP ${combatStats.maxHp}', LifeOsColors.danger),
                            _MiniBadge('MP ${combatStats.maxMana}', const Color(0xFF5DA9FF)),
                            _MiniBadge('ATQ ${combatStats.attackPower}', LifeOsColors.gold),
                            _MiniBadge('MAG ${combatStats.magicPower}', const Color(0xFFC078F8)),
                            _MiniBadge('DEF ${combatStats.defense}', LifeOsColors.success),
                            _MiniBadge(
                              'CRIT ${(combatStats.critChance * 100).round()}%',
                              const Color(0xFFE8844A),
                            ),
                            _MiniBadge(
                              'ESQ ${(combatStats.dodgeChance * 100).round()}%',
                              const Color(0xFF45B5AA),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _EquippedSlotTile(
                      slotLabel: 'ARMA',
                      item: equippedIn(DungeonItemSlot.weapon),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _EquippedSlotTile(
                      slotLabel: 'ARMADURA',
                      item: equippedIn(DungeonItemSlot.armor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _EquippedSlotTile(
                      slotLabel: 'ANEL',
                      item: equippedIn(DungeonItemSlot.ring),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'EQUIPAMENTOS NA MOCHILA (${equipRows.length})',
          style: LifeOsTheme.pixelTitle(size: 9.5, color: LifeOsColors.gold),
        ),
        const SizedBox(height: 8),
        if (equipRows.isEmpty)
          const Text(
            'Explore masmorras ou visite o Ferreiro para conseguir equipamentos.',
            style: TextStyle(fontSize: 12.5, color: LifeOsColors.textMuted),
          )
        else
          for (final row in equipRows)
            if (catalog.itemById(row.itemId) != null)
              _buildInventoryItemCard(
                item: catalog.itemById(row.itemId)!,
                row: row,
              ),
        const SizedBox(height: 14),
        Text(
          'CONSUMÍVEIS (${consRows.fold<int>(0, (s, r) => s + r.quantity)})',
          style: LifeOsTheme.pixelTitle(size: 9.5, color: LifeOsColors.gold),
        ),
        const SizedBox(height: 8),
        if (consRows.isEmpty)
          const Text(
            'Sem poções ou pergaminhos na mochila. Passe no Ferreiro antes de descer!',
            style: TextStyle(fontSize: 12.5, color: LifeOsColors.textMuted),
          )
        else
          for (final row in consRows)
            if (catalog.itemById(row.itemId) != null)
              _buildInventoryItemCard(
                item: catalog.itemById(row.itemId)!,
                row: row,
              ),
      ],
    );
  }

  Widget _buildInventoryItemCard({
    required DungeonItem item,
    required DungeonInventoryData row,
  }) {
    final chips = item.bonuses.summaryChips();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: LifeOsColors.surface,
        border: Border.all(
          color: row.isEquipped ? LifeOsColors.gold : item.rarity.color.withValues(alpha: 0.6),
          width: row.isEquipped ? 2 : 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: LifeOsColors.bgDark,
              border: Border.all(color: item.rarity.color),
            ),
            child: PixelIcon(item.iconAsset, size: 38),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.name}${row.quantity > 1 ? ' x${row.quantity}' : ''}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: item.rarity.color,
                  ),
                ),
                Text(
                  '${item.material} • ${item.rarity.label}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: LifeOsColors.textMuted,
                  ),
                ),
                if (chips.isNotEmpty)
                  Text(
                    chips.join(' • '),
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: LifeOsColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: LifeOsColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            children: [
              if (!item.isConsumable)
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: row.isEquipped
                          ? LifeOsColors.surfaceHighlight
                          : LifeOsColors.gold,
                      foregroundColor: row.isEquipped
                          ? LifeOsColors.gold
                          : LifeOsColors.bgDark,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () {
                      final repo = ref.read(dungeonRepositoryProvider);
                      if (row.isEquipped) {
                        repo.unequipItem(item.id);
                      } else {
                        repo.equipItem(item.id, item.slot);
                      }
                    },
                    child: Text(
                      row.isEquipped ? 'EQUIPADO' : 'EQUIPAR',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () async {
                  final res =
                      await ref.read(dungeonRepositoryProvider).sellItem(item);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(res.message)),
                  );
                },
                child: Text(
                  'Vender (+${item.sellPrice}g)',
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: LifeOsColors.textMuted,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBlacksmithView({
    required DungeonCatalog catalog,
    required List<DungeonInventoryData> inventoryRows,
    required int charismaLevel,
  }) {
    final heroClass = HeroClass.fromKey(widget.hero.heroClass);
    final qtyMap = {for (final r in inventoryRows) r.itemId: r.quantity};
    final items = catalog.allItems
        .where((i) => i.slot == _smithFilter)
        .toList()
      ..sort((a, b) => a.price.compareTo(b.price));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: DungeonItemSlot.values.map((slot) {
                final selected = _smithFilter == slot;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(slot.label),
                    selected: selected,
                    onSelected: (_) => setState(() => _smithFilter = slot),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
            itemCount: items.length,
            itemBuilder: (_, idx) {
              final item = items[idx];
              final price = ShopCatalog.discountedPrice(
                basePrice: item.price,
                heroClass: heroClass,
                charismaLevel: charismaLevel,
              );
              final ownedQty = qtyMap[item.id] ?? 0;
              final canAfford = widget.hero.gold >= price;
              final chips = item.bonuses.summaryChips();

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: LifeOsColors.surface,
                  border: Border.all(
                    color: item.rarity.color.withValues(alpha: 0.65),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: LifeOsColors.bgDark,
                        border: Border.all(color: item.rarity.color),
                      ),
                      child: PixelIcon(item.iconAsset, size: 38),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: item.rarity.color,
                            ),
                          ),
                          Text(
                            '${item.material} • ${item.rarity.label}${ownedQty > 0 ? ' • Na mochila: x$ownedQty' : ''}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: LifeOsColors.textMuted,
                            ),
                          ),
                          Text(
                            chips.isNotEmpty ? chips.join(' • ') : item.description,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: LifeOsColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canAfford
                            ? LifeOsColors.gold
                            : LifeOsColors.surfaceHighlight,
                        foregroundColor: canAfford
                            ? LifeOsColors.bgDark
                            : LifeOsColors.textMuted,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: canAfford
                          ? () async {
                              final res = await ref
                                  .read(dungeonRepositoryProvider)
                                  .buyItem(item);
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(res.message)),
                              );
                            }
                          : null,
                      child: Text(
                        '${price}g',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EquippedSlotTile extends StatelessWidget {
  const _EquippedSlotTile({required this.slotLabel, required this.item});

  final String slotLabel;
  final DungeonItem? item;

  @override
  Widget build(BuildContext context) {
    final borderColor = item?.rarity.color ?? LifeOsColors.border;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            slotLabel,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w900,
              color: LifeOsColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          if (item != null) ...[
            PixelIcon(item!.iconAsset, size: 32),
            const SizedBox(height: 3),
            Text(
              item!.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: item!.rarity.color,
              ),
            ),
          ] else ...[
            const SizedBox(
              height: 32,
              child: Icon(Icons.add_rounded, size: 20, color: LifeOsColors.textMuted),
            ),
            const SizedBox(height: 3),
            const Text(
              'Vazio',
              style: TextStyle(fontSize: 10, color: LifeOsColors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

