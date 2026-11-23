import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Perfil único do herói salvo 100% localmente no dispositivo.
class HeroProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  TextColumn get heroClass => text()(); // warrior, mage, rogue, alchemist, bard
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentXp => integer().withDefault(const Constant(0))();
  IntColumn get gold => integer().withDefault(const Constant(50))();
  DateTimeColumn get lastEnergyModeAt => dateTime().nullable()();
  DateTimeColumn get energyModeActiveUntil => dateTime().nullable()();
  BoolColumn get bardInspirationActive =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get focusPotionUntil => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Progresso individual de cada um dos 5 atributos (VIG, INT, DES, SAB, CAR).
class AttributeStats extends Table {
  TextColumn get attributeKey => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentXp => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {attributeKey};
}

/// Tarefas e atividades locais vinculadas a um atributo.
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 140)();
  TextColumn get attributeKey => text()(); // VIG, INT, DES, SAB, CAR
  TextColumn get difficulty => text().withDefault(const Constant('easy'))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get googleTaskId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Raids: tarefas maiores quebradas em vários inimigos/ondas.
class Raids extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 140)();
  TextColumn get attributeKey => text()(); // VIG, INT, DES, SAB, CAR
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Inimigos (micro-passos de 2 a 15 min) dentro de uma Raid.
class RaidEnemies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get raidId =>
      integer().references(Raids, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 140)();
  TextColumn get enemyType => text().withDefault(const Constant('slime'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isDefeated => boolean().withDefault(const Constant(false))();
  DateTimeColumn get defeatedAt => dateTime().nullable()();
}

/// Baús Misteriosos (Comum, Raro, Épico) ganhos em Raids, Level Up e sorte.
class MysteryChests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get rarity => text()(); // common, rare, epic
  TextColumn get source => text()();
  BoolColumn get isOpened => boolean().withDefault(const Constant(false))();
  TextColumn get rewardSummary => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Itens permanentes comprados na Loja (Móveis da Casa, Equipamentos e Pets).
class OwnedItems extends Table {
  TextColumn get itemId => text()();
  TextColumn get category => text()(); // furniture, equipment
  BoolColumn get isEquipped => boolean().withDefault(const Constant(true))();
  DateTimeColumn get purchasedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {itemId};
}

@DriftDatabase(
  tables: [
    HeroProfiles,
    AttributeStats,
    Tasks,
    Raids,
    RaidEnemies,
    MysteryChests,
    OwnedItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(heroProfiles, heroProfiles.energyModeActiveUntil);
            await m.addColumn(heroProfiles, heroProfiles.bardInspirationActive);
            await m.createTable(raids);
            await m.createTable(raidEnemies);
            await m.createTable(mysteryChests);
          }
          if (from < 3) {
            await m.addColumn(heroProfiles, heroProfiles.focusPotionUntil);
            await m.createTable(ownedItems);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'lifeos_local_db');
  }
}
