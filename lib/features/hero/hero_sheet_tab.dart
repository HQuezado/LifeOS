import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';

/// Aba "Herói": Ficha RPG completa com Nível Geral, Baús Misteriosos e os 5 Atributos.
class HeroSheetTab extends ConsumerWidget {
  const HeroSheetTab({
    super.key,
    required this.hero,
    required this.onExitToTitle,
  });

  final HeroProfile hero;
  final VoidCallback onExitToTitle;

  Future<void> _openChest(
    BuildContext context,
    WidgetRef ref,
    MysteryChest chest,
  ) async {
    final result = await ref.read(heroRepositoryProvider).openChest(chest.id);
    if (result == null || !context.mounted) return;

    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          borderColor: LifeOsColors.gold,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PixelIcon('assets/images/ui/icon_chest.png', size: 52),
              const SizedBox(height: 10),
              Text(
                '${result.rarity.label.toUpperCase()} ABERTO!',
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(
                  size: 11,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '+${result.gold} Ouro   •   +${result.xp} XP Geral',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: LifeOsColors.xpBar,
                ),
              ),
              if (result.heroLeveledUp) ...[
                const SizedBox(height: 8),
                const Text(
                  '★ LEVEL UP! +50 Ouro extra!',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: LifeOsColors.gold,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              PixelButton(
                label: 'COLETAR',
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final attributesAsync = ref.watch(attributeStatsProvider);
    final chestsAsync = ref.watch(unopenedChestsProvider);
    final nextHeroXp = RpgProgression.xpForNextHeroLevel(hero.level);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Cartão principal do Herói
        PixelPanel(
          borderColor: heroClass.accentColor,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: LifeOsColors.bgDark,
                      border: Border.all(
                        color: heroClass.accentColor,
                        width: 2,
                      ),
                    ),
                    child: HeroSpriteWidget(
                      assetPath: heroClass.spriteAsset,
                      size: 74,
                      armorTint: ArmorTint.fromKey(hero.armorTint),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hero.name,
                          style: LifeOsTheme.pixelTitle(
                            size: 14,
                            color: LifeOsColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${heroClass.name} • ${heroClass.title}',
                          style: TextStyle(
                            color: heroClass.accentColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _StatBadge(
                              icon: Icons.star_rounded,
                              label: 'NV. ${hero.level}',
                              color: LifeOsColors.xpBar,
                            ),
                            const SizedBox(width: 8),
                            _StatBadge(
                              leading: const PixelIcon(
                                'assets/images/ui/icon_coin.png',
                                size: 15,
                              ),
                              label: '${hero.gold} Ouro',
                              color: LifeOsColors.gold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'XP Geral',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: LifeOsColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${hero.currentXp} / $nextHeroXp XP',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: LifeOsColors.xpBar,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              PixelProgressBar(
                current: hero.currentXp,
                max: nextHeroXp,
                fillColor: LifeOsColors.xpBar,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Baús Misteriosos aguardando abertura
        chestsAsync.when(
          data: (chests) {
            if (chests.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PixelPanel(
                borderColor: LifeOsColors.gold,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BAÚS MISTERIOSOS (${chests.length})',
                      style: LifeOsTheme.pixelTitle(
                        size: 10,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...chests.map((chest) {
                      final rarity = ChestRarity.fromKey(chest.rarity);
                      final color = switch (rarity) {
                        ChestRarity.epic => const Color(0xFFD97BFF),
                        ChestRarity.rare => LifeOsColors.xpBar,
                        ChestRarity.common => LifeOsColors.gold,
                      };
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const PixelIcon(
                              'assets/images/ui/icon_chest.png',
                              size: 28,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rarity.label,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: color,
                                    ),
                                  ),
                                  Text(
                                    chest.source,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: LifeOsColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => _openChest(context, ref, chest),
                              style: TextButton.styleFrom(
                                backgroundColor: color.withValues(alpha: 0.18),
                                foregroundColor: color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: color, width: 1.5),
                                ),
                              ),
                              child: const Text(
                                'ABRIR',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),

        // Passiva e Habilidade da Classe
        PixelPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PODERES DA CLASSE',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Passiva: ${heroClass.passiveDescription}',
                style: const TextStyle(fontSize: 13.5, height: 1.35),
              ),
              const SizedBox(height: 8),
              Text(
                '${heroClass.abilityName}: ${heroClass.abilityDescription}',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: LifeOsColors.textSecondary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Os 5 Atributos
        Text(
          'ATRIBUTOS (EVOLUEM POR ATIVIDADE)',
          style: LifeOsTheme.pixelTitle(
            size: 10,
            color: LifeOsColors.gold,
          ),
        ),
        const SizedBox(height: 10),
        attributesAsync.when(
          data: (stats) => Column(
            children: stats.map((stat) {
              final meta = RpgAttribute.fromKey(stat.attributeKey);
              final isPrimary = meta == heroClass.primaryAttribute;
              final nextAttrXp =
                  RpgProgression.xpForNextAttributeLevel(stat.level);

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PixelPanel(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  borderColor:
                      isPrimary ? meta.color : LifeOsColors.border,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(meta.icon, color: meta.color, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${meta.name} (${meta.shortName})${isPrimary ? ' ★' : ''}',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: meta.color,
                              ),
                            ),
                          ),
                          Text(
                            'Nv. ${stat.level}',
                            style: LifeOsTheme.pixelTitle(
                              size: 10,
                              color: LifeOsColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      PixelProgressBar(
                        current: stat.currentXp,
                        max: nextAttrXp,
                        fillColor: meta.color,
                        height: 12,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              meta.mechanicalBonus,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: LifeOsColors.textSecondary,
                              ),
                            ),
                          ),
                          Text(
                            '${stat.currentXp}/$nextAttrXp XP',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: LifeOsColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Erro ao carregar atributos: $e'),
        ),
        const SizedBox(height: 18),

        // Sincronização Google & Backup Local (.json)
        PixelPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GOOGLE SYNC & BACKUP LOCAL',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.xpBar,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Save 100% local. Sincronize Agenda/Tasks ou faça backup em JSON.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: LifeOsColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final res = await ref
                            .read(googleSyncServiceProvider)
                            .connectAndSyncToday();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res.message)),
                          );
                        }
                      },
                      icon: const Icon(Icons.sync_rounded, size: 17),
                      label: const Text('Sync Google'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final jsonStr = await ref
                            .read(googleSyncServiceProvider)
                            .exportSaveJson();
                        await Clipboard.setData(ClipboardData(text: jsonStr));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Backup JSON copiado para a área de transferência!',
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.download_rounded, size: 17),
                      label: const Text('Exportar JSON'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _openImportDialog(context, ref),
                  icon: const Icon(Icons.upload_rounded, size: 17),
                  label: const Text('Restaurar Save (Importar JSON)'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Personalização de cor da armadura / manto
        PixelPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COR DA ARMADURA / MANTO',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ArmorTint.values.map((tint) {
                  final active = tint.key == hero.armorTint;
                  return GestureDetector(
                    onTap: () =>
                        ref.read(heroRepositoryProvider).updateArmorTint(tint),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? tint.swatch.withValues(alpha: 0.25)
                            : LifeOsColors.bgDark,
                        border: Border.all(
                          color: active ? LifeOsColors.gold : tint.swatch,
                          width: active ? 2 : 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 11, height: 11, color: tint.swatch),
                          const SizedBox(width: 5),
                          Text(
                            tint.label,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: active
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
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Sair do personagem / voltar para a Tela Inicial
        PixelButton(
          label: 'SAIR PARA TELA INICIAL',
          backgroundColor: LifeOsColors.surface,
          onPressed: onExitToTitle,
        ),
      ],
    );
  }

  void _openImportDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          borderColor: LifeOsColors.xpBar,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESTAURAR BACKUP JSON',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.xpBar,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ctrl,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Cole aqui o JSON exportado do LifeOS...',
                ),
              ),
              const SizedBox(height: 14),
              PixelButton(
                label: 'RESTAURAR SAVE',
                onPressed: () async {
                  final ok = await ref
                      .read(googleSyncServiceProvider)
                      .importSaveJson(ctrl.text);
                  if (ctx.mounted) Navigator.of(ctx).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ok
                              ? 'Save restaurado com sucesso!'
                              : 'JSON inválido. Verifique o conteúdo colado.',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    this.icon,
    this.leading,
    required this.label,
    required this.color,
  });

  final IconData? icon;
  final Widget? leading;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null)
            leading!
          else if (icon != null)
            Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

