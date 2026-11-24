import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/rpg/shop_catalog.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';

/// Aba "Casa Viva": cenário 16-bit que evolui em 4 estágios e exibe os móveis
/// comprados (com passivas reais), equipamentos ativos e pet companheiro.
class HouseTab extends ConsumerWidget {
  const HouseTab({super.key, required this.hero});

  final HeroProfile hero;

  static ({String nextName, int nextLevel})? _nextStage(int level) {
    if (level < 5) return (nextName: 'Casa de Madeira', nextLevel: 5);
    if (level < 10) return (nextName: 'Mansão do Aventureiro', nextLevel: 10);
    if (level < 20) return (nextName: 'Santuário Lendário', nextLevel: 20);
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final stageName = RpgProgression.houseStageName(hero.level);
    final nextStage = _nextStage(hero.level);
    final owned = ref.watch(ownedItemsProvider).value ?? [];

    final ownedFurniture = owned
        .where((o) => o.category == ShopCategory.furniture.key)
        .map((o) => ShopCatalog.byId(o.itemId))
        .whereType<ShopItem>()
        .toList();

    final equippedGear = owned
        .where((o) =>
            o.category == ShopCategory.equipment.key && o.isEquipped)
        .map((o) => ShopCatalog.byId(o.itemId))
        .whereType<ShopItem>()
        .toList();

    final equippedPet = equippedGear
        .where((i) => i.slot == EquipmentSlot.pet)
        .firstOrNull;

    final equippedScene = equippedGear
        .where((i) => i.slot == EquipmentSlot.scene)
        .firstOrNull;

    final sceneAsset = switch (equippedScene?.id) {
      'scene_tavern' => 'assets/images/scenes/tavern.png',
      'scene_tower' => 'assets/images/scenes/tower.png',
      'scene_greenhouse' => 'assets/images/scenes/greenhouse.png',
      'scene_sanctuary' => 'assets/images/scenes/sanctuary.png',
      _ => 'assets/images/scenes/cabin.png',
    };

    final sceneGradient = switch (equippedScene?.id) {
      'scene_tavern' => const [Color(0xFF2E1E1A), Color(0xFF472B1F)],
      'scene_tower' => const [Color(0xFF191D3A), Color(0xFF2C234B)],
      'scene_greenhouse' => const [Color(0xFF192E27), Color(0xFF244033)],
      'scene_sanctuary' => const [Color(0xFF23183A), Color(0xFF3A244D)],
      _ => const [Color(0xFF1A1C2C), Color(0xFF242130)],
    };

    final isAlchemist = heroClass == HeroClass.alchemist;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Cenário Visual da Casa Viva
        PixelPanel(
          borderColor: LifeOsColors.gold,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stageName.toUpperCase(),
                    style: LifeOsTheme.pixelTitle(
                      size: 11,
                      color: LifeOsColors.gold,
                    ),
                  ),
                  Text(
                    '${ownedFurniture.length}/${ShopCatalog.byCategory(ShopCategory.furniture).length} móveis',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: LifeOsColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Sala 16-bit (usa cenário Pixel Art em assets/images/scenes/ se existir, ou gradiente temático)
              ClipRect(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: sceneGradient,
                    ),
                    border: Border.all(color: LifeOsColors.border, width: 2),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          sceneAsset,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.none,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.12),
                              Colors.black.withValues(alpha: 0.45),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            if (ownedFurniture.isNotEmpty) ...[
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                alignment: WrapAlignment.center,
                                children: ownedFurniture.map((f) {
                                  return Tooltip(
                                    message: '${f.name}: ${f.effectBadge}',
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: LifeOsColors.bgDark
                                            .withValues(alpha: 0.8),
                                        border: Border.all(
                                          color: f.color,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Icon(
                                        f.icon,
                                        color: f.color,
                                        size: 22,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                HeroSpriteWidget(
                                  assetPath: heroClass.spriteAsset,
                                  size: 96,
                                ),
                                if (equippedPet != null) ...[
                                  const SizedBox(width: 14),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: LifeOsColors.bgDark,
                                          border: Border.all(
                                            color: equippedPet.color,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          equippedPet.icon,
                                          color: equippedPet.color,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        equippedPet.name.split(' ').first,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: equippedPet.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: const Color(0xFF4A362C),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              equippedScene != null
                                  ? equippedScene.name
                                  : (nextStage != null
                                      ? 'Próxima evolução: ${nextStage.nextName} (Nv. ${nextStage.nextLevel})'
                                      : 'Sua Casa alcançou o estágio máximo!'),
                              style: const TextStyle(
                                fontSize: 12,
                                color: LifeOsColors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Equipamentos & Pets ativos
        if (equippedGear.isNotEmpty) ...[
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EQUIPADO NO HERÓI',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.xpBar,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: equippedGear.map((g) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: g.color.withValues(alpha: 0.16),
                        border: Border.all(color: g.color, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(g.icon, size: 16, color: g.color),
                          const SizedBox(width: 6),
                          Text(
                            g.name,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: g.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Passivas reais dos móveis comprados
        PixelPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'PASSIVAS ATIVAS DA CASA',
                      style: LifeOsTheme.pixelTitle(
                        size: 10,
                        color: LifeOsColors.gold,
                      ),
                    ),
                  ),
                  if (isAlchemist)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      color: const Color(0xFF3B9D9C).withValues(alpha: 0.25),
                      child: const Text(
                        'Alquimista +20%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF73EFF7),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (ownedFurniture.isEmpty)
                const Text(
                  'Você ainda não comprou móveis. Visite a aba Loja para adicionar Horta, Escrivaninha Arcana, Lareira e desbloquear bônus passivos reais!',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: LifeOsColors.textSecondary,
                    height: 1.4,
                  ),
                )
              else
                ...ownedFurniture.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(f.icon, size: 18, color: f.color),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${f.name}: ${f.effectBadge}',
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

