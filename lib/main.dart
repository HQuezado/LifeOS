import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/theme/lifeos_theme.dart';
import 'features/character_creation/character_creation_screen.dart';
import 'features/shell/main_shell.dart';
import 'features/title/title_screen.dart';
import 'providers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: LifeOsApp()));
}

class LifeOsApp extends ConsumerStatefulWidget {
  const LifeOsApp({super.key});

  @override
  ConsumerState<LifeOsApp> createState() => _LifeOsAppState();
}

class _LifeOsAppState extends ConsumerState<LifeOsApp> {
  bool _inGame = false;

  @override
  Widget build(BuildContext context) {
    final heroAsync = ref.watch(heroProfileProvider);

    return MaterialApp(
      title: 'LifeOS',
      debugShowCheckedModeBanner: false,
      theme: LifeOsTheme.build(),
      home: heroAsync.when(
        data: (hero) {
          if (!_inGame) {
            return TitleScreen(
              hero: hero,
              onContinue: () => setState(() => _inGame = true),
              onNewHero: () => setState(() => _inGame = true),
            );
          }
          if (hero == null) {
            return const CharacterCreationScreen();
          }
          return MainShell(
            hero: hero,
            onExitToTitle: () => setState(() => _inGame = false),
          );
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: LifeOsColors.gold),
          ),
        ),
        error: (error, _) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Erro ao abrir o banco local: $error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
