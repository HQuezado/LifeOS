import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../hero/hero_sheet_tab.dart';

/// Navegação principal em 5 abas definida no DESIGN.md:
/// Hoje | Raids | Casa | Loja | Herói
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.hero});

  final HeroProfile hero;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 4; // Inicia na aba Herói logo após criar o personagem

  static const _titles = [
    'MAPA DO DIA',
    'RAIDS',
    'CASA VIVA',
    'LOJA',
    'HERÓI',
  ];

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;
    final heroClass = HeroClass.fromKey(hero.heroClass);

    final pages = [
      _PhasePreviewTab(
        icon: Icons.map_rounded,
        badge: 'FASE 2 & 4',
        title: 'Mapa do Dia (Agenda + Tasks)',
        description:
            'Aqui aparecerá sua linha do tempo com compromissos do Google Agenda, tarefas do dia e o botão do Modo Energia / Dia Sem Culpa (1x por semana).',
        highlights: const [
          'Micro-tarefas livres com recomendação gentil após a 10ª no dia',
          'Acertos Críticos (1.5x–2x) e Missões Relâmpago',
          'Sincronização local com Google Agenda & Tasks',
        ],
      ),
      _PhasePreviewTab(
        icon: Icons.shield_rounded,
        badge: 'FASE 2',
        title: 'Sistema de Raids',
        description:
            'Transforme tarefas grandes e assustadoras em uma masmorra com vários inimigos (micro-passos de 2 a 15 min).',
        highlights: const [
          'Cada inimigo derrotado dá +25 XP e +18 Ouro na hora',
          'Limpar toda a Raid concede +80 XP, +60 Ouro e 1 Baú de Raid',
          'Feito para quebrar a paralisia executiva do TDAH',
        ],
      ),
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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.today_rounded),
              label: 'Hoje',
            ),
            NavigationDestination(
              icon: Icon(Icons.shield_rounded),
              label: 'Raids',
            ),
            NavigationDestination(
              icon: Icon(Icons.cabin_rounded),
              label: 'Casa',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_rounded),
              label: 'Loja',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_rounded),
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
                    Image.asset(
                      heroClass.spriteAsset,
                      width: 96,
                      height: 96,
                      filterQuality: FilterQuality.none,
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

