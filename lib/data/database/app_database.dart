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

/// Tarefas e atividades locais (pronto para a Fase 2 e sincronização Google Tasks).
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

@DriftDatabase(tables: [HeroProfiles, AttributeStats, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'lifeos_local_db');
  }
}

