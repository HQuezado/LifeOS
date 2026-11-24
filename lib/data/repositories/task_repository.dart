import 'package:drift/drift.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../database/app_database.dart';
import 'hero_repository.dart';
import 'shop_repository.dart';

class TaskRepository {
  TaskRepository(
    this._db,
    this._heroRepository,
    this._shopRepository, [
    RewardEngine? rewardEngine,
  ]) : _rewardEngine = rewardEngine ?? RewardEngine();

  final AppDatabase _db;
  final HeroRepository _heroRepository;
  final ShopRepository _shopRepository;
  final RewardEngine _rewardEngine;

  /// Observa todas as tarefas (pendentes primeiro, depois concluídas mais recentes).
  Stream<List<Task>> watchTasks() {
    return (_db.select(_db.tasks)
          ..orderBy([
            (t) => OrderingTerm.asc(t.isCompleted),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  /// Conta quantas micro-tarefas foram concluídas hoje.
  Future<int> countMicroTasksCompletedToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final rows = await (_db.select(_db.tasks)
          ..where((t) =>
              t.isCompleted.equals(true) &
              t.difficulty.equals(TaskDifficulty.micro.key) &
              t.completedAt.isBiggerOrEqualValue(startOfDay)))
        .get();
    return rows.length;
  }

  /// Conta total de tarefas concluídas hoje.
  Future<int> countTasksCompletedToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final rows = await (_db.select(_db.tasks)
          ..where((t) =>
              t.isCompleted.equals(true) &
              t.completedAt.isBiggerOrEqualValue(startOfDay)))
        .get();
    return rows.length;
  }

  Future<void> addTask({
    required String title,
    required RpgAttribute attribute,
    required TaskDifficulty difficulty,
  }) async {
    await _db.into(_db.tasks).insert(
          TasksCompanion.insert(
            title: title.trim(),
            attributeKey: attribute.key,
            difficulty: Value(difficulty.key),
          ),
        );
  }

  Future<void> deleteTask(int id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  /// Permite ao usuário editar o atributo de qualquer tarefa (local ou do Google Tasks).
  Future<void> updateTaskAttribute(int id, RpgAttribute attribute) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(attributeKey: Value(attribute.key)),
    );
  }

  /// Permite ao usuário editar a dificuldade de uma tarefa pendente.
  Future<void> updateTaskDifficulty(int id, TaskDifficulty difficulty) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(difficulty: Value(difficulty.key)),
    );
  }

  /// Conclui uma tarefa, aplica todas as regras RPG/TDAH e retorna o resultado.
  Future<RewardOutcome?> completeTask(
    int taskId, {
    bool flashMissionActive = false,
  }) async {
    final task = await (_db.select(_db.tasks)
          ..where((t) => t.id.equals(taskId)))
        .getSingleOrNull();
    if (task == null || task.isCompleted) return null;

    final hero = await _heroRepository.getHero();
    if (hero == null) return null;

    final attribute = RpgAttribute.fromKey(task.attributeKey);
    final difficulty = TaskDifficulty.values.firstWhere(
      (d) => d.key == task.difficulty,
      orElse: () => TaskDifficulty.easy,
    );
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final attrLevels = await _heroRepository.getAttributeLevelsMap();
    final microToday = await countMicroTasksCompletedToday();
    final totalToday = await countTasksCompletedToday();
    final energyActive = HeroRepository.isEnergyModeActive(hero);
    final focusPotionActive = ShopRepository.isFocusPotionActive(hero);
    final furnitureIds = await _shopRepository.getOwnedFurnitureIds();

    final outcome = _rewardEngine.calculateTaskReward(
      difficulty: difficulty,
      attribute: attribute,
      heroClass: heroClass,
      attributeLevels: attrLevels,
      energyModeActive: energyActive,
      microTasksCompletedTodayBeforeThis: microToday,
      totalTasksCompletedTodayBeforeThis: totalToday,
      bardInspirationActive: hero.bardInspirationActive,
      flashMissionActive: flashMissionActive,
      focusPotionActive: focusPotionActive,
      ownedFurnitureIds: furnitureIds,
    );

    // Atualiza estado da Inspiração do Bardo
    bool? nextBardInspiration;
    if (heroClass == HeroClass.bard && attribute == RpgAttribute.charisma) {
      nextBardInspiration = true;
    } else if (hero.bardInspirationActive && attribute != RpgAttribute.charisma) {
      nextBardInspiration = false;
    }

    await (_db.update(_db.tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );

    final progress = await _heroRepository.awardProgress(
      attribute: attribute,
      xpGained: outcome.xpGained,
      goldGained: outcome.goldGained,
      droppedChest: outcome.droppedChest,
      chestSource: 'Tarefa: ${task.title}',
      setBardInspiration: nextBardInspiration,
    );
    await _heroRepository.awardExpeditionKey();

    return outcome.copyWith(
      heroLeveledUp: progress.heroLeveledUp,
      attributeLeveledUp: progress.attributeLeveledUp,
    );
  }
}

