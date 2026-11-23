import 'package:drift/drift.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../database/app_database.dart';
import 'hero_repository.dart';

class RaidWithEnemies {
  const RaidWithEnemies({
    required this.raid,
    required this.enemies,
  });

  final Raid raid;
  final List<RaidEnemy> enemies;

  int get defeatedCount => enemies.where((e) => e.isDefeated).length;
  int get totalCount => enemies.length;

  RaidEnemy? get currentEnemy {
    for (final enemy in enemies) {
      if (!enemy.isDefeated) return enemy;
    }
    return null;
  }
}

class RaidRepository {
  RaidRepository(this._db, this._heroRepository, [RewardEngine? rewardEngine])
      : _rewardEngine = rewardEngine ?? RewardEngine();

  final AppDatabase _db;
  final HeroRepository _heroRepository;
  final RewardEngine _rewardEngine;

  static const _enemyPool = ['slime', 'goblin', 'skeleton', 'orc', 'golem'];

  /// Observa todas as Raids com suas listas de inimigos ordenados.
  Stream<List<RaidWithEnemies>> watchRaids() {
    final raidsStream = (_db.select(_db.raids)
          ..orderBy([
            (t) => OrderingTerm.asc(t.isCompleted),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();

    return raidsStream.asyncMap((raids) async {
      final result = <RaidWithEnemies>[];
      for (final raid in raids) {
        final enemies = await (_db.select(_db.raidEnemies)
              ..where((e) => e.raidId.equals(raid.id))
              ..orderBy([(e) => OrderingTerm.asc(e.sortOrder)]))
            .get();
        result.add(RaidWithEnemies(raid: raid, enemies: enemies));
      }
      return result;
    });
  }

  /// Observa uma única Raid com seus inimigos (para a tela de Batalha).
  Stream<RaidWithEnemies?> watchRaidById(int raidId) {
    final enemiesStream = (_db.select(_db.raidEnemies)
          ..where((e) => e.raidId.equals(raidId))
          ..orderBy([(e) => OrderingTerm.asc(e.sortOrder)]))
        .watch();

    return enemiesStream.asyncMap((enemies) async {
      final raid = await (_db.select(_db.raids)
            ..where((r) => r.id.equals(raidId)))
          .getSingleOrNull();
      if (raid == null) return null;
      return RaidWithEnemies(raid: raid, enemies: enemies);
    });
  }

  /// Cria uma nova Raid com vários inimigos (micro-passos).
  Future<int> createRaid({
    required String title,
    required RpgAttribute attribute,
    required List<String> stepTitles,
  }) async {
    return _db.transaction(() async {
      final raidId = await _db.into(_db.raids).insert(
            RaidsCompanion.insert(
              title: title.trim(),
              attributeKey: attribute.key,
            ),
          );

      final cleanSteps = stepTitles
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      for (var i = 0; i < cleanSteps.length; i++) {
        final isLast = i == cleanSteps.length - 1;
        final enemyType =
            isLast ? 'boss' : _enemyPool[i % _enemyPool.length];
        await _db.into(_db.raidEnemies).insert(
              RaidEnemiesCompanion.insert(
                raidId: raidId,
                title: cleanSteps[i],
                enemyType: Value(enemyType),
                sortOrder: Value(i),
              ),
            );
      }

      return raidId;
    });
  }

  Future<void> deleteRaid(int raidId) async {
    await (_db.delete(_db.raids)..where((r) => r.id.equals(raidId))).go();
  }

  /// Derrota 1 inimigo de Raid e concede XP/Ouro na hora (+ Baú se for o último).
  Future<({RewardOutcome outcome, bool raidCompleted})?> defeatEnemy(
    int enemyId,
  ) async {
    final enemy = await (_db.select(_db.raidEnemies)
          ..where((e) => e.id.equals(enemyId)))
        .getSingleOrNull();
    if (enemy == null || enemy.isDefeated) return null;

    final raid = await (_db.select(_db.raids)
          ..where((r) => r.id.equals(enemy.raidId)))
        .getSingleOrNull();
    if (raid == null) return null;

    final hero = await _heroRepository.getHero();
    if (hero == null) return null;

    // Marca inimigo derrotado
    await (_db.update(_db.raidEnemies)..where((e) => e.id.equals(enemyId)))
        .write(
      RaidEnemiesCompanion(
        isDefeated: const Value(true),
        defeatedAt: Value(DateTime.now()),
      ),
    );

    final remaining = await (_db.select(_db.raidEnemies)
          ..where((e) =>
              e.raidId.equals(raid.id) & e.isDefeated.equals(false)))
        .get();
    final isFinalEnemy = remaining.isEmpty;

    if (isFinalEnemy) {
      await (_db.update(_db.raids)..where((r) => r.id.equals(raid.id))).write(
        RaidsCompanion(
          isCompleted: const Value(true),
          completedAt: Value(DateTime.now()),
        ),
      );
    }

    final heroClass = HeroClass.fromKey(hero.heroClass);
    final attrLevels = await _heroRepository.getAttributeLevelsMap();
    final attribute = RpgAttribute.fromKey(raid.attributeKey);

    final outcome = _rewardEngine.calculateRaidEnemyReward(
      isFinalEnemy: isFinalEnemy,
      heroClass: heroClass,
      attributeLevels: attrLevels,
    );

    final progress = await _heroRepository.awardProgress(
      attribute: attribute,
      xpGained: outcome.xpGained,
      goldGained: outcome.goldGained,
      droppedChest: outcome.droppedChest,
      chestSource: 'Raid concluída: ${raid.title}',
    );

    return (
      outcome: outcome.copyWith(
        heroLeveledUp: progress.heroLeveledUp,
        attributeLeveledUp: progress.attributeLeveledUp,
      ),
      raidCompleted: isFinalEnemy,
    );
  }
}

