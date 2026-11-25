import 'package:material_ui/material_ui.dart';

import '../../core/dungeon/dungeon_catalog.dart';
import '../../core/dungeon/dungeon_models.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';

/// Aba **Bestiário Colecionável**: exibe os 30 monstros dos 5 biomas,
/// desbloqueando arte colorida, atributos e ataques conforme você os derrota!
class BestiaryView extends StatefulWidget {
  const BestiaryView({
    super.key,
    required this.catalog,
    required this.discoveries,
  });

  final DungeonCatalog catalog;
  final List<BestiaryDiscovery> discoveries;

  @override
  State<BestiaryView> createState() => _BestiaryViewState();
}

class _BestiaryViewState extends State<BestiaryView> {
  DungeonBiome? _biomeFilter; // null = todos os biomas

  @override
  Widget build(BuildContext context) {
    final discoveryMap = {
      for (final d in widget.discoveries) d.monsterId: d,
    };

    final totalMonsters = widget.catalog.monsters.length;
    final discoveredTotal = widget.catalog.monsters
        .where((m) => discoveryMap.containsKey(m.id))
        .length;

    final visibleMonsters = widget.catalog.monsters
        .where((m) => _biomeFilter == null || m.biome == _biomeFilter)
        .toList();

    return Column(
      children: [
        // Progresso da coleção
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: PixelPanel(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_stories_rounded,
                      color: LifeOsColors.gold,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'BESTIÁRIO: $discoveredTotal / $totalMonsters DESCOBERTOS',
                        style: LifeOsTheme.pixelTitle(
                          size: 9,
                          color: LifeOsColors.gold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                PixelProgressBar(
                  current: discoveredTotal,
                  max: totalMonsters,
                  fillColor: LifeOsColors.gold,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        // Filtros por bioma
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChoiceChip(
                  label: const Text('Todos'),
                  selected: _biomeFilter == null,
                  onSelected: (_) => setState(() => _biomeFilter = null),
                ),
              ),
              for (final biome in DungeonBiome.values)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(biome.name.split(' ').first),
                    selected: _biomeFilter == biome,
                    onSelected: (_) => setState(() => _biomeFilter = biome),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Grade 2 colunas de criaturas
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 28),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.88,
            ),
            itemCount: visibleMonsters.length,
            itemBuilder: (_, idx) {
              final monster = visibleMonsters[idx];
              final disc = discoveryMap[monster.id];
              final unlocked = disc != null;

              return GestureDetector(
                onTap: unlocked
                    ? () => _showMonsterSheet(context, monster, disc)
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: LifeOsColors.surface,
                    border: Border.all(
                      color: unlocked
                          ? (monster.isBoss
                              ? LifeOsColors.gold
                              : monster.biome.accentColor)
                          : LifeOsColors.border,
                      width: unlocked && monster.isBoss ? 2 : 1.4,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            monster.isBoss ? '👑 BOSS' : 'Andar ${monster.minFloor}+',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              color: monster.isBoss
                                  ? LifeOsColors.gold
                                  : LifeOsColors.textMuted,
                            ),
                          ),
                          if (unlocked)
                            Text(
                              '${disc.defeatedCount}x',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: LifeOsColors.xpBar,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Center(
                          child: unlocked
                              ? Image.asset(
                                  monster.spriteAsset,
                                  width: 78,
                                  height: 78,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.none,
                                )
                              : ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF0A0706),
                                    BlendMode.srcIn,
                                  ),
                                  child: Opacity(
                                    opacity: 0.72,
                                    child: Image.asset(
                                      monster.spriteAsset,
                                      width: 74,
                                      height: 74,
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.none,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        unlocked ? monster.name : '???',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: unlocked
                              ? LifeOsColors.textPrimary
                              : LifeOsColors.textMuted,
                        ),
                      ),
                      Text(
                        monster.biome.name.split(' ').first,
                        style: TextStyle(
                          fontSize: 10,
                          color: monster.biome.accentColor.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showMonsterSheet(
    BuildContext context,
    MonsterTemplate monster,
    BestiaryDiscovery disc,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          borderColor:
              monster.isBoss ? LifeOsColors.gold : monster.biome.accentColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  monster.spriteAsset,
                  width: 96,
                  height: 96,
                  filterQuality: FilterQuality.none,
                ),
                const SizedBox(height: 8),
                Text(
                  '${monster.isBoss ? '👑 ' : ''}${monster.name.toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: monster.isBoss
                        ? LifeOsColors.gold
                        : monster.biome.accentColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${monster.biome.name} • Vencido ${disc.defeatedCount}x',
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: LifeOsColors.xpBar,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  monster.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: LifeOsColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: RpgAttribute.values.map((attr) {
                    final val = monster.stats[attr] ?? 1;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: attr.color.withValues(alpha: 0.16),
                        border: Border.all(color: attr.color),
                      ),
                      child: Text(
                        '${attr.shortName} $val',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: attr.color,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ATAQUES CONHECIDOS',
                    style: LifeOsTheme.pixelTitle(
                      size: 8.5,
                      color: LifeOsColors.gold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                for (final atk in monster.attacks)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: LifeOsColors.bgDark,
                      border: Border.all(color: LifeOsColors.border),
                    ),
                    child: Text(
                      '${atk.isMagic ? '✨' : '⚔️'} ${atk.name} (${atk.multiplier}x • Alcance ${atk.range}${atk.effect != null ? ' • ${atk.effect}' : ''})',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: LifeOsColors.textPrimary,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                PixelButton(
                  label: 'FECHAR',
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

