import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import '../hero/hero_sheet_tab.dart';
import '../raids/raids_tab.dart';
import '../today/today_tab.dart';

/// Navegação principal em 5 abas definida no DESIGN.md:
/// Hoje | Raids | Casa | Loja | Herói
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key, required this.hero});

  final HeroProfile hero;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0; // Inicia na aba Hoje (atividades e Modo Energia)

  static const _titles = [
    'HOJE',
    'RAIDS',
    'CASA VIVA',
    'LOJA',
    'HERÓI',
  ];

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final unopenedChests =
        ref.watch(unopenedChestsProvider).value?.length ?? 0;

    final pages = [
      TodayTab(hero: hero),
      RaidsTab(hero: hero),
      _HousePreviewTab(hero: hero, heroClass: heroClass),
      _PhasePreviewTab(
        icon: Icons.storefront_rounded,
        badge: 'FASE 3',
        title: 'Loja do Aventureiro',
        description:
            'Gaste seu Ouro acumulado (${hero.gold} Ouro) em melhorias reais para o personagem e para a sua Casa Viva.',
        highlights: const [
          'Móveis com passivas reais (150 a 1.200 Ouro)',
          'Equipamentos, visuais e pets em Pixel Art (100 a 800 Ouro)',
          'Poção de Foco, Baús Misteriosos e Pergaminho de Reclasse',
        ],
      ),
      HeroSheetTab(hero: hero),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: LifeOsColors.surface,
                  border: Border.all(color: LifeOsColors.gold, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.monetization_on_rounded,
                      size: 15,
                      color: LifeOsColors.gold,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${hero.gold}',
                      style: LifeOsTheme.pixelTitle(
                        size: 10,
                        color: LifeOsColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: LifeOsColors.border, width: 2)),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (i) => setState(() => _currentIndex = i),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.today_rounded),
              label: 'Hoje',
            ),
            const NavigationDestination(
              icon: Icon(Icons.shield_rounded),
              label: 'Raids',
            ),
            const NavigationDestination(
              icon: Icon(Icons.cabin_rounded),
              label: 'Casa',
            ),
            const NavigationDestination(
              icon: Icon(Icons.storefront_rounded),
              label: 'Loja',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: unopenedChests > 0,
                label: Text('$unopenedChests'),
                backgroundColor: LifeOsColors.gold,
                textColor: LifeOsColors.bgDark,
                child: const Icon(Icons.person_rounded),
              ),
              label: 'Herói',
            ),
          ],
        ),
      ),
    );
  }
}

class _HousePreviewTab extends StatelessWidget {
  const _HousePreviewTab({required this.hero, required this.heroClass});

  final HeroProfile hero;
  final HeroClass heroClass;

  @override
  Widget build(BuildContext context) {
    final stage = RpgProgression.houseStageName(hero.level);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PixelPanel(
          borderColor: LifeOsColors.gold,
          child: Column(
            children: [
              Text(
                stage.toUpperCase(),
                style: LifeOsTheme.pixelTitle(size: 12, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: LifeOsColors.bgDark,
                  border: Border.all(color: LifeOsColors.border, width: 2),
                ),
                child: Column(
                  children: [
                    HeroSpriteWidget(
                      assetPath: heroClass.spriteAsset,
                      size: 96,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${hero.name} está descansando na $stage',
                      style: const TextStyle(
                        color: LifeOsColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Na Fase 3, sua casa evoluirá visualmente em Pixel Art (Cabana → Casa de Madeira → Mansão → Santuário Lendário) e exibirá os móveis com passivas reais.',
                style: TextStyle(
                  fontSize: 13,
                  color: LifeOsColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhasePreviewTab extends StatelessWidget {
  const _PhasePreviewTab({
    required this.icon,
    required this.badge,
    required this.title,
    required this.description,
    required this.highlights,
  });

  final IconData icon;
  final String badge;
  final String title;
  final String description;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PixelPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: LifeOsColors.gold, size: 28),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    color: LifeOsColors.gold.withValues(alpha: 0.2),
                    child: Text(
                      badge,
                      style: LifeOsTheme.pixelTitle(
                        size: 9,
                        color: LifeOsColors.gold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: LifeOsColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const Divider(height: 24, color: LifeOsColors.border),
              ...highlights.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '▸ ',
                        style: TextStyle(
                          color: LifeOsColors.xpBar,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 13.5),
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

