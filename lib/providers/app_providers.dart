import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/hero_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final heroRepositoryProvider = Provider<HeroRepository>((ref) {
  return HeroRepository(ref.watch(appDatabaseProvider));
});

final heroProfileProvider = StreamProvider<HeroProfile?>((ref) {
  return ref.watch(heroRepositoryProvider).watchHero();
});

final attributeStatsProvider = StreamProvider<List<AttributeStat>>((ref) {
  return ref.watch(heroRepositoryProvider).watchAttributes();
});

