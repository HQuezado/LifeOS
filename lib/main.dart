import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/lifeos_theme.dart';
import 'features/character_creation/character_creation_screen.dart';
import 'features/shell/main_shell.dart';
import 'providers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: LifeOsApp()));
}

class LifeOsApp extends ConsumerWidget {
  const LifeOsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroAsync = ref.watch(heroProfileProvider);

    return MaterialApp(
      title: 'LifeOS',
      debugShowCheckedModeBanner: false,
      theme: LifeOsTheme.build(),
      home: heroAsync.when(
        data: (hero) {
          if (hero == null) {
            return const CharacterCreationScreen();
          }
          return MainShell(hero: hero);
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
