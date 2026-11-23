import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/theme/lifeos_theme.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import '../hero/hero_sheet_tab.dart';
import '../house/house_tab.dart';
import '../raids/raids_tab.dart';
import '../shop/shop_tab.dart';
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
  int _currentIndex = 0;

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
    final unopenedChests =
        ref.watch(unopenedChestsProvider).value?.length ?? 0;

    final pages = [
      TodayTab(hero: hero),
      RaidsTab(hero: hero),
      HouseTab(hero: hero),
      ShopTab(hero: hero),
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
