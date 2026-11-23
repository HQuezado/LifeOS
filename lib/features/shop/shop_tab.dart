import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/rpg/shop_catalog.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/shop_repository.dart';
import '../../providers/app_providers.dart';

class ShopTab extends ConsumerStatefulWidget {
  const ShopTab({super.key, required this.hero});

  final HeroProfile hero;

  @override
  ConsumerState<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends ConsumerState<ShopTab> {
  ShopCategory _selectedCategory = ShopCategory.furniture;

  Future<void> _buyOrEquip(ShopItem item, OwnedItem? owned) async {
    if (owned != null) {
      if (item.category == ShopCategory.equipment) {
        await ref.read(shopRepositoryProvider).toggleEquip(item);
      }
      return;
    }

    if (item.id == 'cons_reclass_scroll') {
      _openReclassDialog();
      return;
    }

    final result = await ref.read(shopRepositoryProvider).purchaseItem(item);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            result.ok ? const Color(0xFF1F382A) : const Color(0xFF3E1E24),
        content: Text(
          result.message,
          style: const TextStyle(color: LifeOsColors.textPrimary),
        ),
      ),
    );
  }

  void _openReclassDialog() {
    final currentClass = HeroClass.fromKey(widget.hero.heroClass);
    var picked = HeroClass.values.firstWhere(
      (c) => c != currentClass,
      orElse: () => HeroClass.warrior,
    );

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          child: PixelPanel(
            borderColor: const Color(0xFFD97BFF),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PERGAMINHO DE RECLASSE',
                  textAlign: TextAlign.center,
                  style: LifeOsTheme.pixelTitle(
                    size: 11,
                    color: const Color(0xFFD97BFF),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Escolha sua nova classe (você mantém seu nível, atributos e itens):',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: LifeOsColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: HeroClass.values
                      .where((c) => c != currentClass)
                      .map((heroClass) {
                    final selected = heroClass == picked;
                    return GestureDetector(
                      onTap: () => setDialogState(() => picked = heroClass),
                      child: Container(
                        width: 82,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: selected
                              ? LifeOsColors.surfaceHighlight
                              : LifeOsColors.bgDark,
                          border: Border.all(
                            color: selected
                                ? LifeOsColors.gold
                                : LifeOsColors.border,
                            width: selected ? 2.5 : 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            HeroSpriteWidget(
                              assetPath: heroClass.spriteAsset,
                              size: 46,
                              animate: selected,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              heroClass.name,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: selected
                                    ? LifeOsColors.gold
                                    : LifeOsColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                PixelButton(
                  label: 'TROCAR PARA ${picked.name.toUpperCase()}',
                  onPressed: () async {
                    final res = await ref
                        .read(shopRepositoryProvider)
                        .purchaseReclass(picked);
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res.message)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final ownedList = ref.watch(ownedItemsProvider).value ?? [];
    final ownedMap = {for (final o in ownedList) o.itemId: o};
    final attrs = ref.watch(attributeStatsProvider).value ?? [];
    final carLevel = attrs
            .where((a) => a.attributeKey == RpgAttribute.charisma.key)
            .firstOrNull
            ?.level ??
        1;
    final discountPct = (ShopCatalog.discountRate(
              heroClass: heroClass,
              charismaLevel: carLevel,
            ) *
            100)
        .round();
    final focusActive = ShopRepository.isFocusPotionActive(hero);

    final items = ShopCatalog.byCategory(_selectedCategory);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Banner de status da Loja (Desconto + Poção de Foco)
        if (discountPct > 0 || focusActive) ...[
          PixelPanel(
            padding: const EdgeInsets.all(10),
            borderColor: focusActive ? LifeOsColors.xpBar : LifeOsColors.gold,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (discountPct > 0)
                  Row(
                    children: [
                      const Icon(
                        Icons.local_offer_rounded,
                        size: 16,
                        color: LifeOsColors.gold,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Desconto ativo: $discountPct% OFF (${heroClass == HeroClass.bard ? 'Bardo + ' : ''}Carisma Nv. $carLevel)',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: LifeOsColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (focusActive) ...[
                  if (discountPct > 0) const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.science_rounded,
                        size: 16,
                        color: LifeOsColors.xpBar,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Poção de Foco ativa (+25% XP até ${hero.focusPotionUntil!.hour.toString().padLeft(2, '0')}:${hero.focusPotionUntil!.minute.toString().padLeft(2, '0')})',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: LifeOsColors.xpBar,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Seletor das 3 categorias
        Row(
          children: ShopCategory.values.map((cat) {
            final selected = cat == _selectedCategory;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: cat == ShopCategory.values.last ? 0 : 8,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? LifeOsColors.gold.withValues(alpha: 0.2)
                          : LifeOsColors.surface,
                      border: Border.all(
                        color:
                            selected ? LifeOsColors.gold : LifeOsColors.border,
                        width: selected ? 2 : 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cat.label,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: selected
                              ? LifeOsColors.gold
                              : LifeOsColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        // Lista de itens da categoria
        ...items.map((item) {
          final owned = ownedMap[item.id];
          final finalPrice = ShopCatalog.discountedPrice(
            basePrice: item.price,
            heroClass: heroClass,
            charismaLevel: carLevel,
          );
          final lockedByLevel = hero.level < item.minHeroLevel;
          final canAfford = hero.gold >= finalPrice;

          String buttonLabel;
          Color buttonColor;
          if (owned != null) {
            if (item.category == ShopCategory.furniture) {
              buttonLabel = 'NA CASA';
              buttonColor = LifeOsColors.success;
            } else {
              buttonLabel = owned.isEquipped ? 'EQUIPADO' : 'EQUIPAR';
              buttonColor = owned.isEquipped
                  ? LifeOsColors.success
                  : LifeOsColors.xpBar;
            }
          } else if (lockedByLevel) {
            buttonLabel = 'NV. ${item.minHeroLevel}';
            buttonColor = LifeOsColors.textMuted;
          } else {
            buttonLabel = '${finalPrice}g';
            buttonColor =
                canAfford ? LifeOsColors.gold : LifeOsColors.textMuted;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PixelPanel(
              borderColor: owned != null ? item.color : LifeOsColors.border,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: LifeOsColors.bgDark,
                      border: Border.all(color: item.color, width: 2),
                    ),
                    child: Icon(item.icon, color: item.color, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: LifeOsColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          color: item.color.withValues(alpha: 0.16),
                          child: Text(
                            item.effectBadge,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: item.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (owned == null && finalPrice < item.price)
                        Text(
                          '${item.price}g',
                          style: const TextStyle(
                            fontSize: 11,
                            color: LifeOsColors.textMuted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      TextButton(
                        onPressed: (owned != null &&
                                    item.category == ShopCategory.furniture) ||
                                lockedByLevel
                            ? null
                            : () => _buyOrEquip(item, owned),
                        style: TextButton.styleFrom(
                          backgroundColor: buttonColor.withValues(alpha: 0.18),
                          foregroundColor: buttonColor,
                          disabledForegroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: buttonColor, width: 1.5),
                          ),
                        ),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

