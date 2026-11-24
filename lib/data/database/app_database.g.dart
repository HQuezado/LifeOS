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
  static const VerificationMeta _energyModeActiveUntilMeta =
      const VerificationMeta('energyModeActiveUntil');
  @override
  late final GeneratedColumn<DateTime> energyModeActiveUntil =
      GeneratedColumn<DateTime>(
        'energy_mode_active_until',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bardInspirationActiveMeta =
      const VerificationMeta('bardInspirationActive');
  @override
  late final GeneratedColumn<bool> bardInspirationActive =
      GeneratedColumn<bool>(
        'bard_inspiration_active',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("bard_inspiration_active" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _focusPotionUntilMeta = const VerificationMeta(
    'focusPotionUntil',
  );
  @override
  late final GeneratedColumn<DateTime> focusPotionUntil =
      GeneratedColumn<DateTime>(
        'focus_potion_until',
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
    energyModeActiveUntil,
    bardInspirationActive,
    focusPotionUntil,
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
    if (data.containsKey('energy_mode_active_until')) {
      context.handle(
        _energyModeActiveUntilMeta,
        energyModeActiveUntil.isAcceptableOrUnknown(
          data['energy_mode_active_until']!,
          _energyModeActiveUntilMeta,
        ),
      );
    }
    if (data.containsKey('bard_inspiration_active')) {
      context.handle(
        _bardInspirationActiveMeta,
        bardInspirationActive.isAcceptableOrUnknown(
          data['bard_inspiration_active']!,
          _bardInspirationActiveMeta,
        ),
      );
    }
    if (data.containsKey('focus_potion_until')) {
      context.handle(
        _focusPotionUntilMeta,
        focusPotionUntil.isAcceptableOrUnknown(
          data['focus_potion_until']!,
          _focusPotionUntilMeta,
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
      energyModeActiveUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}energy_mode_active_until'],
      ),
      bardInspirationActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bard_inspiration_active'],
      )!,
      focusPotionUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}focus_potion_until'],
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
  final DateTime? energyModeActiveUntil;
  final bool bardInspirationActive;
  final DateTime? focusPotionUntil;
  final DateTime createdAt;
  const HeroProfile({
    required this.id,
    required this.name,
    required this.heroClass,
    required this.level,
    required this.currentXp,
    required this.gold,
    this.lastEnergyModeAt,
    this.energyModeActiveUntil,
    required this.bardInspirationActive,
    this.focusPotionUntil,
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
    if (!nullToAbsent || energyModeActiveUntil != null) {
      map['energy_mode_active_until'] = Variable<DateTime>(
        energyModeActiveUntil,
      );
    }
    map['bard_inspiration_active'] = Variable<bool>(bardInspirationActive);
    if (!nullToAbsent || focusPotionUntil != null) {
      map['focus_potion_until'] = Variable<DateTime>(focusPotionUntil);
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
      energyModeActiveUntil: energyModeActiveUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(energyModeActiveUntil),
      bardInspirationActive: Value(bardInspirationActive),
      focusPotionUntil: focusPotionUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(focusPotionUntil),
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
      energyModeActiveUntil: serializer.fromJson<DateTime?>(
        json['energyModeActiveUntil'],
      ),
      bardInspirationActive: serializer.fromJson<bool>(
        json['bardInspirationActive'],
      ),
      focusPotionUntil: serializer.fromJson<DateTime?>(
        json['focusPotionUntil'],
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
      'energyModeActiveUntil': serializer.toJson<DateTime?>(
        energyModeActiveUntil,
      ),
      'bardInspirationActive': serializer.toJson<bool>(bardInspirationActive),
      'focusPotionUntil': serializer.toJson<DateTime?>(focusPotionUntil),
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
    Value<DateTime?> energyModeActiveUntil = const Value.absent(),
    bool? bardInspirationActive,
    Value<DateTime?> focusPotionUntil = const Value.absent(),
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
    energyModeActiveUntil: energyModeActiveUntil.present
        ? energyModeActiveUntil.value
        : this.energyModeActiveUntil,
    bardInspirationActive: bardInspirationActive ?? this.bardInspirationActive,
    focusPotionUntil: focusPotionUntil.present
        ? focusPotionUntil.value
        : this.focusPotionUntil,
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
      energyModeActiveUntil: data.energyModeActiveUntil.present
          ? data.energyModeActiveUntil.value
          : this.energyModeActiveUntil,
      bardInspirationActive: data.bardInspirationActive.present
          ? data.bardInspirationActive.value
          : this.bardInspirationActive,
      focusPotionUntil: data.focusPotionUntil.present
          ? data.focusPotionUntil.value
          : this.focusPotionUntil,
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
          ..write('energyModeActiveUntil: $energyModeActiveUntil, ')
          ..write('bardInspirationActive: $bardInspirationActive, ')
          ..write('focusPotionUntil: $focusPotionUntil, ')
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
    energyModeActiveUntil,
    bardInspirationActive,
    focusPotionUntil,
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
          other.energyModeActiveUntil == this.energyModeActiveUntil &&
          other.bardInspirationActive == this.bardInspirationActive &&
          other.focusPotionUntil == this.focusPotionUntil &&
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
  final Value<DateTime?> energyModeActiveUntil;
  final Value<bool> bardInspirationActive;
  final Value<DateTime?> focusPotionUntil;
  final Value<DateTime> createdAt;
  const HeroProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.heroClass = const Value.absent(),
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.gold = const Value.absent(),
    this.lastEnergyModeAt = const Value.absent(),
    this.energyModeActiveUntil = const Value.absent(),
    this.bardInspirationActive = const Value.absent(),
    this.focusPotionUntil = const Value.absent(),
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
    this.energyModeActiveUntil = const Value.absent(),
    this.bardInspirationActive = const Value.absent(),
    this.focusPotionUntil = const Value.absent(),
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
    Expression<DateTime>? energyModeActiveUntil,
    Expression<bool>? bardInspirationActive,
    Expression<DateTime>? focusPotionUntil,
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
      if (energyModeActiveUntil != null)
        'energy_mode_active_until': energyModeActiveUntil,
      if (bardInspirationActive != null)
        'bard_inspiration_active': bardInspirationActive,
      if (focusPotionUntil != null) 'focus_potion_until': focusPotionUntil,
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
    Value<DateTime?>? energyModeActiveUntil,
    Value<bool>? bardInspirationActive,
    Value<DateTime?>? focusPotionUntil,
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
      energyModeActiveUntil:
          energyModeActiveUntil ?? this.energyModeActiveUntil,
      bardInspirationActive:
          bardInspirationActive ?? this.bardInspirationActive,
      focusPotionUntil: focusPotionUntil ?? this.focusPotionUntil,
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
    if (energyModeActiveUntil.present) {
      map['energy_mode_active_until'] = Variable<DateTime>(
        energyModeActiveUntil.value,
      );
    }
    if (bardInspirationActive.present) {
      map['bard_inspiration_active'] = Variable<bool>(
        bardInspirationActive.value,
      );
    }
    if (focusPotionUntil.present) {
      map['focus_potion_until'] = Variable<DateTime>(focusPotionUntil.value);
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
          ..write('energyModeActiveUntil: $energyModeActiveUntil, ')
          ..write('bardInspirationActive: $bardInspirationActive, ')
          ..write('focusPotionUntil: $focusPotionUntil, ')
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

class $RaidsTable extends Raids with TableInfo<$RaidsTable, Raid> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RaidsTable(this.attachedDatabase, [this._alias]);
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
    isCompleted,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raids';
  @override
  VerificationContext validateIntegrity(
    Insertable<Raid> instance, {
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
  Raid map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Raid(
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
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RaidsTable createAlias(String alias) {
    return $RaidsTable(attachedDatabase, alias);
  }
}

class Raid extends DataClass implements Insertable<Raid> {
  final int id;
  final String title;
  final String attributeKey;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  const Raid({
    required this.id,
    required this.title,
    required this.attributeKey,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['attribute_key'] = Variable<String>(attributeKey);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RaidsCompanion toCompanion(bool nullToAbsent) {
    return RaidsCompanion(
      id: Value(id),
      title: Value(title),
      attributeKey: Value(attributeKey),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Raid.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Raid(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      attributeKey: serializer.fromJson<String>(json['attributeKey']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
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
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Raid copyWith({
    int? id,
    String? title,
    String? attributeKey,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Raid(
    id: id ?? this.id,
    title: title ?? this.title,
    attributeKey: attributeKey ?? this.attributeKey,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Raid copyWithCompanion(RaidsCompanion data) {
    return Raid(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      attributeKey: data.attributeKey.present
          ? data.attributeKey.value
          : this.attributeKey,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Raid(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, attributeKey, isCompleted, completedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Raid &&
          other.id == this.id &&
          other.title == this.title &&
          other.attributeKey == this.attributeKey &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class RaidsCompanion extends UpdateCompanion<Raid> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> attributeKey;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  const RaidsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.attributeKey = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RaidsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String attributeKey,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       attributeKey = Value(attributeKey);
  static Insertable<Raid> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? attributeKey,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (attributeKey != null) 'attribute_key': attributeKey,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RaidsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? attributeKey,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
  }) {
    return RaidsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      attributeKey: attributeKey ?? this.attributeKey,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
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
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RaidsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RaidEnemiesTable extends RaidEnemies
    with TableInfo<$RaidEnemiesTable, RaidEnemy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RaidEnemiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _raidIdMeta = const VerificationMeta('raidId');
  @override
  late final GeneratedColumn<int> raidId = GeneratedColumn<int>(
    'raid_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES raids (id) ON DELETE CASCADE',
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
    requiredDuringInsert: false,
    defaultValue: const Constant('INT'),
  );
  static const VerificationMeta _enemyTypeMeta = const VerificationMeta(
    'enemyType',
  );
  @override
  late final GeneratedColumn<String> enemyType = GeneratedColumn<String>(
    'enemy_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('slime'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDefeatedMeta = const VerificationMeta(
    'isDefeated',
  );
  @override
  late final GeneratedColumn<bool> isDefeated = GeneratedColumn<bool>(
    'is_defeated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_defeated" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _defeatedAtMeta = const VerificationMeta(
    'defeatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> defeatedAt = GeneratedColumn<DateTime>(
    'defeated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    raidId,
    title,
    attributeKey,
    enemyType,
    sortOrder,
    isDefeated,
    defeatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raid_enemies';
  @override
  VerificationContext validateIntegrity(
    Insertable<RaidEnemy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raid_id')) {
      context.handle(
        _raidIdMeta,
        raidId.isAcceptableOrUnknown(data['raid_id']!, _raidIdMeta),
      );
    } else if (isInserting) {
      context.missing(_raidIdMeta);
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
    }
    if (data.containsKey('enemy_type')) {
      context.handle(
        _enemyTypeMeta,
        enemyType.isAcceptableOrUnknown(data['enemy_type']!, _enemyTypeMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_defeated')) {
      context.handle(
        _isDefeatedMeta,
        isDefeated.isAcceptableOrUnknown(data['is_defeated']!, _isDefeatedMeta),
      );
    }
    if (data.containsKey('defeated_at')) {
      context.handle(
        _defeatedAtMeta,
        defeatedAt.isAcceptableOrUnknown(data['defeated_at']!, _defeatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RaidEnemy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RaidEnemy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      raidId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}raid_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      attributeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_key'],
      )!,
      enemyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enemy_type'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isDefeated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_defeated'],
      )!,
      defeatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}defeated_at'],
      ),
    );
  }

  @override
  $RaidEnemiesTable createAlias(String alias) {
    return $RaidEnemiesTable(attachedDatabase, alias);
  }
}

class RaidEnemy extends DataClass implements Insertable<RaidEnemy> {
  final int id;
  final int raidId;
  final String title;
  final String attributeKey;
  final String enemyType;
  final int sortOrder;
  final bool isDefeated;
  final DateTime? defeatedAt;
  const RaidEnemy({
    required this.id,
    required this.raidId,
    required this.title,
    required this.attributeKey,
    required this.enemyType,
    required this.sortOrder,
    required this.isDefeated,
    this.defeatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raid_id'] = Variable<int>(raidId);
    map['title'] = Variable<String>(title);
    map['attribute_key'] = Variable<String>(attributeKey);
    map['enemy_type'] = Variable<String>(enemyType);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_defeated'] = Variable<bool>(isDefeated);
    if (!nullToAbsent || defeatedAt != null) {
      map['defeated_at'] = Variable<DateTime>(defeatedAt);
    }
    return map;
  }

  RaidEnemiesCompanion toCompanion(bool nullToAbsent) {
    return RaidEnemiesCompanion(
      id: Value(id),
      raidId: Value(raidId),
      title: Value(title),
      attributeKey: Value(attributeKey),
      enemyType: Value(enemyType),
      sortOrder: Value(sortOrder),
      isDefeated: Value(isDefeated),
      defeatedAt: defeatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(defeatedAt),
    );
  }

  factory RaidEnemy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RaidEnemy(
      id: serializer.fromJson<int>(json['id']),
      raidId: serializer.fromJson<int>(json['raidId']),
      title: serializer.fromJson<String>(json['title']),
      attributeKey: serializer.fromJson<String>(json['attributeKey']),
      enemyType: serializer.fromJson<String>(json['enemyType']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isDefeated: serializer.fromJson<bool>(json['isDefeated']),
      defeatedAt: serializer.fromJson<DateTime?>(json['defeatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'raidId': serializer.toJson<int>(raidId),
      'title': serializer.toJson<String>(title),
      'attributeKey': serializer.toJson<String>(attributeKey),
      'enemyType': serializer.toJson<String>(enemyType),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isDefeated': serializer.toJson<bool>(isDefeated),
      'defeatedAt': serializer.toJson<DateTime?>(defeatedAt),
    };
  }

  RaidEnemy copyWith({
    int? id,
    int? raidId,
    String? title,
    String? attributeKey,
    String? enemyType,
    int? sortOrder,
    bool? isDefeated,
    Value<DateTime?> defeatedAt = const Value.absent(),
  }) => RaidEnemy(
    id: id ?? this.id,
    raidId: raidId ?? this.raidId,
    title: title ?? this.title,
    attributeKey: attributeKey ?? this.attributeKey,
    enemyType: enemyType ?? this.enemyType,
    sortOrder: sortOrder ?? this.sortOrder,
    isDefeated: isDefeated ?? this.isDefeated,
    defeatedAt: defeatedAt.present ? defeatedAt.value : this.defeatedAt,
  );
  RaidEnemy copyWithCompanion(RaidEnemiesCompanion data) {
    return RaidEnemy(
      id: data.id.present ? data.id.value : this.id,
      raidId: data.raidId.present ? data.raidId.value : this.raidId,
      title: data.title.present ? data.title.value : this.title,
      attributeKey: data.attributeKey.present
          ? data.attributeKey.value
          : this.attributeKey,
      enemyType: data.enemyType.present ? data.enemyType.value : this.enemyType,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isDefeated: data.isDefeated.present
          ? data.isDefeated.value
          : this.isDefeated,
      defeatedAt: data.defeatedAt.present
          ? data.defeatedAt.value
          : this.defeatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RaidEnemy(')
          ..write('id: $id, ')
          ..write('raidId: $raidId, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('enemyType: $enemyType, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDefeated: $isDefeated, ')
          ..write('defeatedAt: $defeatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    raidId,
    title,
    attributeKey,
    enemyType,
    sortOrder,
    isDefeated,
    defeatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RaidEnemy &&
          other.id == this.id &&
          other.raidId == this.raidId &&
          other.title == this.title &&
          other.attributeKey == this.attributeKey &&
          other.enemyType == this.enemyType &&
          other.sortOrder == this.sortOrder &&
          other.isDefeated == this.isDefeated &&
          other.defeatedAt == this.defeatedAt);
}

class RaidEnemiesCompanion extends UpdateCompanion<RaidEnemy> {
  final Value<int> id;
  final Value<int> raidId;
  final Value<String> title;
  final Value<String> attributeKey;
  final Value<String> enemyType;
  final Value<int> sortOrder;
  final Value<bool> isDefeated;
  final Value<DateTime?> defeatedAt;
  const RaidEnemiesCompanion({
    this.id = const Value.absent(),
    this.raidId = const Value.absent(),
    this.title = const Value.absent(),
    this.attributeKey = const Value.absent(),
    this.enemyType = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isDefeated = const Value.absent(),
    this.defeatedAt = const Value.absent(),
  });
  RaidEnemiesCompanion.insert({
    this.id = const Value.absent(),
    required int raidId,
    required String title,
    this.attributeKey = const Value.absent(),
    this.enemyType = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isDefeated = const Value.absent(),
    this.defeatedAt = const Value.absent(),
  }) : raidId = Value(raidId),
       title = Value(title);
  static Insertable<RaidEnemy> custom({
    Expression<int>? id,
    Expression<int>? raidId,
    Expression<String>? title,
    Expression<String>? attributeKey,
    Expression<String>? enemyType,
    Expression<int>? sortOrder,
    Expression<bool>? isDefeated,
    Expression<DateTime>? defeatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (raidId != null) 'raid_id': raidId,
      if (title != null) 'title': title,
      if (attributeKey != null) 'attribute_key': attributeKey,
      if (enemyType != null) 'enemy_type': enemyType,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isDefeated != null) 'is_defeated': isDefeated,
      if (defeatedAt != null) 'defeated_at': defeatedAt,
    });
  }

  RaidEnemiesCompanion copyWith({
    Value<int>? id,
    Value<int>? raidId,
    Value<String>? title,
    Value<String>? attributeKey,
    Value<String>? enemyType,
    Value<int>? sortOrder,
    Value<bool>? isDefeated,
    Value<DateTime?>? defeatedAt,
  }) {
    return RaidEnemiesCompanion(
      id: id ?? this.id,
      raidId: raidId ?? this.raidId,
      title: title ?? this.title,
      attributeKey: attributeKey ?? this.attributeKey,
      enemyType: enemyType ?? this.enemyType,
      sortOrder: sortOrder ?? this.sortOrder,
      isDefeated: isDefeated ?? this.isDefeated,
      defeatedAt: defeatedAt ?? this.defeatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (raidId.present) {
      map['raid_id'] = Variable<int>(raidId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (attributeKey.present) {
      map['attribute_key'] = Variable<String>(attributeKey.value);
    }
    if (enemyType.present) {
      map['enemy_type'] = Variable<String>(enemyType.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isDefeated.present) {
      map['is_defeated'] = Variable<bool>(isDefeated.value);
    }
    if (defeatedAt.present) {
      map['defeated_at'] = Variable<DateTime>(defeatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RaidEnemiesCompanion(')
          ..write('id: $id, ')
          ..write('raidId: $raidId, ')
          ..write('title: $title, ')
          ..write('attributeKey: $attributeKey, ')
          ..write('enemyType: $enemyType, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDefeated: $isDefeated, ')
          ..write('defeatedAt: $defeatedAt')
          ..write(')'))
        .toString();
  }
}

class $MysteryChestsTable extends MysteryChests
    with TableInfo<$MysteryChestsTable, MysteryChest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MysteryChestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOpenedMeta = const VerificationMeta(
    'isOpened',
  );
  @override
  late final GeneratedColumn<bool> isOpened = GeneratedColumn<bool>(
    'is_opened',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_opened" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _rewardSummaryMeta = const VerificationMeta(
    'rewardSummary',
  );
  @override
  late final GeneratedColumn<String> rewardSummary = GeneratedColumn<String>(
    'reward_summary',
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
    rarity,
    source,
    isOpened,
    rewardSummary,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mystery_chests';
  @override
  VerificationContext validateIntegrity(
    Insertable<MysteryChest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    } else if (isInserting) {
      context.missing(_rarityMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('is_opened')) {
      context.handle(
        _isOpenedMeta,
        isOpened.isAcceptableOrUnknown(data['is_opened']!, _isOpenedMeta),
      );
    }
    if (data.containsKey('reward_summary')) {
      context.handle(
        _rewardSummaryMeta,
        rewardSummary.isAcceptableOrUnknown(
          data['reward_summary']!,
          _rewardSummaryMeta,
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
  MysteryChest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MysteryChest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      isOpened: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_opened'],
      )!,
      rewardSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_summary'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MysteryChestsTable createAlias(String alias) {
    return $MysteryChestsTable(attachedDatabase, alias);
  }
}

class MysteryChest extends DataClass implements Insertable<MysteryChest> {
  final int id;
  final String rarity;
  final String source;
  final bool isOpened;
  final String? rewardSummary;
  final DateTime createdAt;
  const MysteryChest({
    required this.id,
    required this.rarity,
    required this.source,
    required this.isOpened,
    this.rewardSummary,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rarity'] = Variable<String>(rarity);
    map['source'] = Variable<String>(source);
    map['is_opened'] = Variable<bool>(isOpened);
    if (!nullToAbsent || rewardSummary != null) {
      map['reward_summary'] = Variable<String>(rewardSummary);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MysteryChestsCompanion toCompanion(bool nullToAbsent) {
    return MysteryChestsCompanion(
      id: Value(id),
      rarity: Value(rarity),
      source: Value(source),
      isOpened: Value(isOpened),
      rewardSummary: rewardSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(rewardSummary),
      createdAt: Value(createdAt),
    );
  }

  factory MysteryChest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MysteryChest(
      id: serializer.fromJson<int>(json['id']),
      rarity: serializer.fromJson<String>(json['rarity']),
      source: serializer.fromJson<String>(json['source']),
      isOpened: serializer.fromJson<bool>(json['isOpened']),
      rewardSummary: serializer.fromJson<String?>(json['rewardSummary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rarity': serializer.toJson<String>(rarity),
      'source': serializer.toJson<String>(source),
      'isOpened': serializer.toJson<bool>(isOpened),
      'rewardSummary': serializer.toJson<String?>(rewardSummary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MysteryChest copyWith({
    int? id,
    String? rarity,
    String? source,
    bool? isOpened,
    Value<String?> rewardSummary = const Value.absent(),
    DateTime? createdAt,
  }) => MysteryChest(
    id: id ?? this.id,
    rarity: rarity ?? this.rarity,
    source: source ?? this.source,
    isOpened: isOpened ?? this.isOpened,
    rewardSummary: rewardSummary.present
        ? rewardSummary.value
        : this.rewardSummary,
    createdAt: createdAt ?? this.createdAt,
  );
  MysteryChest copyWithCompanion(MysteryChestsCompanion data) {
    return MysteryChest(
      id: data.id.present ? data.id.value : this.id,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      source: data.source.present ? data.source.value : this.source,
      isOpened: data.isOpened.present ? data.isOpened.value : this.isOpened,
      rewardSummary: data.rewardSummary.present
          ? data.rewardSummary.value
          : this.rewardSummary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MysteryChest(')
          ..write('id: $id, ')
          ..write('rarity: $rarity, ')
          ..write('source: $source, ')
          ..write('isOpened: $isOpened, ')
          ..write('rewardSummary: $rewardSummary, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, rarity, source, isOpened, rewardSummary, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MysteryChest &&
          other.id == this.id &&
          other.rarity == this.rarity &&
          other.source == this.source &&
          other.isOpened == this.isOpened &&
          other.rewardSummary == this.rewardSummary &&
          other.createdAt == this.createdAt);
}

class MysteryChestsCompanion extends UpdateCompanion<MysteryChest> {
  final Value<int> id;
  final Value<String> rarity;
  final Value<String> source;
  final Value<bool> isOpened;
  final Value<String?> rewardSummary;
  final Value<DateTime> createdAt;
  const MysteryChestsCompanion({
    this.id = const Value.absent(),
    this.rarity = const Value.absent(),
    this.source = const Value.absent(),
    this.isOpened = const Value.absent(),
    this.rewardSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MysteryChestsCompanion.insert({
    this.id = const Value.absent(),
    required String rarity,
    required String source,
    this.isOpened = const Value.absent(),
    this.rewardSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : rarity = Value(rarity),
       source = Value(source);
  static Insertable<MysteryChest> custom({
    Expression<int>? id,
    Expression<String>? rarity,
    Expression<String>? source,
    Expression<bool>? isOpened,
    Expression<String>? rewardSummary,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rarity != null) 'rarity': rarity,
      if (source != null) 'source': source,
      if (isOpened != null) 'is_opened': isOpened,
      if (rewardSummary != null) 'reward_summary': rewardSummary,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MysteryChestsCompanion copyWith({
    Value<int>? id,
    Value<String>? rarity,
    Value<String>? source,
    Value<bool>? isOpened,
    Value<String?>? rewardSummary,
    Value<DateTime>? createdAt,
  }) {
    return MysteryChestsCompanion(
      id: id ?? this.id,
      rarity: rarity ?? this.rarity,
      source: source ?? this.source,
      isOpened: isOpened ?? this.isOpened,
      rewardSummary: rewardSummary ?? this.rewardSummary,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isOpened.present) {
      map['is_opened'] = Variable<bool>(isOpened.value);
    }
    if (rewardSummary.present) {
      map['reward_summary'] = Variable<String>(rewardSummary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MysteryChestsCompanion(')
          ..write('id: $id, ')
          ..write('rarity: $rarity, ')
          ..write('source: $source, ')
          ..write('isOpened: $isOpened, ')
          ..write('rewardSummary: $rewardSummary, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OwnedItemsTable extends OwnedItems
    with TableInfo<$OwnedItemsTable, OwnedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OwnedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEquippedMeta = const VerificationMeta(
    'isEquipped',
  );
  @override
  late final GeneratedColumn<bool> isEquipped = GeneratedColumn<bool>(
    'is_equipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_equipped" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    itemId,
    category,
    isEquipped,
    purchasedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'owned_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OwnedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_equipped')) {
      context.handle(
        _isEquippedMeta,
        isEquipped.isAcceptableOrUnknown(data['is_equipped']!, _isEquippedMeta),
      );
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  OwnedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OwnedItem(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isEquipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_equipped'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      )!,
    );
  }

  @override
  $OwnedItemsTable createAlias(String alias) {
    return $OwnedItemsTable(attachedDatabase, alias);
  }
}

class OwnedItem extends DataClass implements Insertable<OwnedItem> {
  final String itemId;
  final String category;
  final bool isEquipped;
  final DateTime purchasedAt;
  const OwnedItem({
    required this.itemId,
    required this.category,
    required this.isEquipped,
    required this.purchasedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['category'] = Variable<String>(category);
    map['is_equipped'] = Variable<bool>(isEquipped);
    map['purchased_at'] = Variable<DateTime>(purchasedAt);
    return map;
  }

  OwnedItemsCompanion toCompanion(bool nullToAbsent) {
    return OwnedItemsCompanion(
      itemId: Value(itemId),
      category: Value(category),
      isEquipped: Value(isEquipped),
      purchasedAt: Value(purchasedAt),
    );
  }

  factory OwnedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OwnedItem(
      itemId: serializer.fromJson<String>(json['itemId']),
      category: serializer.fromJson<String>(json['category']),
      isEquipped: serializer.fromJson<bool>(json['isEquipped']),
      purchasedAt: serializer.fromJson<DateTime>(json['purchasedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'category': serializer.toJson<String>(category),
      'isEquipped': serializer.toJson<bool>(isEquipped),
      'purchasedAt': serializer.toJson<DateTime>(purchasedAt),
    };
  }

  OwnedItem copyWith({
    String? itemId,
    String? category,
    bool? isEquipped,
    DateTime? purchasedAt,
  }) => OwnedItem(
    itemId: itemId ?? this.itemId,
    category: category ?? this.category,
    isEquipped: isEquipped ?? this.isEquipped,
    purchasedAt: purchasedAt ?? this.purchasedAt,
  );
  OwnedItem copyWithCompanion(OwnedItemsCompanion data) {
    return OwnedItem(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      category: data.category.present ? data.category.value : this.category,
      isEquipped: data.isEquipped.present
          ? data.isEquipped.value
          : this.isEquipped,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OwnedItem(')
          ..write('itemId: $itemId, ')
          ..write('category: $category, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('purchasedAt: $purchasedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, category, isEquipped, purchasedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OwnedItem &&
          other.itemId == this.itemId &&
          other.category == this.category &&
          other.isEquipped == this.isEquipped &&
          other.purchasedAt == this.purchasedAt);
}

class OwnedItemsCompanion extends UpdateCompanion<OwnedItem> {
  final Value<String> itemId;
  final Value<String> category;
  final Value<bool> isEquipped;
  final Value<DateTime> purchasedAt;
  final Value<int> rowid;
  const OwnedItemsCompanion({
    this.itemId = const Value.absent(),
    this.category = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OwnedItemsCompanion.insert({
    required String itemId,
    required String category,
    this.isEquipped = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       category = Value(category);
  static Insertable<OwnedItem> custom({
    Expression<String>? itemId,
    Expression<String>? category,
    Expression<bool>? isEquipped,
    Expression<DateTime>? purchasedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (category != null) 'category': category,
      if (isEquipped != null) 'is_equipped': isEquipped,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OwnedItemsCompanion copyWith({
    Value<String>? itemId,
    Value<String>? category,
    Value<bool>? isEquipped,
    Value<DateTime>? purchasedAt,
    Value<int>? rowid,
  }) {
    return OwnedItemsCompanion(
      itemId: itemId ?? this.itemId,
      category: category ?? this.category,
      isEquipped: isEquipped ?? this.isEquipped,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isEquipped.present) {
      map['is_equipped'] = Variable<bool>(isEquipped.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OwnedItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('category: $category, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarEventsTable extends CalendarEvents
    with TableInfo<$CalendarEventsTable, CalendarEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _googleEventIdMeta = const VerificationMeta(
    'googleEventId',
  );
  @override
  late final GeneratedColumn<String> googleEventId = GeneratedColumn<String>(
    'google_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAllDayMeta = const VerificationMeta(
    'isAllDay',
  );
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
    'is_all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    googleEventId,
    title,
    startTime,
    endTime,
    isAllDay,
    location,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('google_event_id')) {
      context.handle(
        _googleEventIdMeta,
        googleEventId.isAcceptableOrUnknown(
          data['google_event_id']!,
          _googleEventIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      googleEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}google_event_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CalendarEventsTable createAlias(String alias) {
    return $CalendarEventsTable(attachedDatabase, alias);
  }
}

class CalendarEvent extends DataClass implements Insertable<CalendarEvent> {
  final int id;
  final String? googleEventId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final String? location;
  final DateTime syncedAt;
  const CalendarEvent({
    required this.id,
    this.googleEventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
    this.location,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || googleEventId != null) {
      map['google_event_id'] = Variable<String>(googleEventId);
    }
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['is_all_day'] = Variable<bool>(isAllDay);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CalendarEventsCompanion toCompanion(bool nullToAbsent) {
    return CalendarEventsCompanion(
      id: Value(id),
      googleEventId: googleEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(googleEventId),
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      isAllDay: Value(isAllDay),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      syncedAt: Value(syncedAt),
    );
  }

  factory CalendarEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarEvent(
      id: serializer.fromJson<int>(json['id']),
      googleEventId: serializer.fromJson<String?>(json['googleEventId']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      location: serializer.fromJson<String?>(json['location']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'googleEventId': serializer.toJson<String?>(googleEventId),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'location': serializer.toJson<String?>(location),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CalendarEvent copyWith({
    int? id,
    Value<String?> googleEventId = const Value.absent(),
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
    Value<String?> location = const Value.absent(),
    DateTime? syncedAt,
  }) => CalendarEvent(
    id: id ?? this.id,
    googleEventId: googleEventId.present
        ? googleEventId.value
        : this.googleEventId,
    title: title ?? this.title,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    isAllDay: isAllDay ?? this.isAllDay,
    location: location.present ? location.value : this.location,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CalendarEvent copyWithCompanion(CalendarEventsCompanion data) {
    return CalendarEvent(
      id: data.id.present ? data.id.value : this.id,
      googleEventId: data.googleEventId.present
          ? data.googleEventId.value
          : this.googleEventId,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      location: data.location.present ? data.location.value : this.location,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEvent(')
          ..write('id: $id, ')
          ..write('googleEventId: $googleEventId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('location: $location, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    googleEventId,
    title,
    startTime,
    endTime,
    isAllDay,
    location,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarEvent &&
          other.id == this.id &&
          other.googleEventId == this.googleEventId &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.isAllDay == this.isAllDay &&
          other.location == this.location &&
          other.syncedAt == this.syncedAt);
}

class CalendarEventsCompanion extends UpdateCompanion<CalendarEvent> {
  final Value<int> id;
  final Value<String?> googleEventId;
  final Value<String> title;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<bool> isAllDay;
  final Value<String?> location;
  final Value<DateTime> syncedAt;
  const CalendarEventsCompanion({
    this.id = const Value.absent(),
    this.googleEventId = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.location = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  CalendarEventsCompanion.insert({
    this.id = const Value.absent(),
    this.googleEventId = const Value.absent(),
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    this.isAllDay = const Value.absent(),
    this.location = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : title = Value(title),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<CalendarEvent> custom({
    Expression<int>? id,
    Expression<String>? googleEventId,
    Expression<String>? title,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<bool>? isAllDay,
    Expression<String>? location,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (googleEventId != null) 'google_event_id': googleEventId,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (location != null) 'location': location,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  CalendarEventsCompanion copyWith({
    Value<int>? id,
    Value<String?>? googleEventId,
    Value<String>? title,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<bool>? isAllDay,
    Value<String?>? location,
    Value<DateTime>? syncedAt,
  }) {
    return CalendarEventsCompanion(
      id: id ?? this.id,
      googleEventId: googleEventId ?? this.googleEventId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
      location: location ?? this.location,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (googleEventId.present) {
      map['google_event_id'] = Variable<String>(googleEventId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEventsCompanion(')
          ..write('id: $id, ')
          ..write('googleEventId: $googleEventId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('location: $location, ')
          ..write('syncedAt: $syncedAt')
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
  late final $RaidsTable raids = $RaidsTable(this);
  late final $RaidEnemiesTable raidEnemies = $RaidEnemiesTable(this);
  late final $MysteryChestsTable mysteryChests = $MysteryChestsTable(this);
  late final $OwnedItemsTable ownedItems = $OwnedItemsTable(this);
  late final $CalendarEventsTable calendarEvents = $CalendarEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    heroProfiles,
    attributeStats,
    tasks,
    raids,
    raidEnemies,
    mysteryChests,
    ownedItems,
    calendarEvents,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'raids',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('raid_enemies', kind: UpdateKind.delete)],
    ),
  ]);
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
      Value<DateTime?> energyModeActiveUntil,
      Value<bool> bardInspirationActive,
      Value<DateTime?> focusPotionUntil,
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
      Value<DateTime?> energyModeActiveUntil,
      Value<bool> bardInspirationActive,
      Value<DateTime?> focusPotionUntil,
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

  ColumnFilters<DateTime> get energyModeActiveUntil => $composableBuilder(
    column: $table.energyModeActiveUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bardInspirationActive => $composableBuilder(
    column: $table.bardInspirationActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get focusPotionUntil => $composableBuilder(
    column: $table.focusPotionUntil,
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

  ColumnOrderings<DateTime> get energyModeActiveUntil => $composableBuilder(
    column: $table.energyModeActiveUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bardInspirationActive => $composableBuilder(
    column: $table.bardInspirationActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get focusPotionUntil => $composableBuilder(
    column: $table.focusPotionUntil,
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

  GeneratedColumn<DateTime> get energyModeActiveUntil => $composableBuilder(
    column: $table.energyModeActiveUntil,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get bardInspirationActive => $composableBuilder(
    column: $table.bardInspirationActive,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get focusPotionUntil => $composableBuilder(
    column: $table.focusPotionUntil,
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
                Value<DateTime?> energyModeActiveUntil = const Value.absent(),
                Value<bool> bardInspirationActive = const Value.absent(),
                Value<DateTime?> focusPotionUntil = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HeroProfilesCompanion(
                id: id,
                name: name,
                heroClass: heroClass,
                level: level,
                currentXp: currentXp,
                gold: gold,
                lastEnergyModeAt: lastEnergyModeAt,
                energyModeActiveUntil: energyModeActiveUntil,
                bardInspirationActive: bardInspirationActive,
                focusPotionUntil: focusPotionUntil,
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
                Value<DateTime?> energyModeActiveUntil = const Value.absent(),
                Value<bool> bardInspirationActive = const Value.absent(),
                Value<DateTime?> focusPotionUntil = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HeroProfilesCompanion.insert(
                id: id,
                name: name,
                heroClass: heroClass,
                level: level,
                currentXp: currentXp,
                gold: gold,
                lastEnergyModeAt: lastEnergyModeAt,
                energyModeActiveUntil: energyModeActiveUntil,
                bardInspirationActive: bardInspirationActive,
                focusPotionUntil: focusPotionUntil,
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
typedef $$RaidsTableCreateCompanionBuilder = RaidsCompanion Function({
  Value<int> id,
  required String title,
  required String attributeKey,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
});
typedef $$RaidsTableUpdateCompanionBuilder = RaidsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> attributeKey,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
});

final class $$RaidsTableReferences
    extends BaseReferences<_$AppDatabase, $RaidsTable, Raid> {
  $$RaidsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RaidEnemiesTable, List<RaidEnemy>>
  _raidEnemiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.raidEnemies,
    aliasName: 'raids__id__raid_enemies__raid_id',
  );

  $$RaidEnemiesTableProcessedTableManager get raidEnemiesRefs {
    final manager = $$RaidEnemiesTableTableManager(
      $_db,
      $_db.raidEnemies,
    ).filter((f) => f.raidId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_raidEnemiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RaidsTableFilterComposer extends Composer<_$AppDatabase, $RaidsTable> {
  $$RaidsTableFilterComposer({
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

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> raidEnemiesRefs(
    Expression<bool> Function($$RaidEnemiesTableFilterComposer f) f,
  ) {
    final $$RaidEnemiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.raidEnemies,
      getReferencedColumn: (t) => t.raidId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaidEnemiesTableFilterComposer(
            $db: $db,
            $table: $db.raidEnemies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RaidsTableOrderingComposer
    extends Composer<_$AppDatabase, $RaidsTable> {
  $$RaidsTableOrderingComposer({
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

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RaidsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RaidsTable> {
  $$RaidsTableAnnotationComposer({
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

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> raidEnemiesRefs<T extends Object>(
    Expression<T> Function($$RaidEnemiesTableAnnotationComposer a) f,
  ) {
    final $$RaidEnemiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.raidEnemies,
      getReferencedColumn: (t) => t.raidId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaidEnemiesTableAnnotationComposer(
            $db: $db,
            $table: $db.raidEnemies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RaidsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RaidsTable,
          Raid,
          $$RaidsTableFilterComposer,
          $$RaidsTableOrderingComposer,
          $$RaidsTableAnnotationComposer,
          $$RaidsTableCreateCompanionBuilder,
          $$RaidsTableUpdateCompanionBuilder,
          (Raid, $$RaidsTableReferences),
          Raid,
          PrefetchHooks Function({bool raidEnemiesRefs})
        > {
  $$RaidsTableTableManager(_$AppDatabase db, $RaidsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RaidsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RaidsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RaidsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> attributeKey = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RaidsCompanion(
                id: id,
                title: title,
                attributeKey: attributeKey,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String attributeKey,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RaidsCompanion.insert(
                id: id,
                title: title,
                attributeKey: attributeKey,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RaidsTable, Raid>(table),
                  $$RaidsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({raidEnemiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (raidEnemiesRefs) db.raidEnemies],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (raidEnemiesRefs)
                    await $_getPrefetchedDataByColumns<
                      Raid,
                      $RaidsTable,
                      RaidEnemy,
                      $RaidEnemiesTable
                    >(
                      currentTable: table,
                      referencedTable: $$RaidsTableReferences
                          ._raidEnemiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RaidsTableReferences(db, table, p0).raidEnemiesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'raid_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RaidsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RaidsTable,
      Raid,
      $$RaidsTableFilterComposer,
      $$RaidsTableOrderingComposer,
      $$RaidsTableAnnotationComposer,
      $$RaidsTableCreateCompanionBuilder,
      $$RaidsTableUpdateCompanionBuilder,
      (Raid, $$RaidsTableReferences),
      Raid,
      PrefetchHooks Function({bool raidEnemiesRefs})
    >;
typedef $$RaidEnemiesTableCreateCompanionBuilder =
    RaidEnemiesCompanion Function({
      Value<int> id,
      required int raidId,
      required String title,
      Value<String> attributeKey,
      Value<String> enemyType,
      Value<int> sortOrder,
      Value<bool> isDefeated,
      Value<DateTime?> defeatedAt,
    });
typedef $$RaidEnemiesTableUpdateCompanionBuilder =
    RaidEnemiesCompanion Function({
      Value<int> id,
      Value<int> raidId,
      Value<String> title,
      Value<String> attributeKey,
      Value<String> enemyType,
      Value<int> sortOrder,
      Value<bool> isDefeated,
      Value<DateTime?> defeatedAt,
    });

final class $$RaidEnemiesTableReferences
    extends BaseReferences<_$AppDatabase, $RaidEnemiesTable, RaidEnemy> {
  $$RaidEnemiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RaidsTable _raidIdTable(_$AppDatabase db) =>
      db.raids.createAlias('raid_enemies__raid_id__raids__id');

  $$RaidsTableProcessedTableManager get raidId {
    final $_column = $_itemColumn<int>('raid_id')!;

    final manager = $$RaidsTableTableManager(
      $_db,
      $_db.raids,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_raidIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RaidEnemiesTableFilterComposer
    extends Composer<_$AppDatabase, $RaidEnemiesTable> {
  $$RaidEnemiesTableFilterComposer({
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

  ColumnFilters<String> get enemyType => $composableBuilder(
    column: $table.enemyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefeated => $composableBuilder(
    column: $table.isDefeated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get defeatedAt => $composableBuilder(
    column: $table.defeatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RaidsTableFilterComposer get raidId {
    final $$RaidsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.raidId,
      referencedTable: $db.raids,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaidsTableFilterComposer(
            $db: $db,
            $table: $db.raids,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RaidEnemiesTableOrderingComposer
    extends Composer<_$AppDatabase, $RaidEnemiesTable> {
  $$RaidEnemiesTableOrderingComposer({
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

  ColumnOrderings<String> get enemyType => $composableBuilder(
    column: $table.enemyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefeated => $composableBuilder(
    column: $table.isDefeated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get defeatedAt => $composableBuilder(
    column: $table.defeatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RaidsTableOrderingComposer get raidId {
    final $$RaidsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.raidId,
      referencedTable: $db.raids,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaidsTableOrderingComposer(
            $db: $db,
            $table: $db.raids,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RaidEnemiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RaidEnemiesTable> {
  $$RaidEnemiesTableAnnotationComposer({
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

  GeneratedColumn<String> get enemyType =>
      $composableBuilder(column: $table.enemyType, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isDefeated => $composableBuilder(
    column: $table.isDefeated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get defeatedAt => $composableBuilder(
    column: $table.defeatedAt,
    builder: (column) => column,
  );

  $$RaidsTableAnnotationComposer get raidId {
    final $$RaidsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.raidId,
      referencedTable: $db.raids,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaidsTableAnnotationComposer(
            $db: $db,
            $table: $db.raids,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RaidEnemiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RaidEnemiesTable,
          RaidEnemy,
          $$RaidEnemiesTableFilterComposer,
          $$RaidEnemiesTableOrderingComposer,
          $$RaidEnemiesTableAnnotationComposer,
          $$RaidEnemiesTableCreateCompanionBuilder,
          $$RaidEnemiesTableUpdateCompanionBuilder,
          (RaidEnemy, $$RaidEnemiesTableReferences),
          RaidEnemy,
          PrefetchHooks Function({bool raidId})
        > {
  $$RaidEnemiesTableTableManager(_$AppDatabase db, $RaidEnemiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RaidEnemiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RaidEnemiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RaidEnemiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> raidId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> attributeKey = const Value.absent(),
                Value<String> enemyType = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isDefeated = const Value.absent(),
                Value<DateTime?> defeatedAt = const Value.absent(),
              }) => RaidEnemiesCompanion(
                id: id,
                raidId: raidId,
                title: title,
                attributeKey: attributeKey,
                enemyType: enemyType,
                sortOrder: sortOrder,
                isDefeated: isDefeated,
                defeatedAt: defeatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int raidId,
                required String title,
                Value<String> attributeKey = const Value.absent(),
                Value<String> enemyType = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isDefeated = const Value.absent(),
                Value<DateTime?> defeatedAt = const Value.absent(),
              }) => RaidEnemiesCompanion.insert(
                id: id,
                raidId: raidId,
                title: title,
                attributeKey: attributeKey,
                enemyType: enemyType,
                sortOrder: sortOrder,
                isDefeated: isDefeated,
                defeatedAt: defeatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RaidEnemiesTable, RaidEnemy>(table),
                  $$RaidEnemiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({raidId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (raidId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.raidId,
                        referencedTable: $$RaidEnemiesTableReferences
                            ._raidIdTable(db),
                        referencedColumn: $$RaidEnemiesTableReferences
                            ._raidIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RaidEnemiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RaidEnemiesTable,
      RaidEnemy,
      $$RaidEnemiesTableFilterComposer,
      $$RaidEnemiesTableOrderingComposer,
      $$RaidEnemiesTableAnnotationComposer,
      $$RaidEnemiesTableCreateCompanionBuilder,
      $$RaidEnemiesTableUpdateCompanionBuilder,
      (RaidEnemy, $$RaidEnemiesTableReferences),
      RaidEnemy,
      PrefetchHooks Function({bool raidId})
    >;
typedef $$MysteryChestsTableCreateCompanionBuilder =
    MysteryChestsCompanion Function({
      Value<int> id,
      required String rarity,
      required String source,
      Value<bool> isOpened,
      Value<String?> rewardSummary,
      Value<DateTime> createdAt,
    });
typedef $$MysteryChestsTableUpdateCompanionBuilder =
    MysteryChestsCompanion Function({
      Value<int> id,
      Value<String> rarity,
      Value<String> source,
      Value<bool> isOpened,
      Value<String?> rewardSummary,
      Value<DateTime> createdAt,
    });

class $$MysteryChestsTableFilterComposer
    extends Composer<_$AppDatabase, $MysteryChestsTable> {
  $$MysteryChestsTableFilterComposer({
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

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpened => $composableBuilder(
    column: $table.isOpened,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardSummary => $composableBuilder(
    column: $table.rewardSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MysteryChestsTableOrderingComposer
    extends Composer<_$AppDatabase, $MysteryChestsTable> {
  $$MysteryChestsTableOrderingComposer({
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

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpened => $composableBuilder(
    column: $table.isOpened,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardSummary => $composableBuilder(
    column: $table.rewardSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MysteryChestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MysteryChestsTable> {
  $$MysteryChestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isOpened =>
      $composableBuilder(column: $table.isOpened, builder: (column) => column);

  GeneratedColumn<String> get rewardSummary => $composableBuilder(
    column: $table.rewardSummary,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MysteryChestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MysteryChestsTable,
          MysteryChest,
          $$MysteryChestsTableFilterComposer,
          $$MysteryChestsTableOrderingComposer,
          $$MysteryChestsTableAnnotationComposer,
          $$MysteryChestsTableCreateCompanionBuilder,
          $$MysteryChestsTableUpdateCompanionBuilder,
          (
            MysteryChest,
            BaseReferences<_$AppDatabase, $MysteryChestsTable, MysteryChest>,
          ),
          MysteryChest,
          PrefetchHooks Function()
        > {
  $$MysteryChestsTableTableManager(_$AppDatabase db, $MysteryChestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MysteryChestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MysteryChestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MysteryChestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isOpened = const Value.absent(),
                Value<String?> rewardSummary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MysteryChestsCompanion(
                id: id,
                rarity: rarity,
                source: source,
                isOpened: isOpened,
                rewardSummary: rewardSummary,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String rarity,
                required String source,
                Value<bool> isOpened = const Value.absent(),
                Value<String?> rewardSummary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MysteryChestsCompanion.insert(
                id: id,
                rarity: rarity,
                source: source,
                isOpened: isOpened,
                rewardSummary: rewardSummary,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MysteryChestsTable, MysteryChest>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MysteryChestsTable,
                    MysteryChest
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MysteryChestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MysteryChestsTable,
      MysteryChest,
      $$MysteryChestsTableFilterComposer,
      $$MysteryChestsTableOrderingComposer,
      $$MysteryChestsTableAnnotationComposer,
      $$MysteryChestsTableCreateCompanionBuilder,
      $$MysteryChestsTableUpdateCompanionBuilder,
      (
        MysteryChest,
        BaseReferences<_$AppDatabase, $MysteryChestsTable, MysteryChest>,
      ),
      MysteryChest,
      PrefetchHooks Function()
    >;
typedef $$OwnedItemsTableCreateCompanionBuilder = OwnedItemsCompanion Function({
  required String itemId,
  required String category,
  Value<bool> isEquipped,
  Value<DateTime> purchasedAt,
  Value<int> rowid,
});
typedef $$OwnedItemsTableUpdateCompanionBuilder = OwnedItemsCompanion Function({
  Value<String> itemId,
  Value<String> category,
  Value<bool> isEquipped,
  Value<DateTime> purchasedAt,
  Value<int> rowid,
});

class $$OwnedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OwnedItemsTable> {
  $$OwnedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OwnedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OwnedItemsTable> {
  $$OwnedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OwnedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OwnedItemsTable> {
  $$OwnedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );
}

class $$OwnedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OwnedItemsTable,
          OwnedItem,
          $$OwnedItemsTableFilterComposer,
          $$OwnedItemsTableOrderingComposer,
          $$OwnedItemsTableAnnotationComposer,
          $$OwnedItemsTableCreateCompanionBuilder,
          $$OwnedItemsTableUpdateCompanionBuilder,
          (
            OwnedItem,
            BaseReferences<_$AppDatabase, $OwnedItemsTable, OwnedItem>,
          ),
          OwnedItem,
          PrefetchHooks Function()
        > {
  $$OwnedItemsTableTableManager(_$AppDatabase db, $OwnedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OwnedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OwnedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OwnedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OwnedItemsCompanion(
                itemId: itemId,
                category: category,
                isEquipped: isEquipped,
                purchasedAt: purchasedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemId,
                required String category,
                Value<bool> isEquipped = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OwnedItemsCompanion.insert(
                itemId: itemId,
                category: category,
                isEquipped: isEquipped,
                purchasedAt: purchasedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OwnedItemsTable, OwnedItem>(table),
                  BaseReferences<_$AppDatabase, $OwnedItemsTable, OwnedItem>(
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

typedef $$OwnedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OwnedItemsTable,
      OwnedItem,
      $$OwnedItemsTableFilterComposer,
      $$OwnedItemsTableOrderingComposer,
      $$OwnedItemsTableAnnotationComposer,
      $$OwnedItemsTableCreateCompanionBuilder,
      $$OwnedItemsTableUpdateCompanionBuilder,
      (OwnedItem, BaseReferences<_$AppDatabase, $OwnedItemsTable, OwnedItem>),
      OwnedItem,
      PrefetchHooks Function()
    >;
typedef $$CalendarEventsTableCreateCompanionBuilder =
    CalendarEventsCompanion Function({
      Value<int> id,
      Value<String?> googleEventId,
      required String title,
      required DateTime startTime,
      required DateTime endTime,
      Value<bool> isAllDay,
      Value<String?> location,
      Value<DateTime> syncedAt,
    });
typedef $$CalendarEventsTableUpdateCompanionBuilder =
    CalendarEventsCompanion Function({
      Value<int> id,
      Value<String?> googleEventId,
      Value<String> title,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<bool> isAllDay,
      Value<String?> location,
      Value<DateTime> syncedAt,
    });

class $$CalendarEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableFilterComposer({
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

  ColumnFilters<String> get googleEventId => $composableBuilder(
    column: $table.googleEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableOrderingComposer({
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

  ColumnOrderings<String> get googleEventId => $composableBuilder(
    column: $table.googleEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get googleEventId => $composableBuilder(
    column: $table.googleEventId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CalendarEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarEventsTable,
          CalendarEvent,
          $$CalendarEventsTableFilterComposer,
          $$CalendarEventsTableOrderingComposer,
          $$CalendarEventsTableAnnotationComposer,
          $$CalendarEventsTableCreateCompanionBuilder,
          $$CalendarEventsTableUpdateCompanionBuilder,
          (
            CalendarEvent,
            BaseReferences<_$AppDatabase, $CalendarEventsTable, CalendarEvent>,
          ),
          CalendarEvent,
          PrefetchHooks Function()
        > {
  $$CalendarEventsTableTableManager(
    _$AppDatabase db,
    $CalendarEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> googleEventId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => CalendarEventsCompanion(
                id: id,
                googleEventId: googleEventId,
                title: title,
                startTime: startTime,
                endTime: endTime,
                isAllDay: isAllDay,
                location: location,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> googleEventId = const Value.absent(),
                required String title,
                required DateTime startTime,
                required DateTime endTime,
                Value<bool> isAllDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => CalendarEventsCompanion.insert(
                id: id,
                googleEventId: googleEventId,
                title: title,
                startTime: startTime,
                endTime: endTime,
                isAllDay: isAllDay,
                location: location,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CalendarEventsTable, CalendarEvent>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CalendarEventsTable,
                    CalendarEvent
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarEventsTable,
      CalendarEvent,
      $$CalendarEventsTableFilterComposer,
      $$CalendarEventsTableOrderingComposer,
      $$CalendarEventsTableAnnotationComposer,
      $$CalendarEventsTableCreateCompanionBuilder,
      $$CalendarEventsTableUpdateCompanionBuilder,
      (
        CalendarEvent,
        BaseReferences<_$AppDatabase, $CalendarEventsTable, CalendarEvent>,
      ),
      CalendarEvent,
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
  $$RaidsTableTableManager get raids =>
      $$RaidsTableTableManager(_db, _db.raids);
  $$RaidEnemiesTableTableManager get raidEnemies =>
      $$RaidEnemiesTableTableManager(_db, _db.raidEnemies);
  $$MysteryChestsTableTableManager get mysteryChests =>
      $$MysteryChestsTableTableManager(_db, _db.mysteryChests);
  $$OwnedItemsTableTableManager get ownedItems =>
      $$OwnedItemsTableTableManager(_db, _db.ownedItems);
  $$CalendarEventsTableTableManager get calendarEvents =>
      $$CalendarEventsTableTableManager(_db, _db.calendarEvents);
}
