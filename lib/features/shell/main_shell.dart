import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import '../guide/guide_screen.dart';
import '../hero/hero_sheet_tab.dart';
import '../house/house_tab.dart';
import '../raids/raids_tab.dart';
import '../shop/shop_tab.dart';
import '../today/today_tab.dart';

/// Navegação principal em 5 abas com ícones Pixel Art 16-bit:
/// Hoje | Raids | Casa | Loja | Herói
class MainShell extends ConsumerStatefulWidget {
  const MainShell({
    super.key,
    required this.hero,
    required this.onExitToTitle,
  });

  final HeroProfile hero;
  final VoidCallback onExitToTitle;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;

  static const _titles = [
    'HOJE',
    'RAIDS',
    'CASA',
    'LOJA',
    'HERÓI',
  ];

  static const _navItems = [
    (label: 'Hoje', asset: 'assets/images/ui/nav_today.png'),
    (label: 'Raids', asset: 'assets/images/ui/nav_raids.png'),
    (label: 'Casa', asset: 'assets/images/ui/nav_house.png'),
    (label: 'Loja', asset: 'assets/images/ui/nav_shop.png'),
    (label: 'Herói', asset: 'assets/images/ui/nav_hero.png'),
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
      HeroSheetTab(hero: hero, onExitToTitle: widget.onExitToTitle),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PixelIcon(_navItems[_currentIndex].asset, size: 22),
            const SizedBox(width: 10),
            Text(_titles[_currentIndex]),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const GuideScreen()),
              );
            },
            tooltip: 'Guia do Aventureiro',
            icon: const Icon(
              Icons.menu_book_rounded,
              color: LifeOsColors.textSecondary,
              size: 21,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ui/button_slate.png'),
                    centerSlice: Rect.fromLTWH(16, 12, 64, 16),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PixelIcon('assets/images/ui/icon_coin.png', size: 18),
                    const SizedBox(width: 6),
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
          color: LifeOsColors.surface,
          border: Border(
            top: BorderSide(color: LifeOsColors.goldDark, width: 2.5),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final selected = i == _currentIndex;
                final showChestBadge = i == 4 && unopenedChests > 0;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _currentIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: selected
                          ? BoxDecoration(
                              color: LifeOsColors.bgDark,
                              border: Border.all(
                                color: LifeOsColors.gold,
                                width: 1.5,
                              ),
                            )
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Badge(
                            isLabelVisible: showChestBadge,
                            label: Text('$unopenedChests'),
                            backgroundColor: LifeOsColors.gold,
                            textColor: LifeOsColors.bgDark,
                            child: PixelIcon(
                              item.asset,
                              size: selected ? 28 : 24,
                              opacity: selected ? 1.0 : 0.72,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  selected ? FontWeight.w900 : FontWeight.w600,
                              color: selected
                                  ? LifeOsColors.gold
                                  : LifeOsColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
