import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/hero_repository.dart';
import '../data/repositories/raid_repository.dart';
import '../data/repositories/task_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final heroRepositoryProvider = Provider<HeroRepository>((ref) {
  return HeroRepository(ref.watch(appDatabaseProvider));
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(heroRepositoryProvider),
  );
});

final raidRepositoryProvider = Provider<RaidRepository>((ref) {
  return RaidRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(heroRepositoryProvider),
  );
});

final heroProfileProvider = StreamProvider<HeroProfile?>((ref) {
  return ref.watch(heroRepositoryProvider).watchHero();
});

final attributeStatsProvider = StreamProvider<List<AttributeStat>>((ref) {
  return ref.watch(heroRepositoryProvider).watchAttributes();
});

final unopenedChestsProvider = StreamProvider<List<MysteryChest>>((ref) {
  return ref.watch(heroRepositoryProvider).watchUnopenedChests();
});

final tasksProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskRepositoryProvider).watchTasks();
});

final raidsProvider = StreamProvider<List<RaidWithEnemies>>((ref) {
  return ref.watch(raidRepositoryProvider).watchRaids();
});
