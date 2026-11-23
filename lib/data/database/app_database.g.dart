// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HeroProfilesTable extends HeroProfiles
    with TableInfo<$HeroProfilesTable, HeroProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeroProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heroClassMeta = const VerificationMeta(
    'heroClass',
  );
  @override
  late final GeneratedColumn<String> heroClass = GeneratedColumn<String>(
    'hero_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentXpMeta = const VerificationMeta(
    'currentXp',
  );
  @override
  late final GeneratedColumn<int> currentXp = GeneratedColumn<int>(
    'current_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _lastEnergyModeAtMeta = const VerificationMeta(
    'lastEnergyModeAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastEnergyModeAt =
      GeneratedColumn<DateTime>(
        'last_energy_mode_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    heroClass,
    level,
    currentXp,
    gold,
    lastEnergyModeAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hero_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<HeroProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hero_class')) {
      context.handle(
        _heroClassMeta,
        heroClass.isAcceptableOrUnknown(data['hero_class']!, _heroClassMeta),
      );
    } else if (isInserting) {
      context.missing(_heroClassMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('current_xp')) {
      context.handle(
        _currentXpMeta,
        currentXp.isAcceptableOrUnknown(data['current_xp']!, _currentXpMeta),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    if (data.containsKey('last_energy_mode_at')) {
      context.handle(
        _lastEnergyModeAtMeta,
        lastEnergyModeAt.isAcceptableOrUnknown(
          data['last_energy_mode_at']!,
          _lastEnergyModeAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HeroProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HeroProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      heroClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hero_class'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      currentXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_xp'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
      lastEnergyModeAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_energy_mode_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HeroProfilesTable createAlias(String alias) {
    return $HeroProfilesTable(attachedDatabase, alias);
  }
}

class HeroProfile extends DataClass implements Insertable<HeroProfile> {
  final int id;
  final String name;
  final String heroClass;
  final int level;
  final int currentXp;
  final int gold;
  final DateTime? lastEnergyModeAt;
  final DateTime createdAt;
  const HeroProfile({
    required this.id,
    required this.name,
    required this.heroClass,
    required this.level,
    required this.currentXp,
    required this.gold,
    this.lastEnergyModeAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['hero_class'] = Variable<String>(heroClass);
    map['level'] = Variable<int>(level);
    map['current_xp'] = Variable<int>(currentXp);
    map['gold'] = Variable<int>(gold);
    if (!nullToAbsent || lastEnergyModeAt != null) {
      map['last_energy_mode_at'] = Variable<DateTime>(lastEnergyModeAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HeroProfilesCompanion toCompanion(bool nullToAbsent) {
    return HeroProfilesCompanion(
      id: Value(id),
      name: Value(name),
      heroClass: Value(heroClass),
      level: Value(level),
      currentXp: Value(currentXp),
      gold: Value(gold),
      lastEnergyModeAt: lastEnergyModeAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastEnergyModeAt),
      createdAt: Value(createdAt),
    );
  }

  factory HeroProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HeroProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      heroClass: serializer.fromJson<String>(json['heroClass']),
      level: serializer.fromJson<int>(json['level']),
      currentXp: serializer.fromJson<int>(json['currentXp']),
      gold: serializer.fromJson<int>(json['gold']),
      lastEnergyModeAt: serializer.fromJson<DateTime?>(
        json['lastEnergyModeAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'heroClass': serializer.toJson<String>(heroClass),
      'level': serializer.toJson<int>(level),
      'currentXp': serializer.toJson<int>(currentXp),
      'gold': serializer.toJson<int>(gold),
      'lastEnergyModeAt': serializer.toJson<DateTime?>(lastEnergyModeAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HeroProfile copyWith({
    int? id,
    String? name,
    String? heroClass,
    int? level,
    int? currentXp,
    int? gold,
    Value<DateTime?> lastEnergyModeAt = const Value.absent(),
    DateTime? createdAt,
  }) => HeroProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    heroClass: heroClass ?? this.heroClass,
    level: level ?? this.level,
    currentXp: currentXp ?? this.currentXp,
    gold: gold ?? this.gold,
    lastEnergyModeAt: lastEnergyModeAt.present
        ? lastEnergyModeAt.value
        : this.lastEnergyModeAt,
    createdAt: createdAt ?? this.createdAt,
  );
  HeroProfile copyWithCompanion(HeroProfilesCompanion data) {
    return HeroProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      heroClass: data.heroClass.present ? data.heroClass.value : this.heroClass,
      level: data.level.present ? data.level.value : this.level,
      currentXp: data.currentXp.present ? data.currentXp.value : this.currentXp,
      gold: data.gold.present ? data.gold.value : this.gold,
      lastEnergyModeAt: data.lastEnergyModeAt.present
          ? data.lastEnergyModeAt.value
          : this.lastEnergyModeAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HeroProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('heroClass: $heroClass, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp, ')
          ..write('gold: $gold, ')
          ..write('lastEnergyModeAt: $lastEnergyModeAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    heroClass,
    level,
    currentXp,
    gold,
    lastEnergyModeAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HeroProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.heroClass == this.heroClass &&
          other.level == this.level &&
          other.currentXp == this.currentXp &&
          other.gold == this.gold &&
          other.lastEnergyModeAt == this.lastEnergyModeAt &&
          other.createdAt == this.createdAt);
}

class HeroProfilesCompanion extends UpdateCompanion<HeroProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> heroClass;
  final Value<int> level;
  final Value<int> currentXp;
  final Value<int> gold;
  final Value<DateTime?> lastEnergyModeAt;
  final Value<DateTime> createdAt;
  const HeroProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.heroClass = const Value.absent(),
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.gold = const Value.absent(),
    this.lastEnergyModeAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HeroProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String heroClass,
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.gold = const Value.absent(),
    this.lastEnergyModeAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       heroClass = Value(heroClass);
  static Insertable<HeroProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? heroClass,
    Expression<int>? level,
    Expression<int>? currentXp,
    Expression<int>? gold,
    Expression<DateTime>? lastEnergyModeAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (heroClass != null) 'hero_class': heroClass,
      if (level != null) 'level': level,
      if (currentXp != null) 'current_xp': currentXp,
      if (gold != null) 'gold': gold,
      if (lastEnergyModeAt != null) 'last_energy_mode_at': lastEnergyModeAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HeroProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? heroClass,
    Value<int>? level,
    Value<int>? currentXp,
    Value<int>? gold,
    Value<DateTime?>? lastEnergyModeAt,
    Value<DateTime>? createdAt,
  }) {
    return HeroProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      heroClass: heroClass ?? this.heroClass,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      gold: gold ?? this.gold,
      lastEnergyModeAt: lastEnergyModeAt ?? this.lastEnergyModeAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (heroClass.present) {
      map['hero_class'] = Variable<String>(heroClass.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentXp.present) {
      map['current_xp'] = Variable<int>(currentXp.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (lastEnergyModeAt.present) {
      map['last_energy_mode_at'] = Variable<DateTime>(lastEnergyModeAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeroProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('heroClass: $heroClass, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp, ')
          ..write('gold: $gold, ')
          ..write('lastEnergyModeAt: $lastEnergyModeAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttributeStatsTable extends AttributeStats
    with TableInfo<$AttributeStatsTable, AttributeStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttributeStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attributeKeyMeta = const VerificationMeta(
    'attributeKey',
  );
  @override
  late final GeneratedColumn<String> attributeKey = GeneratedColumn<String>(
    'attribute_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentXpMeta = const VerificationMeta(
    'currentXp',
  );
  @override
  late final GeneratedColumn<int> currentXp = GeneratedColumn<int>(
    'current_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [attributeKey, level, currentXp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attribute_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttributeStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attribute_key')) {
      context.handle(
        _attributeKeyMeta,
        attributeKey.isAcceptableOrUnknown(
          data['attribute_key']!,
          _attributeKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attributeKeyMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('current_xp')) {
      context.handle(
        _currentXpMeta,
        currentXp.isAcceptableOrUnknown(data['current_xp']!, _currentXpMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attributeKey};
  @override
  AttributeStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttributeStat(
      attributeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_key'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      currentXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_xp'],
      )!,
    );
  }

  @override
  $AttributeStatsTable createAlias(String alias) {
    return $AttributeStatsTable(attachedDatabase, alias);
  }
}

class AttributeStat extends DataClass implements Insertable<AttributeStat> {
  final String attributeKey;
  final int level;
  final int currentXp;
  const AttributeStat({
    required this.attributeKey,
    required this.level,
    required this.currentXp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attribute_key'] = Variable<String>(attributeKey);
    map['level'] = Variable<int>(level);
    map['current_xp'] = Variable<int>(currentXp);
    return map;
  }

  AttributeStatsCompanion toCompanion(bool nullToAbsent) {
    return AttributeStatsCompanion(
      attributeKey: Value(attributeKey),
      level: Value(level),
      currentXp: Value(currentXp),
    );
  }

  factory AttributeStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttributeStat(
      attributeKey: serializer.fromJson<String>(json['attributeKey']),
      level: serializer.fromJson<int>(json['level']),
      currentXp: serializer.fromJson<int>(json['currentXp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attributeKey': serializer.toJson<String>(attributeKey),
      'level': serializer.toJson<int>(level),
      'currentXp': serializer.toJson<int>(currentXp),
    };
  }

  AttributeStat copyWith({String? attributeKey, int? level, int? currentXp}) =>
      AttributeStat(
        attributeKey: attributeKey ?? this.attributeKey,
        level: level ?? this.level,
        currentXp: currentXp ?? this.currentXp,
      );
  AttributeStat copyWithCompanion(AttributeStatsCompanion data) {
    return AttributeStat(
      attributeKey: data.attributeKey.present
          ? data.attributeKey.value
          : this.attributeKey,
      level: data.level.present ? data.level.value : this.level,
      currentXp: data.currentXp.present ? data.currentXp.value : this.currentXp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttributeStat(')
          ..write('attributeKey: $attributeKey, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attributeKey, level, currentXp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttributeStat &&
          other.attributeKey == this.attributeKey &&
          other.level == this.level &&
          other.currentXp == this.currentXp);
}

class AttributeStatsCompanion extends UpdateCompanion<AttributeStat> {
  final Value<String> attributeKey;
  final Value<int> level;
  final Value<int> currentXp;
  final Value<int> rowid;
  const AttributeStatsCompanion({
    this.attributeKey = const Value.absent(),
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttributeStatsCompanion.insert({
    required String attributeKey,
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : attributeKey = Value(attributeKey);
  static Insertable<AttributeStat> custom({
    Expression<String>? attributeKey,
    Expression<int>? level,
    Expression<int>? currentXp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attributeKey != null) 'attribute_key': attributeKey,
      if (level != null) 'level': level,
      if (currentXp != null) 'current_xp': currentXp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttributeStatsCompanion copyWith({
    Value<String>? attributeKey,
    Value<int>? level,
    Value<int>? currentXp,
    Value<int>? rowid,
  }) {
    return AttributeStatsCompanion(
      attributeKey: attributeKey ?? this.attributeKey,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attributeKey.present) {
      map['attribute_key'] = Variable<String>(attributeKey.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentXp.present) {
      map['current_xp'] = Variable<int>(currentXp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttributeStatsCompanion(')
          ..write('attributeKey: $attributeKey, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 140,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attributeKeyMeta = const VerificationMeta(
    'attributeKey',
  );
  @override
  late final GeneratedColumn<String> attributeKey = GeneratedColumn<String>(
    'attribute_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('easy'),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _googleTaskIdMeta = const VerificationMeta(
    'googleTaskId',
  );
  @override
  late final GeneratedColumn<String> googleTaskId = GeneratedColumn<String>(
    'google_task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    attributeKey,
    difficulty,
    isCompleted,
    completedAt,
    googleTaskId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('attribute_key')) {
      context.handle(
        _attributeKeyMeta,
        attributeKey.isAcceptableOrUnknown(
          data['attribute_key']!,
          _attributeKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attributeKeyMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('google_task_id')) {
      context.handle(
        _googleTaskIdMeta,
        googleTaskId.isAcceptableOrUnknown(
          data['google_task_id']!,
          _googleTaskIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      attributeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_key'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      googleTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}google_task_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String attributeKey;
  final String difficulty;
  final bool isCompleted;
  final DateTime? completedAt;
  final String? googleTaskId;
  final DateTime createdAt;
  const Task({
    required this.id,
    required this.title,
    required this.attributeKey,
    required this.difficulty,
    required this.isCompleted,
    this.completedAt,
    this.googleTaskId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['attribute_key'] = Variable<String>(attributeKey);
    map['difficulty'] = Variable<String>(difficulty);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || googleTaskId != null) {
      map['google_task_id'] = Variable<String>(googleTaskId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      attributeKey: Value(attributeKey),
      difficulty: Value(difficulty),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      googleTaskId: googleTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(googleTaskId),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      attributeKey: serializer.fromJson<String>(json['attributeKey']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      googleTaskId: serializer.fromJson<String?>(json['googleTaskId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'attributeKey': serializer.toJson<String>(attributeKey),
      'difficulty': serializer.toJson<String>(difficulty),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'googleTaskId': serializer.toJson<String?>(googleTaskId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? attributeKey,
    String? difficulty,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> googleTaskId = const Value.absent(),
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    attributeKey: attributeKey ?? this.attributeKey,
    difficulty: difficulty ?? this.difficulty,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    googleTaskId: googleTaskId.present ? googleTaskId.value : this.googleTaskId,
    createdAt: createdAt ?? this.createdAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      attributeKey: data.attributeKey.present
          ? data.attributeKey.value
          : this.attributeKey,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      googleTaskId: data.googleTaskId.present
          ? data.googleTaskId.value
          : this.googleTaskId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('googleTaskId: $googleTaskId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    attributeKey,
    difficulty,
    isCompleted,
    completedAt,
    googleTaskId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.attributeKey == this.attributeKey &&
          other.difficulty == this.difficulty &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.googleTaskId == this.googleTaskId &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> attributeKey;
  final Value<String> difficulty;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<String?> googleTaskId;
  final Value<DateTime> createdAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.attributeKey = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.googleTaskId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String attributeKey,
    this.difficulty = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.googleTaskId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       attributeKey = Value(attributeKey);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? attributeKey,
    Expression<String>? difficulty,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<String>? googleTaskId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (attributeKey != null) 'attribute_key': attributeKey,
      if (difficulty != null) 'difficulty': difficulty,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (googleTaskId != null) 'google_task_id': googleTaskId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? attributeKey,
    Value<String>? difficulty,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<String?>? googleTaskId,
    Value<DateTime>? createdAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      attributeKey: attributeKey ?? this.attributeKey,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      googleTaskId: googleTaskId ?? this.googleTaskId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (attributeKey.present) {
      map['attribute_key'] = Variable<String>(attributeKey.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (googleTaskId.present) {
      map['google_task_id'] = Variable<String>(googleTaskId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('googleTaskId: $googleTaskId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HeroProfilesTable heroProfiles = $HeroProfilesTable(this);
  late final $AttributeStatsTable attributeStats = $AttributeStatsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    heroProfiles,
    attributeStats,
    tasks,
  ];
}

typedef $$HeroProfilesTableCreateCompanionBuilder =
    HeroProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String heroClass,
      Value<int> level,
      Value<int> currentXp,
      Value<int> gold,
      Value<DateTime?> lastEnergyModeAt,
      Value<DateTime> createdAt,
    });
typedef $$HeroProfilesTableUpdateCompanionBuilder =
    HeroProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> heroClass,
      Value<int> level,
      Value<int> currentXp,
      Value<int> gold,
      Value<DateTime?> lastEnergyModeAt,
      Value<DateTime> createdAt,
    });

class $$HeroProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $HeroProfilesTable> {
  $$HeroProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heroClass => $composableBuilder(
    column: $table.heroClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentXp => $composableBuilder(
    column: $table.currentXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEnergyModeAt => $composableBuilder(
    column: $table.lastEnergyModeAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HeroProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $HeroProfilesTable> {
  $$HeroProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heroClass => $composableBuilder(
    column: $table.heroClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentXp => $composableBuilder(
    column: $table.currentXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEnergyModeAt => $composableBuilder(
    column: $table.lastEnergyModeAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HeroProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HeroProfilesTable> {
  $$HeroProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get heroClass =>
      $composableBuilder(column: $table.heroClass, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentXp =>
      $composableBuilder(column: $table.currentXp, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<DateTime> get lastEnergyModeAt => $composableBuilder(
    column: $table.lastEnergyModeAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HeroProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HeroProfilesTable,
          HeroProfile,
          $$HeroProfilesTableFilterComposer,
          $$HeroProfilesTableOrderingComposer,
          $$HeroProfilesTableAnnotationComposer,
          $$HeroProfilesTableCreateCompanionBuilder,
          $$HeroProfilesTableUpdateCompanionBuilder,
          (
            HeroProfile,
            BaseReferences<_$AppDatabase, $HeroProfilesTable, HeroProfile>,
          ),
          HeroProfile,
          PrefetchHooks Function()
        > {
  $$HeroProfilesTableTableManager(_$AppDatabase db, $HeroProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HeroProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HeroProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HeroProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> heroClass = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentXp = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<DateTime?> lastEnergyModeAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HeroProfilesCompanion(
                id: id,
                name: name,
                heroClass: heroClass,
                level: level,
                currentXp: currentXp,
                gold: gold,
                lastEnergyModeAt: lastEnergyModeAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String heroClass,
                Value<int> level = const Value.absent(),
                Value<int> currentXp = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<DateTime?> lastEnergyModeAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HeroProfilesCompanion.insert(
                id: id,
                name: name,
                heroClass: heroClass,
                level: level,
                currentXp: currentXp,
                gold: gold,
                lastEnergyModeAt: lastEnergyModeAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HeroProfilesTable, HeroProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $HeroProfilesTable,
                    HeroProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HeroProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HeroProfilesTable,
      HeroProfile,
      $$HeroProfilesTableFilterComposer,
      $$HeroProfilesTableOrderingComposer,
      $$HeroProfilesTableAnnotationComposer,
      $$HeroProfilesTableCreateCompanionBuilder,
      $$HeroProfilesTableUpdateCompanionBuilder,
      (
        HeroProfile,
        BaseReferences<_$AppDatabase, $HeroProfilesTable, HeroProfile>,
      ),
      HeroProfile,
      PrefetchHooks Function()
    >;
typedef $$AttributeStatsTableCreateCompanionBuilder =
    AttributeStatsCompanion Function({
      required String attributeKey,
      Value<int> level,
      Value<int> currentXp,
      Value<int> rowid,
    });
typedef $$AttributeStatsTableUpdateCompanionBuilder =
    AttributeStatsCompanion Function({
      Value<String> attributeKey,
      Value<int> level,
      Value<int> currentXp,
      Value<int> rowid,
    });

class $$AttributeStatsTableFilterComposer
    extends Composer<_$AppDatabase, $AttributeStatsTable> {
  $$AttributeStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentXp => $composableBuilder(
    column: $table.currentXp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttributeStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttributeStatsTable> {
  $$AttributeStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentXp => $composableBuilder(
    column: $table.currentXp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttributeStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttributeStatsTable> {
  $$AttributeStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentXp =>
      $composableBuilder(column: $table.currentXp, builder: (column) => column);
}

class $$AttributeStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttributeStatsTable,
          AttributeStat,
          $$AttributeStatsTableFilterComposer,
          $$AttributeStatsTableOrderingComposer,
          $$AttributeStatsTableAnnotationComposer,
          $$AttributeStatsTableCreateCompanionBuilder,
          $$AttributeStatsTableUpdateCompanionBuilder,
          (
            AttributeStat,
            BaseReferences<_$AppDatabase, $AttributeStatsTable, AttributeStat>,
          ),
          AttributeStat,
          PrefetchHooks Function()
        > {
  $$AttributeStatsTableTableManager(
    _$AppDatabase db,
    $AttributeStatsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttributeStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttributeStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttributeStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> attributeKey = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentXp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttributeStatsCompanion(
                attributeKey: attributeKey,
                level: level,
                currentXp: currentXp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String attributeKey,
                Value<int> level = const Value.absent(),
                Value<int> currentXp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttributeStatsCompanion.insert(
                attributeKey: attributeKey,
                level: level,
                currentXp: currentXp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttributeStatsTable, AttributeStat>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AttributeStatsTable,
                    AttributeStat
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttributeStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttributeStatsTable,
      AttributeStat,
      $$AttributeStatsTableFilterComposer,
      $$AttributeStatsTableOrderingComposer,
      $$AttributeStatsTableAnnotationComposer,
      $$AttributeStatsTableCreateCompanionBuilder,
      $$AttributeStatsTableUpdateCompanionBuilder,
      (
        AttributeStat,
        BaseReferences<_$AppDatabase, $AttributeStatsTable, AttributeStat>,
      ),
      AttributeStat,
      PrefetchHooks Function()
    >;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  required String attributeKey,
  Value<String> difficulty,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<String?> googleTaskId,
  Value<DateTime> createdAt,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> attributeKey,
  Value<String> difficulty,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<String?> googleTaskId,
  Value<DateTime> createdAt,
});

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get googleTaskId => $composableBuilder(
    column: $table.googleTaskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get googleTaskId => $composableBuilder(
    column: $table.googleTaskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get googleTaskId => $composableBuilder(
    column: $table.googleTaskId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> attributeKey = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> googleTaskId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                attributeKey: attributeKey,
                difficulty: difficulty,
                isCompleted: isCompleted,
                completedAt: completedAt,
                googleTaskId: googleTaskId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String attributeKey,
                Value<String> difficulty = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> googleTaskId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                attributeKey: attributeKey,
                difficulty: difficulty,
                isCompleted: isCompleted,
                completedAt: completedAt,
                googleTaskId: googleTaskId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTable, Task>(table),
                  BaseReferences<_$AppDatabase, $TasksTable, Task>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HeroProfilesTableTableManager get heroProfiles =>
      $$HeroProfilesTableTableManager(_db, _db.heroProfiles);
  $$AttributeStatsTableTableManager get attributeStats =>
      $$AttributeStatsTableTableManager(_db, _db.attributeStats);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
}
