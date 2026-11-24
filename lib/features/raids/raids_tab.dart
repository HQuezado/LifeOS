import 'package:material_ui/material_ui.dart';

import '../../data/database/app_database.dart';
import '../dungeon/dungeon_hub_tab.dart';

/// Aba **Raids** — agora dedicada às Masmorras Procedurais, Inventário e Ferreiro (Fase 6).
class RaidsTab extends StatelessWidget {
  const RaidsTab({super.key, required this.hero});

  final HeroProfile hero;

  @override
  Widget build(BuildContext context) {
    return DungeonHubTab(hero: hero);
  }
}
