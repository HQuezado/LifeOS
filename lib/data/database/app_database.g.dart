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
  static const VerificationMeta _armorTintMeta = const VerificationMeta(
    'armorTint',
  );
  @override
  late final GeneratedColumn<String> armorTint = GeneratedColumn<String>(
    'armor_tint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _stepsTodayMeta = const VerificationMeta(
    'stepsToday',
  );
  @override
  late final GeneratedColumn<int> stepsToday = GeneratedColumn<int>(
    'steps_today',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastEncounterStepMilestoneMeta =
      const VerificationMeta('lastEncounterStepMilestone');
  @override
  late final GeneratedColumn<int> lastEncounterStepMilestone =
      GeneratedColumn<int>(
        'last_encounter_step_milestone',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _lastFlashMissionAtMeta =
      const VerificationMeta('lastFlashMissionAt');
  @override
  late final GeneratedColumn<DateTime> lastFlashMissionAt =
      GeneratedColumn<DateTime>(
        'last_flash_mission_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _expeditionKeysMeta = const VerificationMeta(
    'expeditionKeys',
  );
  @override
  late final GeneratedColumn<int> expeditionKeys = GeneratedColumn<int>(
    'expedition_keys',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _lastDailyKeyDateMeta = const VerificationMeta(
    'lastDailyKeyDate',
  );
  @override
  late final GeneratedColumn<String> lastDailyKeyDate = GeneratedColumn<String>(
    'last_daily_key_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heroUidMeta = const VerificationMeta(
    'heroUid',
  );
  @override
  late final GeneratedColumn<String> heroUid = GeneratedColumn<String>(
    'hero_uid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gratitudeSentCountMeta =
      const VerificationMeta('gratitudeSentCount');
  @override
  late final GeneratedColumn<int> gratitudeSentCount = GeneratedColumn<int>(
    'gratitude_sent_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastGratitudeSentLevelMeta =
      const VerificationMeta('lastGratitudeSentLevel');
  @override
  late final GeneratedColumn<int> lastGratitudeSentLevel = GeneratedColumn<int>(
    'last_gratitude_sent_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gratitudeReceivedCountMeta =
      const VerificationMeta('gratitudeReceivedCount');
  @override
  late final GeneratedColumn<int> gratitudeReceivedCount = GeneratedColumn<int>(
    'gratitude_received_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastGratitudeReceivedLevelMeta =
      const VerificationMeta('lastGratitudeReceivedLevel');
  @override
  late final GeneratedColumn<int> lastGratitudeReceivedLevel =
      GeneratedColumn<int>(
        'last_gratitude_received_level',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
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
    armorTint,
    soundEnabled,
    stepsToday,
    lastEncounterStepMilestone,
    lastFlashMissionAt,
    expeditionKeys,
    lastDailyKeyDate,
    heroUid,
    gratitudeSentCount,
    lastGratitudeSentLevel,
    gratitudeReceivedCount,
    lastGratitudeReceivedLevel,
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
    if (data.containsKey('armor_tint')) {
      context.handle(
        _armorTintMeta,
        armorTint.isAcceptableOrUnknown(data['armor_tint']!, _armorTintMeta),
      );
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    if (data.containsKey('steps_today')) {
      context.handle(
        _stepsTodayMeta,
        stepsToday.isAcceptableOrUnknown(data['steps_today']!, _stepsTodayMeta),
      );
    }
    if (data.containsKey('last_encounter_step_milestone')) {
      context.handle(
        _lastEncounterStepMilestoneMeta,
        lastEncounterStepMilestone.isAcceptableOrUnknown(
          data['last_encounter_step_milestone']!,
          _lastEncounterStepMilestoneMeta,
        ),
      );
    }
    if (data.containsKey('last_flash_mission_at')) {
      context.handle(
        _lastFlashMissionAtMeta,
        lastFlashMissionAt.isAcceptableOrUnknown(
          data['last_flash_mission_at']!,
          _lastFlashMissionAtMeta,
        ),
      );
    }
    if (data.containsKey('expedition_keys')) {
      context.handle(
        _expeditionKeysMeta,
        expeditionKeys.isAcceptableOrUnknown(
          data['expedition_keys']!,
          _expeditionKeysMeta,
        ),
      );
    }
    if (data.containsKey('last_daily_key_date')) {
      context.handle(
        _lastDailyKeyDateMeta,
        lastDailyKeyDate.isAcceptableOrUnknown(
          data['last_daily_key_date']!,
          _lastDailyKeyDateMeta,
        ),
      );
    }
    if (data.containsKey('hero_uid')) {
      context.handle(
        _heroUidMeta,
        heroUid.isAcceptableOrUnknown(data['hero_uid']!, _heroUidMeta),
      );
    }
    if (data.containsKey('gratitude_sent_count')) {
      context.handle(
        _gratitudeSentCountMeta,
        gratitudeSentCount.isAcceptableOrUnknown(
          data['gratitude_sent_count']!,
          _gratitudeSentCountMeta,
        ),
      );
    }
    if (data.containsKey('last_gratitude_sent_level')) {
      context.handle(
        _lastGratitudeSentLevelMeta,
        lastGratitudeSentLevel.isAcceptableOrUnknown(
          data['last_gratitude_sent_level']!,
          _lastGratitudeSentLevelMeta,
        ),
      );
    }
    if (data.containsKey('gratitude_received_count')) {
      context.handle(
        _gratitudeReceivedCountMeta,
        gratitudeReceivedCount.isAcceptableOrUnknown(
          data['gratitude_received_count']!,
          _gratitudeReceivedCountMeta,
        ),
      );
    }
    if (data.containsKey('last_gratitude_received_level')) {
      context.handle(
        _lastGratitudeReceivedLevelMeta,
        lastGratitudeReceivedLevel.isAcceptableOrUnknown(
          data['last_gratitude_received_level']!,
          _lastGratitudeReceivedLevelMeta,
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
      armorTint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}armor_tint'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      stepsToday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps_today'],
      )!,
      lastEncounterStepMilestone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_encounter_step_milestone'],
      )!,
      lastFlashMissionAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_flash_mission_at'],
      ),
      expeditionKeys: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expedition_keys'],
      )!,
      lastDailyKeyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_daily_key_date'],
      ),
      heroUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hero_uid'],
      ),
      gratitudeSentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gratitude_sent_count'],
      )!,
      lastGratitudeSentLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_gratitude_sent_level'],
      )!,
      gratitudeReceivedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gratitude_received_count'],
      )!,
      lastGratitudeReceivedLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_gratitude_received_level'],
      )!,
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
  final String armorTint;
  final bool soundEnabled;
  final int stepsToday;
  final int lastEncounterStepMilestone;
  final DateTime? lastFlashMissionAt;
  final int expeditionKeys;
  final String? lastDailyKeyDate;
  final String? heroUid;
  final int gratitudeSentCount;
  final int lastGratitudeSentLevel;
  final int gratitudeReceivedCount;
  final int lastGratitudeReceivedLevel;
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
    required this.armorTint,
    required this.soundEnabled,
    required this.stepsToday,
    required this.lastEncounterStepMilestone,
    this.lastFlashMissionAt,
    required this.expeditionKeys,
    this.lastDailyKeyDate,
    this.heroUid,
    required this.gratitudeSentCount,
    required this.lastGratitudeSentLevel,
    required this.gratitudeReceivedCount,
    required this.lastGratitudeReceivedLevel,
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
    map['armor_tint'] = Variable<String>(armorTint);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['steps_today'] = Variable<int>(stepsToday);
    map['last_encounter_step_milestone'] = Variable<int>(
      lastEncounterStepMilestone,
    );
    if (!nullToAbsent || lastFlashMissionAt != null) {
      map['last_flash_mission_at'] = Variable<DateTime>(lastFlashMissionAt);
    }
    map['expedition_keys'] = Variable<int>(expeditionKeys);
    if (!nullToAbsent || lastDailyKeyDate != null) {
      map['last_daily_key_date'] = Variable<String>(lastDailyKeyDate);
    }
    if (!nullToAbsent || heroUid != null) {
      map['hero_uid'] = Variable<String>(heroUid);
    }
    map['gratitude_sent_count'] = Variable<int>(gratitudeSentCount);
    map['last_gratitude_sent_level'] = Variable<int>(lastGratitudeSentLevel);
    map['gratitude_received_count'] = Variable<int>(gratitudeReceivedCount);
    map['last_gratitude_received_level'] = Variable<int>(
      lastGratitudeReceivedLevel,
    );
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
      armorTint: Value(armorTint),
      soundEnabled: Value(soundEnabled),
      stepsToday: Value(stepsToday),
      lastEncounterStepMilestone: Value(lastEncounterStepMilestone),
      lastFlashMissionAt: lastFlashMissionAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFlashMissionAt),
      expeditionKeys: Value(expeditionKeys),
      lastDailyKeyDate: lastDailyKeyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDailyKeyDate),
      heroUid: heroUid == null && nullToAbsent
          ? const Value.absent()
          : Value(heroUid),
      gratitudeSentCount: Value(gratitudeSentCount),
      lastGratitudeSentLevel: Value(lastGratitudeSentLevel),
      gratitudeReceivedCount: Value(gratitudeReceivedCount),
      lastGratitudeReceivedLevel: Value(lastGratitudeReceivedLevel),
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
      armorTint: serializer.fromJson<String>(json['armorTint']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      stepsToday: serializer.fromJson<int>(json['stepsToday']),
      lastEncounterStepMilestone: serializer.fromJson<int>(
        json['lastEncounterStepMilestone'],
      ),
      lastFlashMissionAt: serializer.fromJson<DateTime?>(
        json['lastFlashMissionAt'],
      ),
      expeditionKeys: serializer.fromJson<int>(json['expeditionKeys']),
      lastDailyKeyDate: serializer.fromJson<String?>(json['lastDailyKeyDate']),
      heroUid: serializer.fromJson<String?>(json['heroUid']),
      gratitudeSentCount: serializer.fromJson<int>(json['gratitudeSentCount']),
      lastGratitudeSentLevel: serializer.fromJson<int>(
        json['lastGratitudeSentLevel'],
      ),
      gratitudeReceivedCount: serializer.fromJson<int>(
        json['gratitudeReceivedCount'],
      ),
      lastGratitudeReceivedLevel: serializer.fromJson<int>(
        json['lastGratitudeReceivedLevel'],
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
      'armorTint': serializer.toJson<String>(armorTint),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'stepsToday': serializer.toJson<int>(stepsToday),
      'lastEncounterStepMilestone': serializer.toJson<int>(
        lastEncounterStepMilestone,
      ),
      'lastFlashMissionAt': serializer.toJson<DateTime?>(lastFlashMissionAt),
      'expeditionKeys': serializer.toJson<int>(expeditionKeys),
      'lastDailyKeyDate': serializer.toJson<String?>(lastDailyKeyDate),
      'heroUid': serializer.toJson<String?>(heroUid),
      'gratitudeSentCount': serializer.toJson<int>(gratitudeSentCount),
      'lastGratitudeSentLevel': serializer.toJson<int>(lastGratitudeSentLevel),
      'gratitudeReceivedCount': serializer.toJson<int>(gratitudeReceivedCount),
      'lastGratitudeReceivedLevel': serializer.toJson<int>(
        lastGratitudeReceivedLevel,
      ),
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
    String? armorTint,
    bool? soundEnabled,
    int? stepsToday,
    int? lastEncounterStepMilestone,
    Value<DateTime?> lastFlashMissionAt = const Value.absent(),
    int? expeditionKeys,
    Value<String?> lastDailyKeyDate = const Value.absent(),
    Value<String?> heroUid = const Value.absent(),
    int? gratitudeSentCount,
    int? lastGratitudeSentLevel,
    int? gratitudeReceivedCount,
    int? lastGratitudeReceivedLevel,
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
    armorTint: armorTint ?? this.armorTint,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    stepsToday: stepsToday ?? this.stepsToday,
    lastEncounterStepMilestone:
        lastEncounterStepMilestone ?? this.lastEncounterStepMilestone,
    lastFlashMissionAt: lastFlashMissionAt.present
        ? lastFlashMissionAt.value
        : this.lastFlashMissionAt,
    expeditionKeys: expeditionKeys ?? this.expeditionKeys,
    lastDailyKeyDate: lastDailyKeyDate.present
        ? lastDailyKeyDate.value
        : this.lastDailyKeyDate,
    heroUid: heroUid.present ? heroUid.value : this.heroUid,
    gratitudeSentCount: gratitudeSentCount ?? this.gratitudeSentCount,
    lastGratitudeSentLevel:
        lastGratitudeSentLevel ?? this.lastGratitudeSentLevel,
    gratitudeReceivedCount:
        gratitudeReceivedCount ?? this.gratitudeReceivedCount,
    lastGratitudeReceivedLevel:
        lastGratitudeReceivedLevel ?? this.lastGratitudeReceivedLevel,
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
      armorTint: data.armorTint.present ? data.armorTint.value : this.armorTint,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      stepsToday: data.stepsToday.present
          ? data.stepsToday.value
          : this.stepsToday,
      lastEncounterStepMilestone: data.lastEncounterStepMilestone.present
          ? data.lastEncounterStepMilestone.value
          : this.lastEncounterStepMilestone,
      lastFlashMissionAt: data.lastFlashMissionAt.present
          ? data.lastFlashMissionAt.value
          : this.lastFlashMissionAt,
      expeditionKeys: data.expeditionKeys.present
          ? data.expeditionKeys.value
          : this.expeditionKeys,
      lastDailyKeyDate: data.lastDailyKeyDate.present
          ? data.lastDailyKeyDate.value
          : this.lastDailyKeyDate,
      heroUid: data.heroUid.present ? data.heroUid.value : this.heroUid,
      gratitudeSentCount: data.gratitudeSentCount.present
          ? data.gratitudeSentCount.value
          : this.gratitudeSentCount,
      lastGratitudeSentLevel: data.lastGratitudeSentLevel.present
          ? data.lastGratitudeSentLevel.value
          : this.lastGratitudeSentLevel,
      gratitudeReceivedCount: data.gratitudeReceivedCount.present
          ? data.gratitudeReceivedCount.value
          : this.gratitudeReceivedCount,
      lastGratitudeReceivedLevel: data.lastGratitudeReceivedLevel.present
          ? data.lastGratitudeReceivedLevel.value
          : this.lastGratitudeReceivedLevel,
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
          ..write('armorTint: $armorTint, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('stepsToday: $stepsToday, ')
          ..write('lastEncounterStepMilestone: $lastEncounterStepMilestone, ')
          ..write('lastFlashMissionAt: $lastFlashMissionAt, ')
          ..write('expeditionKeys: $expeditionKeys, ')
          ..write('lastDailyKeyDate: $lastDailyKeyDate, ')
          ..write('heroUid: $heroUid, ')
          ..write('gratitudeSentCount: $gratitudeSentCount, ')
          ..write('lastGratitudeSentLevel: $lastGratitudeSentLevel, ')
          ..write('gratitudeReceivedCount: $gratitudeReceivedCount, ')
          ..write('lastGratitudeReceivedLevel: $lastGratitudeReceivedLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
    armorTint,
    soundEnabled,
    stepsToday,
    lastEncounterStepMilestone,
    lastFlashMissionAt,
    expeditionKeys,
    lastDailyKeyDate,
    heroUid,
    gratitudeSentCount,
    lastGratitudeSentLevel,
    gratitudeReceivedCount,
    lastGratitudeReceivedLevel,
    createdAt,
  ]);
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
          other.armorTint == this.armorTint &&
          other.soundEnabled == this.soundEnabled &&
          other.stepsToday == this.stepsToday &&
          other.lastEncounterStepMilestone == this.lastEncounterStepMilestone &&
          other.lastFlashMissionAt == this.lastFlashMissionAt &&
          other.expeditionKeys == this.expeditionKeys &&
          other.lastDailyKeyDate == this.lastDailyKeyDate &&
          other.heroUid == this.heroUid &&
          other.gratitudeSentCount == this.gratitudeSentCount &&
          other.lastGratitudeSentLevel == this.lastGratitudeSentLevel &&
          other.gratitudeReceivedCount == this.gratitudeReceivedCount &&
          other.lastGratitudeReceivedLevel == this.lastGratitudeReceivedLevel &&
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
  final Value<String> armorTint;
  final Value<bool> soundEnabled;
  final Value<int> stepsToday;
  final Value<int> lastEncounterStepMilestone;
  final Value<DateTime?> lastFlashMissionAt;
  final Value<int> expeditionKeys;
  final Value<String?> lastDailyKeyDate;
  final Value<String?> heroUid;
  final Value<int> gratitudeSentCount;
  final Value<int> lastGratitudeSentLevel;
  final Value<int> gratitudeReceivedCount;
  final Value<int> lastGratitudeReceivedLevel;
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
    this.armorTint = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.stepsToday = const Value.absent(),
    this.lastEncounterStepMilestone = const Value.absent(),
    this.lastFlashMissionAt = const Value.absent(),
    this.expeditionKeys = const Value.absent(),
    this.lastDailyKeyDate = const Value.absent(),
    this.heroUid = const Value.absent(),
    this.gratitudeSentCount = const Value.absent(),
    this.lastGratitudeSentLevel = const Value.absent(),
    this.gratitudeReceivedCount = const Value.absent(),
    this.lastGratitudeReceivedLevel = const Value.absent(),
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
    this.armorTint = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.stepsToday = const Value.absent(),
    this.lastEncounterStepMilestone = const Value.absent(),
    this.lastFlashMissionAt = const Value.absent(),
    this.expeditionKeys = const Value.absent(),
    this.lastDailyKeyDate = const Value.absent(),
    this.heroUid = const Value.absent(),
    this.gratitudeSentCount = const Value.absent(),
    this.lastGratitudeSentLevel = const Value.absent(),
    this.gratitudeReceivedCount = const Value.absent(),
    this.lastGratitudeReceivedLevel = const Value.absent(),
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
    Expression<String>? armorTint,
    Expression<bool>? soundEnabled,
    Expression<int>? stepsToday,
    Expression<int>? lastEncounterStepMilestone,
    Expression<DateTime>? lastFlashMissionAt,
    Expression<int>? expeditionKeys,
    Expression<String>? lastDailyKeyDate,
    Expression<String>? heroUid,
    Expression<int>? gratitudeSentCount,
    Expression<int>? lastGratitudeSentLevel,
    Expression<int>? gratitudeReceivedCount,
    Expression<int>? lastGratitudeReceivedLevel,
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
      if (armorTint != null) 'armor_tint': armorTint,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (stepsToday != null) 'steps_today': stepsToday,
      if (lastEncounterStepMilestone != null)
        'last_encounter_step_milestone': lastEncounterStepMilestone,
      if (lastFlashMissionAt != null)
        'last_flash_mission_at': lastFlashMissionAt,
      if (expeditionKeys != null) 'expedition_keys': expeditionKeys,
      if (lastDailyKeyDate != null) 'last_daily_key_date': lastDailyKeyDate,
      if (heroUid != null) 'hero_uid': heroUid,
      if (gratitudeSentCount != null)
        'gratitude_sent_count': gratitudeSentCount,
      if (lastGratitudeSentLevel != null)
        'last_gratitude_sent_level': lastGratitudeSentLevel,
      if (gratitudeReceivedCount != null)
        'gratitude_received_count': gratitudeReceivedCount,
      if (lastGratitudeReceivedLevel != null)
        'last_gratitude_received_level': lastGratitudeReceivedLevel,
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
    Value<String>? armorTint,
    Value<bool>? soundEnabled,
    Value<int>? stepsToday,
    Value<int>? lastEncounterStepMilestone,
    Value<DateTime?>? lastFlashMissionAt,
    Value<int>? expeditionKeys,
    Value<String?>? lastDailyKeyDate,
    Value<String?>? heroUid,
    Value<int>? gratitudeSentCount,
    Value<int>? lastGratitudeSentLevel,
    Value<int>? gratitudeReceivedCount,
    Value<int>? lastGratitudeReceivedLevel,
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
      armorTint: armorTint ?? this.armorTint,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      stepsToday: stepsToday ?? this.stepsToday,
      lastEncounterStepMilestone:
          lastEncounterStepMilestone ?? this.lastEncounterStepMilestone,
      lastFlashMissionAt: lastFlashMissionAt ?? this.lastFlashMissionAt,
      expeditionKeys: expeditionKeys ?? this.expeditionKeys,
      lastDailyKeyDate: lastDailyKeyDate ?? this.lastDailyKeyDate,
      heroUid: heroUid ?? this.heroUid,
      gratitudeSentCount: gratitudeSentCount ?? this.gratitudeSentCount,
      lastGratitudeSentLevel:
          lastGratitudeSentLevel ?? this.lastGratitudeSentLevel,
      gratitudeReceivedCount:
          gratitudeReceivedCount ?? this.gratitudeReceivedCount,
      lastGratitudeReceivedLevel:
          lastGratitudeReceivedLevel ?? this.lastGratitudeReceivedLevel,
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
    if (armorTint.present) {
      map['armor_tint'] = Variable<String>(armorTint.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (stepsToday.present) {
      map['steps_today'] = Variable<int>(stepsToday.value);
    }
    if (lastEncounterStepMilestone.present) {
      map['last_encounter_step_milestone'] = Variable<int>(
        lastEncounterStepMilestone.value,
      );
    }
    if (lastFlashMissionAt.present) {
      map['last_flash_mission_at'] = Variable<DateTime>(
        lastFlashMissionAt.value,
      );
    }
    if (expeditionKeys.present) {
      map['expedition_keys'] = Variable<int>(expeditionKeys.value);
    }
    if (lastDailyKeyDate.present) {
      map['last_daily_key_date'] = Variable<String>(lastDailyKeyDate.value);
    }
    if (heroUid.present) {
      map['hero_uid'] = Variable<String>(heroUid.value);
    }
    if (gratitudeSentCount.present) {
      map['gratitude_sent_count'] = Variable<int>(gratitudeSentCount.value);
    }
    if (lastGratitudeSentLevel.present) {
      map['last_gratitude_sent_level'] = Variable<int>(
        lastGratitudeSentLevel.value,
      );
    }
    if (gratitudeReceivedCount.present) {
      map['gratitude_received_count'] = Variable<int>(
        gratitudeReceivedCount.value,
      );
    }
    if (lastGratitudeReceivedLevel.present) {
      map['last_gratitude_received_level'] = Variable<int>(
        lastGratitudeReceivedLevel.value,
      );
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
          ..write('armorTint: $armorTint, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('stepsToday: $stepsToday, ')
          ..write('lastEncounterStepMilestone: $lastEncounterStepMilestone, ')
          ..write('lastFlashMissionAt: $lastFlashMissionAt, ')
          ..write('expeditionKeys: $expeditionKeys, ')
          ..write('lastDailyKeyDate: $lastDailyKeyDate, ')
          ..write('heroUid: $heroUid, ')
          ..write('gratitudeSentCount: $gratitudeSentCount, ')
          ..write('lastGratitudeSentLevel: $lastGratitudeSentLevel, ')
          ..write('gratitudeReceivedCount: $gratitudeReceivedCount, ')
          ..write('lastGratitudeReceivedLevel: $lastGratitudeReceivedLevel, ')
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
    attributeKey,
    isCompleted,
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
    if (data.containsKey('attribute_key')) {
      context.handle(
        _attributeKeyMeta,
        attributeKey.isAcceptableOrUnknown(
          data['attribute_key']!,
          _attributeKeyMeta,
        ),
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
      attributeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_key'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
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
  final String attributeKey;
  final bool isCompleted;
  final DateTime syncedAt;
  const CalendarEvent({
    required this.id,
    this.googleEventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
    this.location,
    required this.attributeKey,
    required this.isCompleted,
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
    map['attribute_key'] = Variable<String>(attributeKey);
    map['is_completed'] = Variable<bool>(isCompleted);
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
      attributeKey: Value(attributeKey),
      isCompleted: Value(isCompleted),
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
      attributeKey: serializer.fromJson<String>(json['attributeKey']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
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
      'attributeKey': serializer.toJson<String>(attributeKey),
      'isCompleted': serializer.toJson<bool>(isCompleted),
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
    String? attributeKey,
    bool? isCompleted,
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
    attributeKey: attributeKey ?? this.attributeKey,
    isCompleted: isCompleted ?? this.isCompleted,
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
      attributeKey: data.attributeKey.present
          ? data.attributeKey.value
          : this.attributeKey,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
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
          ..write('attributeKey: $attributeKey, ')
          ..write('isCompleted: $isCompleted, ')
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
    attributeKey,
    isCompleted,
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
          other.attributeKey == this.attributeKey &&
          other.isCompleted == this.isCompleted &&
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
  final Value<String> attributeKey;
  final Value<bool> isCompleted;
  final Value<DateTime> syncedAt;
  const CalendarEventsCompanion({
    this.id = const Value.absent(),
    this.googleEventId = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.location = const Value.absent(),
    this.attributeKey = const Value.absent(),
    this.isCompleted = const Value.absent(),
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
    this.attributeKey = const Value.absent(),
    this.isCompleted = const Value.absent(),
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
    Expression<String>? attributeKey,
    Expression<bool>? isCompleted,
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
      if (attributeKey != null) 'attribute_key': attributeKey,
      if (isCompleted != null) 'is_completed': isCompleted,
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
    Value<String>? attributeKey,
    Value<bool>? isCompleted,
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
      attributeKey: attributeKey ?? this.attributeKey,
      isCompleted: isCompleted ?? this.isCompleted,
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
    if (attributeKey.present) {
      map['attribute_key'] = Variable<String>(attributeKey.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
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
          ..write('attributeKey: $attributeKey, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $DungeonInventoryTable extends DungeonInventory
    with TableInfo<$DungeonInventoryTable, DungeonInventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DungeonInventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<String> slot = GeneratedColumn<String>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    itemId,
    slot,
    quantity,
    isEquipped,
    acquiredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dungeon_inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<DungeonInventoryData> instance, {
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
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('is_equipped')) {
      context.handle(
        _isEquippedMeta,
        isEquipped.isAcceptableOrUnknown(data['is_equipped']!, _isEquippedMeta),
      );
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  DungeonInventoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DungeonInventoryData(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      isEquipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_equipped'],
      )!,
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      )!,
    );
  }

  @override
  $DungeonInventoryTable createAlias(String alias) {
    return $DungeonInventoryTable(attachedDatabase, alias);
  }
}

class DungeonInventoryData extends DataClass
    implements Insertable<DungeonInventoryData> {
  final String itemId;
  final String slot;
  final int quantity;
  final bool isEquipped;
  final DateTime acquiredAt;
  const DungeonInventoryData({
    required this.itemId,
    required this.slot,
    required this.quantity,
    required this.isEquipped,
    required this.acquiredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['slot'] = Variable<String>(slot);
    map['quantity'] = Variable<int>(quantity);
    map['is_equipped'] = Variable<bool>(isEquipped);
    map['acquired_at'] = Variable<DateTime>(acquiredAt);
    return map;
  }

  DungeonInventoryCompanion toCompanion(bool nullToAbsent) {
    return DungeonInventoryCompanion(
      itemId: Value(itemId),
      slot: Value(slot),
      quantity: Value(quantity),
      isEquipped: Value(isEquipped),
      acquiredAt: Value(acquiredAt),
    );
  }

  factory DungeonInventoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DungeonInventoryData(
      itemId: serializer.fromJson<String>(json['itemId']),
      slot: serializer.fromJson<String>(json['slot']),
      quantity: serializer.fromJson<int>(json['quantity']),
      isEquipped: serializer.fromJson<bool>(json['isEquipped']),
      acquiredAt: serializer.fromJson<DateTime>(json['acquiredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'slot': serializer.toJson<String>(slot),
      'quantity': serializer.toJson<int>(quantity),
      'isEquipped': serializer.toJson<bool>(isEquipped),
      'acquiredAt': serializer.toJson<DateTime>(acquiredAt),
    };
  }

  DungeonInventoryData copyWith({
    String? itemId,
    String? slot,
    int? quantity,
    bool? isEquipped,
    DateTime? acquiredAt,
  }) => DungeonInventoryData(
    itemId: itemId ?? this.itemId,
    slot: slot ?? this.slot,
    quantity: quantity ?? this.quantity,
    isEquipped: isEquipped ?? this.isEquipped,
    acquiredAt: acquiredAt ?? this.acquiredAt,
  );
  DungeonInventoryData copyWithCompanion(DungeonInventoryCompanion data) {
    return DungeonInventoryData(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      slot: data.slot.present ? data.slot.value : this.slot,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      isEquipped: data.isEquipped.present
          ? data.isEquipped.value
          : this.isEquipped,
      acquiredAt: data.acquiredAt.present
          ? data.acquiredAt.value
          : this.acquiredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DungeonInventoryData(')
          ..write('itemId: $itemId, ')
          ..write('slot: $slot, ')
          ..write('quantity: $quantity, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('acquiredAt: $acquiredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(itemId, slot, quantity, isEquipped, acquiredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DungeonInventoryData &&
          other.itemId == this.itemId &&
          other.slot == this.slot &&
          other.quantity == this.quantity &&
          other.isEquipped == this.isEquipped &&
          other.acquiredAt == this.acquiredAt);
}

class DungeonInventoryCompanion extends UpdateCompanion<DungeonInventoryData> {
  final Value<String> itemId;
  final Value<String> slot;
  final Value<int> quantity;
  final Value<bool> isEquipped;
  final Value<DateTime> acquiredAt;
  final Value<int> rowid;
  const DungeonInventoryCompanion({
    this.itemId = const Value.absent(),
    this.slot = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DungeonInventoryCompanion.insert({
    required String itemId,
    required String slot,
    this.quantity = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       slot = Value(slot);
  static Insertable<DungeonInventoryData> custom({
    Expression<String>? itemId,
    Expression<String>? slot,
    Expression<int>? quantity,
    Expression<bool>? isEquipped,
    Expression<DateTime>? acquiredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (slot != null) 'slot': slot,
      if (quantity != null) 'quantity': quantity,
      if (isEquipped != null) 'is_equipped': isEquipped,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DungeonInventoryCompanion copyWith({
    Value<String>? itemId,
    Value<String>? slot,
    Value<int>? quantity,
    Value<bool>? isEquipped,
    Value<DateTime>? acquiredAt,
    Value<int>? rowid,
  }) {
    return DungeonInventoryCompanion(
      itemId: itemId ?? this.itemId,
      slot: slot ?? this.slot,
      quantity: quantity ?? this.quantity,
      isEquipped: isEquipped ?? this.isEquipped,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<String>(slot.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (isEquipped.present) {
      map['is_equipped'] = Variable<bool>(isEquipped.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DungeonInventoryCompanion(')
          ..write('itemId: $itemId, ')
          ..write('slot: $slot, ')
          ..write('quantity: $quantity, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DungeonProgressTable extends DungeonProgress
    with TableInfo<$DungeonProgressTable, DungeonProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DungeonProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _biomeKeyMeta = const VerificationMeta(
    'biomeKey',
  );
  @override
  late final GeneratedColumn<String> biomeKey = GeneratedColumn<String>(
    'biome_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bestFloorMeta = const VerificationMeta(
    'bestFloor',
  );
  @override
  late final GeneratedColumn<int> bestFloor = GeneratedColumn<int>(
    'best_floor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _clearsCountMeta = const VerificationMeta(
    'clearsCount',
  );
  @override
  late final GeneratedColumn<int> clearsCount = GeneratedColumn<int>(
    'clears_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSeedMeta = const VerificationMeta(
    'lastSeed',
  );
  @override
  late final GeneratedColumn<int> lastSeed = GeneratedColumn<int>(
    'last_seed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    biomeKey,
    bestFloor,
    clearsCount,
    lastSeed,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dungeon_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<DungeonProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('biome_key')) {
      context.handle(
        _biomeKeyMeta,
        biomeKey.isAcceptableOrUnknown(data['biome_key']!, _biomeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_biomeKeyMeta);
    }
    if (data.containsKey('best_floor')) {
      context.handle(
        _bestFloorMeta,
        bestFloor.isAcceptableOrUnknown(data['best_floor']!, _bestFloorMeta),
      );
    }
    if (data.containsKey('clears_count')) {
      context.handle(
        _clearsCountMeta,
        clearsCount.isAcceptableOrUnknown(
          data['clears_count']!,
          _clearsCountMeta,
        ),
      );
    }
    if (data.containsKey('last_seed')) {
      context.handle(
        _lastSeedMeta,
        lastSeed.isAcceptableOrUnknown(data['last_seed']!, _lastSeedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {biomeKey};
  @override
  DungeonProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DungeonProgressData(
      biomeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biome_key'],
      )!,
      bestFloor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_floor'],
      )!,
      clearsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}clears_count'],
      )!,
      lastSeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seed'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DungeonProgressTable createAlias(String alias) {
    return $DungeonProgressTable(attachedDatabase, alias);
  }
}

class DungeonProgressData extends DataClass
    implements Insertable<DungeonProgressData> {
  final String biomeKey;
  final int bestFloor;
  final int clearsCount;
  final int? lastSeed;
  final DateTime updatedAt;
  const DungeonProgressData({
    required this.biomeKey,
    required this.bestFloor,
    required this.clearsCount,
    this.lastSeed,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['biome_key'] = Variable<String>(biomeKey);
    map['best_floor'] = Variable<int>(bestFloor);
    map['clears_count'] = Variable<int>(clearsCount);
    if (!nullToAbsent || lastSeed != null) {
      map['last_seed'] = Variable<int>(lastSeed);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DungeonProgressCompanion toCompanion(bool nullToAbsent) {
    return DungeonProgressCompanion(
      biomeKey: Value(biomeKey),
      bestFloor: Value(bestFloor),
      clearsCount: Value(clearsCount),
      lastSeed: lastSeed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeed),
      updatedAt: Value(updatedAt),
    );
  }

  factory DungeonProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DungeonProgressData(
      biomeKey: serializer.fromJson<String>(json['biomeKey']),
      bestFloor: serializer.fromJson<int>(json['bestFloor']),
      clearsCount: serializer.fromJson<int>(json['clearsCount']),
      lastSeed: serializer.fromJson<int?>(json['lastSeed']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'biomeKey': serializer.toJson<String>(biomeKey),
      'bestFloor': serializer.toJson<int>(bestFloor),
      'clearsCount': serializer.toJson<int>(clearsCount),
      'lastSeed': serializer.toJson<int?>(lastSeed),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DungeonProgressData copyWith({
    String? biomeKey,
    int? bestFloor,
    int? clearsCount,
    Value<int?> lastSeed = const Value.absent(),
    DateTime? updatedAt,
  }) => DungeonProgressData(
    biomeKey: biomeKey ?? this.biomeKey,
    bestFloor: bestFloor ?? this.bestFloor,
    clearsCount: clearsCount ?? this.clearsCount,
    lastSeed: lastSeed.present ? lastSeed.value : this.lastSeed,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DungeonProgressData copyWithCompanion(DungeonProgressCompanion data) {
    return DungeonProgressData(
      biomeKey: data.biomeKey.present ? data.biomeKey.value : this.biomeKey,
      bestFloor: data.bestFloor.present ? data.bestFloor.value : this.bestFloor,
      clearsCount: data.clearsCount.present
          ? data.clearsCount.value
          : this.clearsCount,
      lastSeed: data.lastSeed.present ? data.lastSeed.value : this.lastSeed,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DungeonProgressData(')
          ..write('biomeKey: $biomeKey, ')
          ..write('bestFloor: $bestFloor, ')
          ..write('clearsCount: $clearsCount, ')
          ..write('lastSeed: $lastSeed, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(biomeKey, bestFloor, clearsCount, lastSeed, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DungeonProgressData &&
          other.biomeKey == this.biomeKey &&
          other.bestFloor == this.bestFloor &&
          other.clearsCount == this.clearsCount &&
          other.lastSeed == this.lastSeed &&
          other.updatedAt == this.updatedAt);
}

class DungeonProgressCompanion extends UpdateCompanion<DungeonProgressData> {
  final Value<String> biomeKey;
  final Value<int> bestFloor;
  final Value<int> clearsCount;
  final Value<int?> lastSeed;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DungeonProgressCompanion({
    this.biomeKey = const Value.absent(),
    this.bestFloor = const Value.absent(),
    this.clearsCount = const Value.absent(),
    this.lastSeed = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DungeonProgressCompanion.insert({
    required String biomeKey,
    this.bestFloor = const Value.absent(),
    this.clearsCount = const Value.absent(),
    this.lastSeed = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : biomeKey = Value(biomeKey);
  static Insertable<DungeonProgressData> custom({
    Expression<String>? biomeKey,
    Expression<int>? bestFloor,
    Expression<int>? clearsCount,
    Expression<int>? lastSeed,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (biomeKey != null) 'biome_key': biomeKey,
      if (bestFloor != null) 'best_floor': bestFloor,
      if (clearsCount != null) 'clears_count': clearsCount,
      if (lastSeed != null) 'last_seed': lastSeed,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DungeonProgressCompanion copyWith({
    Value<String>? biomeKey,
    Value<int>? bestFloor,
    Value<int>? clearsCount,
    Value<int?>? lastSeed,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DungeonProgressCompanion(
      biomeKey: biomeKey ?? this.biomeKey,
      bestFloor: bestFloor ?? this.bestFloor,
      clearsCount: clearsCount ?? this.clearsCount,
      lastSeed: lastSeed ?? this.lastSeed,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (biomeKey.present) {
      map['biome_key'] = Variable<String>(biomeKey.value);
    }
    if (bestFloor.present) {
      map['best_floor'] = Variable<int>(bestFloor.value);
    }
    if (clearsCount.present) {
      map['clears_count'] = Variable<int>(clearsCount.value);
    }
    if (lastSeed.present) {
      map['last_seed'] = Variable<int>(lastSeed.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DungeonProgressCompanion(')
          ..write('biomeKey: $biomeKey, ')
          ..write('bestFloor: $bestFloor, ')
          ..write('clearsCount: $clearsCount, ')
          ..write('lastSeed: $lastSeed, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GratitudeLogsTable extends GratitudeLogs
    with TableInfo<$GratitudeLogsTable, GratitudeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GratitudeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tokenIdMeta = const VerificationMeta(
    'tokenId',
  );
  @override
  late final GeneratedColumn<String> tokenId = GeneratedColumn<String>(
    'token_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _peerNameMeta = const VerificationMeta(
    'peerName',
  );
  @override
  late final GeneratedColumn<String> peerName = GeneratedColumn<String>(
    'peer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _xpAmountMeta = const VerificationMeta(
    'xpAmount',
  );
  @override
  late final GeneratedColumn<int> xpAmount = GeneratedColumn<int>(
    'xp_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldAmountMeta = const VerificationMeta(
    'goldAmount',
  );
  @override
  late final GeneratedColumn<int> goldAmount = GeneratedColumn<int>(
    'gold_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sealCodeMeta = const VerificationMeta(
    'sealCode',
  );
  @override
  late final GeneratedColumn<String> sealCode = GeneratedColumn<String>(
    'seal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    tokenId,
    direction,
    peerName,
    note,
    xpAmount,
    goldAmount,
    itemId,
    itemName,
    sealCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gratitude_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<GratitudeLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token_id')) {
      context.handle(
        _tokenIdMeta,
        tokenId.isAcceptableOrUnknown(data['token_id']!, _tokenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('peer_name')) {
      context.handle(
        _peerNameMeta,
        peerName.isAcceptableOrUnknown(data['peer_name']!, _peerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_peerNameMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('xp_amount')) {
      context.handle(
        _xpAmountMeta,
        xpAmount.isAcceptableOrUnknown(data['xp_amount']!, _xpAmountMeta),
      );
    }
    if (data.containsKey('gold_amount')) {
      context.handle(
        _goldAmountMeta,
        goldAmount.isAcceptableOrUnknown(data['gold_amount']!, _goldAmountMeta),
      );
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    }
    if (data.containsKey('seal_code')) {
      context.handle(
        _sealCodeMeta,
        sealCode.isAcceptableOrUnknown(data['seal_code']!, _sealCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_sealCodeMeta);
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
  Set<GeneratedColumn> get $primaryKey => {tokenId};
  @override
  GratitudeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GratitudeLog(
      tokenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      peerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}peer_name'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      xpAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_amount'],
      )!,
      goldAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold_amount'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      ),
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      ),
      sealCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seal_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GratitudeLogsTable createAlias(String alias) {
    return $GratitudeLogsTable(attachedDatabase, alias);
  }
}

class GratitudeLog extends DataClass implements Insertable<GratitudeLog> {
  final String tokenId;
  final String direction;
  final String peerName;
  final String note;
  final int xpAmount;
  final int goldAmount;
  final String? itemId;
  final String? itemName;
  final String sealCode;
  final DateTime createdAt;
  const GratitudeLog({
    required this.tokenId,
    required this.direction,
    required this.peerName,
    required this.note,
    required this.xpAmount,
    required this.goldAmount,
    this.itemId,
    this.itemName,
    required this.sealCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['token_id'] = Variable<String>(tokenId);
    map['direction'] = Variable<String>(direction);
    map['peer_name'] = Variable<String>(peerName);
    map['note'] = Variable<String>(note);
    map['xp_amount'] = Variable<int>(xpAmount);
    map['gold_amount'] = Variable<int>(goldAmount);
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<String>(itemId);
    }
    if (!nullToAbsent || itemName != null) {
      map['item_name'] = Variable<String>(itemName);
    }
    map['seal_code'] = Variable<String>(sealCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GratitudeLogsCompanion toCompanion(bool nullToAbsent) {
    return GratitudeLogsCompanion(
      tokenId: Value(tokenId),
      direction: Value(direction),
      peerName: Value(peerName),
      note: Value(note),
      xpAmount: Value(xpAmount),
      goldAmount: Value(goldAmount),
      itemId: itemId == null && nullToAbsent
          ? const Value.absent()
          : Value(itemId),
      itemName: itemName == null && nullToAbsent
          ? const Value.absent()
          : Value(itemName),
      sealCode: Value(sealCode),
      createdAt: Value(createdAt),
    );
  }

  factory GratitudeLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GratitudeLog(
      tokenId: serializer.fromJson<String>(json['tokenId']),
      direction: serializer.fromJson<String>(json['direction']),
      peerName: serializer.fromJson<String>(json['peerName']),
      note: serializer.fromJson<String>(json['note']),
      xpAmount: serializer.fromJson<int>(json['xpAmount']),
      goldAmount: serializer.fromJson<int>(json['goldAmount']),
      itemId: serializer.fromJson<String?>(json['itemId']),
      itemName: serializer.fromJson<String?>(json['itemName']),
      sealCode: serializer.fromJson<String>(json['sealCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tokenId': serializer.toJson<String>(tokenId),
      'direction': serializer.toJson<String>(direction),
      'peerName': serializer.toJson<String>(peerName),
      'note': serializer.toJson<String>(note),
      'xpAmount': serializer.toJson<int>(xpAmount),
      'goldAmount': serializer.toJson<int>(goldAmount),
      'itemId': serializer.toJson<String?>(itemId),
      'itemName': serializer.toJson<String?>(itemName),
      'sealCode': serializer.toJson<String>(sealCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GratitudeLog copyWith({
    String? tokenId,
    String? direction,
    String? peerName,
    String? note,
    int? xpAmount,
    int? goldAmount,
    Value<String?> itemId = const Value.absent(),
    Value<String?> itemName = const Value.absent(),
    String? sealCode,
    DateTime? createdAt,
  }) => GratitudeLog(
    tokenId: tokenId ?? this.tokenId,
    direction: direction ?? this.direction,
    peerName: peerName ?? this.peerName,
    note: note ?? this.note,
    xpAmount: xpAmount ?? this.xpAmount,
    goldAmount: goldAmount ?? this.goldAmount,
    itemId: itemId.present ? itemId.value : this.itemId,
    itemName: itemName.present ? itemName.value : this.itemName,
    sealCode: sealCode ?? this.sealCode,
    createdAt: createdAt ?? this.createdAt,
  );
  GratitudeLog copyWithCompanion(GratitudeLogsCompanion data) {
    return GratitudeLog(
      tokenId: data.tokenId.present ? data.tokenId.value : this.tokenId,
      direction: data.direction.present ? data.direction.value : this.direction,
      peerName: data.peerName.present ? data.peerName.value : this.peerName,
      note: data.note.present ? data.note.value : this.note,
      xpAmount: data.xpAmount.present ? data.xpAmount.value : this.xpAmount,
      goldAmount: data.goldAmount.present
          ? data.goldAmount.value
          : this.goldAmount,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      sealCode: data.sealCode.present ? data.sealCode.value : this.sealCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GratitudeLog(')
          ..write('tokenId: $tokenId, ')
          ..write('direction: $direction, ')
          ..write('peerName: $peerName, ')
          ..write('note: $note, ')
          ..write('xpAmount: $xpAmount, ')
          ..write('goldAmount: $goldAmount, ')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('sealCode: $sealCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    tokenId,
    direction,
    peerName,
    note,
    xpAmount,
    goldAmount,
    itemId,
    itemName,
    sealCode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GratitudeLog &&
          other.tokenId == this.tokenId &&
          other.direction == this.direction &&
          other.peerName == this.peerName &&
          other.note == this.note &&
          other.xpAmount == this.xpAmount &&
          other.goldAmount == this.goldAmount &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.sealCode == this.sealCode &&
          other.createdAt == this.createdAt);
}

class GratitudeLogsCompanion extends UpdateCompanion<GratitudeLog> {
  final Value<String> tokenId;
  final Value<String> direction;
  final Value<String> peerName;
  final Value<String> note;
  final Value<int> xpAmount;
  final Value<int> goldAmount;
  final Value<String?> itemId;
  final Value<String?> itemName;
  final Value<String> sealCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GratitudeLogsCompanion({
    this.tokenId = const Value.absent(),
    this.direction = const Value.absent(),
    this.peerName = const Value.absent(),
    this.note = const Value.absent(),
    this.xpAmount = const Value.absent(),
    this.goldAmount = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.sealCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GratitudeLogsCompanion.insert({
    required String tokenId,
    required String direction,
    required String peerName,
    this.note = const Value.absent(),
    this.xpAmount = const Value.absent(),
    this.goldAmount = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    required String sealCode,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tokenId = Value(tokenId),
       direction = Value(direction),
       peerName = Value(peerName),
       sealCode = Value(sealCode);
  static Insertable<GratitudeLog> custom({
    Expression<String>? tokenId,
    Expression<String>? direction,
    Expression<String>? peerName,
    Expression<String>? note,
    Expression<int>? xpAmount,
    Expression<int>? goldAmount,
    Expression<String>? itemId,
    Expression<String>? itemName,
    Expression<String>? sealCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tokenId != null) 'token_id': tokenId,
      if (direction != null) 'direction': direction,
      if (peerName != null) 'peer_name': peerName,
      if (note != null) 'note': note,
      if (xpAmount != null) 'xp_amount': xpAmount,
      if (goldAmount != null) 'gold_amount': goldAmount,
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (sealCode != null) 'seal_code': sealCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GratitudeLogsCompanion copyWith({
    Value<String>? tokenId,
    Value<String>? direction,
    Value<String>? peerName,
    Value<String>? note,
    Value<int>? xpAmount,
    Value<int>? goldAmount,
    Value<String?>? itemId,
    Value<String?>? itemName,
    Value<String>? sealCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GratitudeLogsCompanion(
      tokenId: tokenId ?? this.tokenId,
      direction: direction ?? this.direction,
      peerName: peerName ?? this.peerName,
      note: note ?? this.note,
      xpAmount: xpAmount ?? this.xpAmount,
      goldAmount: goldAmount ?? this.goldAmount,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      sealCode: sealCode ?? this.sealCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tokenId.present) {
      map['token_id'] = Variable<String>(tokenId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (peerName.present) {
      map['peer_name'] = Variable<String>(peerName.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (xpAmount.present) {
      map['xp_amount'] = Variable<int>(xpAmount.value);
    }
    if (goldAmount.present) {
      map['gold_amount'] = Variable<int>(goldAmount.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (sealCode.present) {
      map['seal_code'] = Variable<String>(sealCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GratitudeLogsCompanion(')
          ..write('tokenId: $tokenId, ')
          ..write('direction: $direction, ')
          ..write('peerName: $peerName, ')
          ..write('note: $note, ')
          ..write('xpAmount: $xpAmount, ')
          ..write('goldAmount: $goldAmount, ')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('sealCode: $sealCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BestiaryDiscoveriesTable extends BestiaryDiscoveries
    with TableInfo<$BestiaryDiscoveriesTable, BestiaryDiscovery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BestiaryDiscoveriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _monsterIdMeta = const VerificationMeta(
    'monsterId',
  );
  @override
  late final GeneratedColumn<String> monsterId = GeneratedColumn<String>(
    'monster_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defeatedCountMeta = const VerificationMeta(
    'defeatedCount',
  );
  @override
  late final GeneratedColumn<int> defeatedCount = GeneratedColumn<int>(
    'defeated_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _firstDefeatedAtMeta = const VerificationMeta(
    'firstDefeatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> firstDefeatedAt =
      GeneratedColumn<DateTime>(
        'first_defeated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _lastDefeatedAtMeta = const VerificationMeta(
    'lastDefeatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastDefeatedAt =
      GeneratedColumn<DateTime>(
        'last_defeated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    monsterId,
    defeatedCount,
    firstDefeatedAt,
    lastDefeatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bestiary_discoveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<BestiaryDiscovery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('monster_id')) {
      context.handle(
        _monsterIdMeta,
        monsterId.isAcceptableOrUnknown(data['monster_id']!, _monsterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_monsterIdMeta);
    }
    if (data.containsKey('defeated_count')) {
      context.handle(
        _defeatedCountMeta,
        defeatedCount.isAcceptableOrUnknown(
          data['defeated_count']!,
          _defeatedCountMeta,
        ),
      );
    }
    if (data.containsKey('first_defeated_at')) {
      context.handle(
        _firstDefeatedAtMeta,
        firstDefeatedAt.isAcceptableOrUnknown(
          data['first_defeated_at']!,
          _firstDefeatedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_defeated_at')) {
      context.handle(
        _lastDefeatedAtMeta,
        lastDefeatedAt.isAcceptableOrUnknown(
          data['last_defeated_at']!,
          _lastDefeatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {monsterId};
  @override
  BestiaryDiscovery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BestiaryDiscovery(
      monsterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}monster_id'],
      )!,
      defeatedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defeated_count'],
      )!,
      firstDefeatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_defeated_at'],
      )!,
      lastDefeatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_defeated_at'],
      )!,
    );
  }

  @override
  $BestiaryDiscoveriesTable createAlias(String alias) {
    return $BestiaryDiscoveriesTable(attachedDatabase, alias);
  }
}

class BestiaryDiscovery extends DataClass
    implements Insertable<BestiaryDiscovery> {
  final String monsterId;
  final int defeatedCount;
  final DateTime firstDefeatedAt;
  final DateTime lastDefeatedAt;
  const BestiaryDiscovery({
    required this.monsterId,
    required this.defeatedCount,
    required this.firstDefeatedAt,
    required this.lastDefeatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['monster_id'] = Variable<String>(monsterId);
    map['defeated_count'] = Variable<int>(defeatedCount);
    map['first_defeated_at'] = Variable<DateTime>(firstDefeatedAt);
    map['last_defeated_at'] = Variable<DateTime>(lastDefeatedAt);
    return map;
  }

  BestiaryDiscoveriesCompanion toCompanion(bool nullToAbsent) {
    return BestiaryDiscoveriesCompanion(
      monsterId: Value(monsterId),
      defeatedCount: Value(defeatedCount),
      firstDefeatedAt: Value(firstDefeatedAt),
      lastDefeatedAt: Value(lastDefeatedAt),
    );
  }

  factory BestiaryDiscovery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BestiaryDiscovery(
      monsterId: serializer.fromJson<String>(json['monsterId']),
      defeatedCount: serializer.fromJson<int>(json['defeatedCount']),
      firstDefeatedAt: serializer.fromJson<DateTime>(json['firstDefeatedAt']),
      lastDefeatedAt: serializer.fromJson<DateTime>(json['lastDefeatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'monsterId': serializer.toJson<String>(monsterId),
      'defeatedCount': serializer.toJson<int>(defeatedCount),
      'firstDefeatedAt': serializer.toJson<DateTime>(firstDefeatedAt),
      'lastDefeatedAt': serializer.toJson<DateTime>(lastDefeatedAt),
    };
  }

  BestiaryDiscovery copyWith({
    String? monsterId,
    int? defeatedCount,
    DateTime? firstDefeatedAt,
    DateTime? lastDefeatedAt,
  }) => BestiaryDiscovery(
    monsterId: monsterId ?? this.monsterId,
    defeatedCount: defeatedCount ?? this.defeatedCount,
    firstDefeatedAt: firstDefeatedAt ?? this.firstDefeatedAt,
    lastDefeatedAt: lastDefeatedAt ?? this.lastDefeatedAt,
  );
  BestiaryDiscovery copyWithCompanion(BestiaryDiscoveriesCompanion data) {
    return BestiaryDiscovery(
      monsterId: data.monsterId.present ? data.monsterId.value : this.monsterId,
      defeatedCount: data.defeatedCount.present
          ? data.defeatedCount.value
          : this.defeatedCount,
      firstDefeatedAt: data.firstDefeatedAt.present
          ? data.firstDefeatedAt.value
          : this.firstDefeatedAt,
      lastDefeatedAt: data.lastDefeatedAt.present
          ? data.lastDefeatedAt.value
          : this.lastDefeatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BestiaryDiscovery(')
          ..write('monsterId: $monsterId, ')
          ..write('defeatedCount: $defeatedCount, ')
          ..write('firstDefeatedAt: $firstDefeatedAt, ')
          ..write('lastDefeatedAt: $lastDefeatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(monsterId, defeatedCount, firstDefeatedAt, lastDefeatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BestiaryDiscovery &&
          other.monsterId == this.monsterId &&
          other.defeatedCount == this.defeatedCount &&
          other.firstDefeatedAt == this.firstDefeatedAt &&
          other.lastDefeatedAt == this.lastDefeatedAt);
}

class BestiaryDiscoveriesCompanion extends UpdateCompanion<BestiaryDiscovery> {
  final Value<String> monsterId;
  final Value<int> defeatedCount;
  final Value<DateTime> firstDefeatedAt;
  final Value<DateTime> lastDefeatedAt;
  final Value<int> rowid;
  const BestiaryDiscoveriesCompanion({
    this.monsterId = const Value.absent(),
    this.defeatedCount = const Value.absent(),
    this.firstDefeatedAt = const Value.absent(),
    this.lastDefeatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BestiaryDiscoveriesCompanion.insert({
    required String monsterId,
    this.defeatedCount = const Value.absent(),
    this.firstDefeatedAt = const Value.absent(),
    this.lastDefeatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : monsterId = Value(monsterId);
  static Insertable<BestiaryDiscovery> custom({
    Expression<String>? monsterId,
    Expression<int>? defeatedCount,
    Expression<DateTime>? firstDefeatedAt,
    Expression<DateTime>? lastDefeatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (monsterId != null) 'monster_id': monsterId,
      if (defeatedCount != null) 'defeated_count': defeatedCount,
      if (firstDefeatedAt != null) 'first_defeated_at': firstDefeatedAt,
      if (lastDefeatedAt != null) 'last_defeated_at': lastDefeatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BestiaryDiscoveriesCompanion copyWith({
    Value<String>? monsterId,
    Value<int>? defeatedCount,
    Value<DateTime>? firstDefeatedAt,
    Value<DateTime>? lastDefeatedAt,
    Value<int>? rowid,
  }) {
    return BestiaryDiscoveriesCompanion(
      monsterId: monsterId ?? this.monsterId,
      defeatedCount: defeatedCount ?? this.defeatedCount,
      firstDefeatedAt: firstDefeatedAt ?? this.firstDefeatedAt,
      lastDefeatedAt: lastDefeatedAt ?? this.lastDefeatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (monsterId.present) {
      map['monster_id'] = Variable<String>(monsterId.value);
    }
    if (defeatedCount.present) {
      map['defeated_count'] = Variable<int>(defeatedCount.value);
    }
    if (firstDefeatedAt.present) {
      map['first_defeated_at'] = Variable<DateTime>(firstDefeatedAt.value);
    }
    if (lastDefeatedAt.present) {
      map['last_defeated_at'] = Variable<DateTime>(lastDefeatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BestiaryDiscoveriesCompanion(')
          ..write('monsterId: $monsterId, ')
          ..write('defeatedCount: $defeatedCount, ')
          ..write('firstDefeatedAt: $firstDefeatedAt, ')
          ..write('lastDefeatedAt: $lastDefeatedAt, ')
          ..write('rowid: $rowid')
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
  late final $DungeonInventoryTable dungeonInventory = $DungeonInventoryTable(
    this,
  );
  late final $DungeonProgressTable dungeonProgress = $DungeonProgressTable(
    this,
  );
  late final $GratitudeLogsTable gratitudeLogs = $GratitudeLogsTable(this);
  late final $BestiaryDiscoveriesTable bestiaryDiscoveries =
      $BestiaryDiscoveriesTable(this);
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
    dungeonInventory,
    dungeonProgress,
    gratitudeLogs,
    bestiaryDiscoveries,
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
      Value<String> armorTint,
      Value<bool> soundEnabled,
      Value<int> stepsToday,
      Value<int> lastEncounterStepMilestone,
      Value<DateTime?> lastFlashMissionAt,
      Value<int> expeditionKeys,
      Value<String?> lastDailyKeyDate,
      Value<String?> heroUid,
      Value<int> gratitudeSentCount,
      Value<int> lastGratitudeSentLevel,
      Value<int> gratitudeReceivedCount,
      Value<int> lastGratitudeReceivedLevel,
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
      Value<String> armorTint,
      Value<bool> soundEnabled,
      Value<int> stepsToday,
      Value<int> lastEncounterStepMilestone,
      Value<DateTime?> lastFlashMissionAt,
      Value<int> expeditionKeys,
      Value<String?> lastDailyKeyDate,
      Value<String?> heroUid,
      Value<int> gratitudeSentCount,
      Value<int> lastGratitudeSentLevel,
      Value<int> gratitudeReceivedCount,
      Value<int> lastGratitudeReceivedLevel,
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

  ColumnFilters<String> get armorTint => $composableBuilder(
    column: $table.armorTint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepsToday => $composableBuilder(
    column: $table.stepsToday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastEncounterStepMilestone => $composableBuilder(
    column: $table.lastEncounterStepMilestone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFlashMissionAt => $composableBuilder(
    column: $table.lastFlashMissionAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expeditionKeys => $composableBuilder(
    column: $table.expeditionKeys,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastDailyKeyDate => $composableBuilder(
    column: $table.lastDailyKeyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heroUid => $composableBuilder(
    column: $table.heroUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gratitudeSentCount => $composableBuilder(
    column: $table.gratitudeSentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastGratitudeSentLevel => $composableBuilder(
    column: $table.lastGratitudeSentLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gratitudeReceivedCount => $composableBuilder(
    column: $table.gratitudeReceivedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastGratitudeReceivedLevel => $composableBuilder(
    column: $table.lastGratitudeReceivedLevel,
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

  ColumnOrderings<String> get armorTint => $composableBuilder(
    column: $table.armorTint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepsToday => $composableBuilder(
    column: $table.stepsToday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastEncounterStepMilestone => $composableBuilder(
    column: $table.lastEncounterStepMilestone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFlashMissionAt => $composableBuilder(
    column: $table.lastFlashMissionAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expeditionKeys => $composableBuilder(
    column: $table.expeditionKeys,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastDailyKeyDate => $composableBuilder(
    column: $table.lastDailyKeyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heroUid => $composableBuilder(
    column: $table.heroUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gratitudeSentCount => $composableBuilder(
    column: $table.gratitudeSentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastGratitudeSentLevel => $composableBuilder(
    column: $table.lastGratitudeSentLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gratitudeReceivedCount => $composableBuilder(
    column: $table.gratitudeReceivedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastGratitudeReceivedLevel => $composableBuilder(
    column: $table.lastGratitudeReceivedLevel,
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

  GeneratedColumn<String> get armorTint =>
      $composableBuilder(column: $table.armorTint, builder: (column) => column);

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepsToday => $composableBuilder(
    column: $table.stepsToday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastEncounterStepMilestone => $composableBuilder(
    column: $table.lastEncounterStepMilestone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastFlashMissionAt => $composableBuilder(
    column: $table.lastFlashMissionAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expeditionKeys => $composableBuilder(
    column: $table.expeditionKeys,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastDailyKeyDate => $composableBuilder(
    column: $table.lastDailyKeyDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get heroUid =>
      $composableBuilder(column: $table.heroUid, builder: (column) => column);

  GeneratedColumn<int> get gratitudeSentCount => $composableBuilder(
    column: $table.gratitudeSentCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastGratitudeSentLevel => $composableBuilder(
    column: $table.lastGratitudeSentLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gratitudeReceivedCount => $composableBuilder(
    column: $table.gratitudeReceivedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastGratitudeReceivedLevel => $composableBuilder(
    column: $table.lastGratitudeReceivedLevel,
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
                Value<String> armorTint = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<int> stepsToday = const Value.absent(),
                Value<int> lastEncounterStepMilestone = const Value.absent(),
                Value<DateTime?> lastFlashMissionAt = const Value.absent(),
                Value<int> expeditionKeys = const Value.absent(),
                Value<String?> lastDailyKeyDate = const Value.absent(),
                Value<String?> heroUid = const Value.absent(),
                Value<int> gratitudeSentCount = const Value.absent(),
                Value<int> lastGratitudeSentLevel = const Value.absent(),
                Value<int> gratitudeReceivedCount = const Value.absent(),
                Value<int> lastGratitudeReceivedLevel = const Value.absent(),
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
                armorTint: armorTint,
                soundEnabled: soundEnabled,
                stepsToday: stepsToday,
                lastEncounterStepMilestone: lastEncounterStepMilestone,
                lastFlashMissionAt: lastFlashMissionAt,
                expeditionKeys: expeditionKeys,
                lastDailyKeyDate: lastDailyKeyDate,
                heroUid: heroUid,
                gratitudeSentCount: gratitudeSentCount,
                lastGratitudeSentLevel: lastGratitudeSentLevel,
                gratitudeReceivedCount: gratitudeReceivedCount,
                lastGratitudeReceivedLevel: lastGratitudeReceivedLevel,
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
                Value<String> armorTint = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<int> stepsToday = const Value.absent(),
                Value<int> lastEncounterStepMilestone = const Value.absent(),
                Value<DateTime?> lastFlashMissionAt = const Value.absent(),
                Value<int> expeditionKeys = const Value.absent(),
                Value<String?> lastDailyKeyDate = const Value.absent(),
                Value<String?> heroUid = const Value.absent(),
                Value<int> gratitudeSentCount = const Value.absent(),
                Value<int> lastGratitudeSentLevel = const Value.absent(),
                Value<int> gratitudeReceivedCount = const Value.absent(),
                Value<int> lastGratitudeReceivedLevel = const Value.absent(),
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
                armorTint: armorTint,
                soundEnabled: soundEnabled,
                stepsToday: stepsToday,
                lastEncounterStepMilestone: lastEncounterStepMilestone,
                lastFlashMissionAt: lastFlashMissionAt,
                expeditionKeys: expeditionKeys,
                lastDailyKeyDate: lastDailyKeyDate,
                heroUid: heroUid,
                gratitudeSentCount: gratitudeSentCount,
                lastGratitudeSentLevel: lastGratitudeSentLevel,
                gratitudeReceivedCount: gratitudeReceivedCount,
                lastGratitudeReceivedLevel: lastGratitudeReceivedLevel,
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
      Value<String> attributeKey,
      Value<bool> isCompleted,
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
      Value<String> attributeKey,
      Value<bool> isCompleted,
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

  ColumnFilters<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  ColumnOrderings<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  GeneratedColumn<String> get attributeKey => $composableBuilder(
    column: $table.attributeKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

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
                Value<String> attributeKey = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => CalendarEventsCompanion(
                id: id,
                googleEventId: googleEventId,
                title: title,
                startTime: startTime,
                endTime: endTime,
                isAllDay: isAllDay,
                location: location,
                attributeKey: attributeKey,
                isCompleted: isCompleted,
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
                Value<String> attributeKey = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => CalendarEventsCompanion.insert(
                id: id,
                googleEventId: googleEventId,
                title: title,
                startTime: startTime,
                endTime: endTime,
                isAllDay: isAllDay,
                location: location,
                attributeKey: attributeKey,
                isCompleted: isCompleted,
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
typedef $$DungeonInventoryTableCreateCompanionBuilder =
    DungeonInventoryCompanion Function({
      required String itemId,
      required String slot,
      Value<int> quantity,
      Value<bool> isEquipped,
      Value<DateTime> acquiredAt,
      Value<int> rowid,
    });
typedef $$DungeonInventoryTableUpdateCompanionBuilder =
    DungeonInventoryCompanion Function({
      Value<String> itemId,
      Value<String> slot,
      Value<int> quantity,
      Value<bool> isEquipped,
      Value<DateTime> acquiredAt,
      Value<int> rowid,
    });

class $$DungeonInventoryTableFilterComposer
    extends Composer<_$AppDatabase, $DungeonInventoryTable> {
  $$DungeonInventoryTableFilterComposer({
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

  ColumnFilters<String> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DungeonInventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $DungeonInventoryTable> {
  $$DungeonInventoryTableOrderingComposer({
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

  ColumnOrderings<String> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DungeonInventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $DungeonInventoryTable> {
  $$DungeonInventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );
}

class $$DungeonInventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DungeonInventoryTable,
          DungeonInventoryData,
          $$DungeonInventoryTableFilterComposer,
          $$DungeonInventoryTableOrderingComposer,
          $$DungeonInventoryTableAnnotationComposer,
          $$DungeonInventoryTableCreateCompanionBuilder,
          $$DungeonInventoryTableUpdateCompanionBuilder,
          (
            DungeonInventoryData,
            BaseReferences<
              _$AppDatabase,
              $DungeonInventoryTable,
              DungeonInventoryData
            >,
          ),
          DungeonInventoryData,
          PrefetchHooks Function()
        > {
  $$DungeonInventoryTableTableManager(
    _$AppDatabase db,
    $DungeonInventoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DungeonInventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DungeonInventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DungeonInventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemId = const Value.absent(),
                Value<String> slot = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DungeonInventoryCompanion(
                itemId: itemId,
                slot: slot,
                quantity: quantity,
                isEquipped: isEquipped,
                acquiredAt: acquiredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemId,
                required String slot,
                Value<int> quantity = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DungeonInventoryCompanion.insert(
                itemId: itemId,
                slot: slot,
                quantity: quantity,
                isEquipped: isEquipped,
                acquiredAt: acquiredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DungeonInventoryTable, DungeonInventoryData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $DungeonInventoryTable,
                    DungeonInventoryData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DungeonInventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DungeonInventoryTable,
      DungeonInventoryData,
      $$DungeonInventoryTableFilterComposer,
      $$DungeonInventoryTableOrderingComposer,
      $$DungeonInventoryTableAnnotationComposer,
      $$DungeonInventoryTableCreateCompanionBuilder,
      $$DungeonInventoryTableUpdateCompanionBuilder,
      (
        DungeonInventoryData,
        BaseReferences<
          _$AppDatabase,
          $DungeonInventoryTable,
          DungeonInventoryData
        >,
      ),
      DungeonInventoryData,
      PrefetchHooks Function()
    >;
typedef $$DungeonProgressTableCreateCompanionBuilder =
    DungeonProgressCompanion Function({
      required String biomeKey,
      Value<int> bestFloor,
      Value<int> clearsCount,
      Value<int?> lastSeed,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DungeonProgressTableUpdateCompanionBuilder =
    DungeonProgressCompanion Function({
      Value<String> biomeKey,
      Value<int> bestFloor,
      Value<int> clearsCount,
      Value<int?> lastSeed,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DungeonProgressTableFilterComposer
    extends Composer<_$AppDatabase, $DungeonProgressTable> {
  $$DungeonProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get biomeKey => $composableBuilder(
    column: $table.biomeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestFloor => $composableBuilder(
    column: $table.bestFloor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clearsCount => $composableBuilder(
    column: $table.clearsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeed => $composableBuilder(
    column: $table.lastSeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DungeonProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $DungeonProgressTable> {
  $$DungeonProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get biomeKey => $composableBuilder(
    column: $table.biomeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestFloor => $composableBuilder(
    column: $table.bestFloor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clearsCount => $composableBuilder(
    column: $table.clearsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeed => $composableBuilder(
    column: $table.lastSeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DungeonProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $DungeonProgressTable> {
  $$DungeonProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get biomeKey =>
      $composableBuilder(column: $table.biomeKey, builder: (column) => column);

  GeneratedColumn<int> get bestFloor =>
      $composableBuilder(column: $table.bestFloor, builder: (column) => column);

  GeneratedColumn<int> get clearsCount => $composableBuilder(
    column: $table.clearsCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSeed =>
      $composableBuilder(column: $table.lastSeed, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DungeonProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DungeonProgressTable,
          DungeonProgressData,
          $$DungeonProgressTableFilterComposer,
          $$DungeonProgressTableOrderingComposer,
          $$DungeonProgressTableAnnotationComposer,
          $$DungeonProgressTableCreateCompanionBuilder,
          $$DungeonProgressTableUpdateCompanionBuilder,
          (
            DungeonProgressData,
            BaseReferences<
              _$AppDatabase,
              $DungeonProgressTable,
              DungeonProgressData
            >,
          ),
          DungeonProgressData,
          PrefetchHooks Function()
        > {
  $$DungeonProgressTableTableManager(
    _$AppDatabase db,
    $DungeonProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DungeonProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DungeonProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DungeonProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> biomeKey = const Value.absent(),
                Value<int> bestFloor = const Value.absent(),
                Value<int> clearsCount = const Value.absent(),
                Value<int?> lastSeed = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DungeonProgressCompanion(
                biomeKey: biomeKey,
                bestFloor: bestFloor,
                clearsCount: clearsCount,
                lastSeed: lastSeed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String biomeKey,
                Value<int> bestFloor = const Value.absent(),
                Value<int> clearsCount = const Value.absent(),
                Value<int?> lastSeed = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DungeonProgressCompanion.insert(
                biomeKey: biomeKey,
                bestFloor: bestFloor,
                clearsCount: clearsCount,
                lastSeed: lastSeed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DungeonProgressTable, DungeonProgressData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $DungeonProgressTable,
                    DungeonProgressData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DungeonProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DungeonProgressTable,
      DungeonProgressData,
      $$DungeonProgressTableFilterComposer,
      $$DungeonProgressTableOrderingComposer,
      $$DungeonProgressTableAnnotationComposer,
      $$DungeonProgressTableCreateCompanionBuilder,
      $$DungeonProgressTableUpdateCompanionBuilder,
      (
        DungeonProgressData,
        BaseReferences<
          _$AppDatabase,
          $DungeonProgressTable,
          DungeonProgressData
        >,
      ),
      DungeonProgressData,
      PrefetchHooks Function()
    >;
typedef $$GratitudeLogsTableCreateCompanionBuilder =
    GratitudeLogsCompanion Function({
      required String tokenId,
      required String direction,
      required String peerName,
      Value<String> note,
      Value<int> xpAmount,
      Value<int> goldAmount,
      Value<String?> itemId,
      Value<String?> itemName,
      required String sealCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GratitudeLogsTableUpdateCompanionBuilder =
    GratitudeLogsCompanion Function({
      Value<String> tokenId,
      Value<String> direction,
      Value<String> peerName,
      Value<String> note,
      Value<int> xpAmount,
      Value<int> goldAmount,
      Value<String?> itemId,
      Value<String?> itemName,
      Value<String> sealCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$GratitudeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $GratitudeLogsTable> {
  $$GratitudeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tokenId => $composableBuilder(
    column: $table.tokenId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get peerName => $composableBuilder(
    column: $table.peerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAmount => $composableBuilder(
    column: $table.xpAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goldAmount => $composableBuilder(
    column: $table.goldAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sealCode => $composableBuilder(
    column: $table.sealCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GratitudeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $GratitudeLogsTable> {
  $$GratitudeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tokenId => $composableBuilder(
    column: $table.tokenId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get peerName => $composableBuilder(
    column: $table.peerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAmount => $composableBuilder(
    column: $table.xpAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goldAmount => $composableBuilder(
    column: $table.goldAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sealCode => $composableBuilder(
    column: $table.sealCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GratitudeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GratitudeLogsTable> {
  $$GratitudeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tokenId =>
      $composableBuilder(column: $table.tokenId, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get peerName =>
      $composableBuilder(column: $table.peerName, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get xpAmount =>
      $composableBuilder(column: $table.xpAmount, builder: (column) => column);

  GeneratedColumn<int> get goldAmount => $composableBuilder(
    column: $table.goldAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<String> get sealCode =>
      $composableBuilder(column: $table.sealCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GratitudeLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GratitudeLogsTable,
          GratitudeLog,
          $$GratitudeLogsTableFilterComposer,
          $$GratitudeLogsTableOrderingComposer,
          $$GratitudeLogsTableAnnotationComposer,
          $$GratitudeLogsTableCreateCompanionBuilder,
          $$GratitudeLogsTableUpdateCompanionBuilder,
          (
            GratitudeLog,
            BaseReferences<_$AppDatabase, $GratitudeLogsTable, GratitudeLog>,
          ),
          GratitudeLog,
          PrefetchHooks Function()
        > {
  $$GratitudeLogsTableTableManager(_$AppDatabase db, $GratitudeLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GratitudeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GratitudeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GratitudeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tokenId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> peerName = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> xpAmount = const Value.absent(),
                Value<int> goldAmount = const Value.absent(),
                Value<String?> itemId = const Value.absent(),
                Value<String?> itemName = const Value.absent(),
                Value<String> sealCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GratitudeLogsCompanion(
                tokenId: tokenId,
                direction: direction,
                peerName: peerName,
                note: note,
                xpAmount: xpAmount,
                goldAmount: goldAmount,
                itemId: itemId,
                itemName: itemName,
                sealCode: sealCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tokenId,
                required String direction,
                required String peerName,
                Value<String> note = const Value.absent(),
                Value<int> xpAmount = const Value.absent(),
                Value<int> goldAmount = const Value.absent(),
                Value<String?> itemId = const Value.absent(),
                Value<String?> itemName = const Value.absent(),
                required String sealCode,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GratitudeLogsCompanion.insert(
                tokenId: tokenId,
                direction: direction,
                peerName: peerName,
                note: note,
                xpAmount: xpAmount,
                goldAmount: goldAmount,
                itemId: itemId,
                itemName: itemName,
                sealCode: sealCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GratitudeLogsTable, GratitudeLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GratitudeLogsTable,
                    GratitudeLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GratitudeLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GratitudeLogsTable,
      GratitudeLog,
      $$GratitudeLogsTableFilterComposer,
      $$GratitudeLogsTableOrderingComposer,
      $$GratitudeLogsTableAnnotationComposer,
      $$GratitudeLogsTableCreateCompanionBuilder,
      $$GratitudeLogsTableUpdateCompanionBuilder,
      (
        GratitudeLog,
        BaseReferences<_$AppDatabase, $GratitudeLogsTable, GratitudeLog>,
      ),
      GratitudeLog,
      PrefetchHooks Function()
    >;
typedef $$BestiaryDiscoveriesTableCreateCompanionBuilder =
    BestiaryDiscoveriesCompanion Function({
      required String monsterId,
      Value<int> defeatedCount,
      Value<DateTime> firstDefeatedAt,
      Value<DateTime> lastDefeatedAt,
      Value<int> rowid,
    });
typedef $$BestiaryDiscoveriesTableUpdateCompanionBuilder =
    BestiaryDiscoveriesCompanion Function({
      Value<String> monsterId,
      Value<int> defeatedCount,
      Value<DateTime> firstDefeatedAt,
      Value<DateTime> lastDefeatedAt,
      Value<int> rowid,
    });

class $$BestiaryDiscoveriesTableFilterComposer
    extends Composer<_$AppDatabase, $BestiaryDiscoveriesTable> {
  $$BestiaryDiscoveriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monsterId => $composableBuilder(
    column: $table.monsterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defeatedCount => $composableBuilder(
    column: $table.defeatedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstDefeatedAt => $composableBuilder(
    column: $table.firstDefeatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastDefeatedAt => $composableBuilder(
    column: $table.lastDefeatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BestiaryDiscoveriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BestiaryDiscoveriesTable> {
  $$BestiaryDiscoveriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monsterId => $composableBuilder(
    column: $table.monsterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defeatedCount => $composableBuilder(
    column: $table.defeatedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstDefeatedAt => $composableBuilder(
    column: $table.firstDefeatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastDefeatedAt => $composableBuilder(
    column: $table.lastDefeatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BestiaryDiscoveriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BestiaryDiscoveriesTable> {
  $$BestiaryDiscoveriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monsterId =>
      $composableBuilder(column: $table.monsterId, builder: (column) => column);

  GeneratedColumn<int> get defeatedCount => $composableBuilder(
    column: $table.defeatedCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstDefeatedAt => $composableBuilder(
    column: $table.firstDefeatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastDefeatedAt => $composableBuilder(
    column: $table.lastDefeatedAt,
    builder: (column) => column,
  );
}

class $$BestiaryDiscoveriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BestiaryDiscoveriesTable,
          BestiaryDiscovery,
          $$BestiaryDiscoveriesTableFilterComposer,
          $$BestiaryDiscoveriesTableOrderingComposer,
          $$BestiaryDiscoveriesTableAnnotationComposer,
          $$BestiaryDiscoveriesTableCreateCompanionBuilder,
          $$BestiaryDiscoveriesTableUpdateCompanionBuilder,
          (
            BestiaryDiscovery,
            BaseReferences<
              _$AppDatabase,
              $BestiaryDiscoveriesTable,
              BestiaryDiscovery
            >,
          ),
          BestiaryDiscovery,
          PrefetchHooks Function()
        > {
  $$BestiaryDiscoveriesTableTableManager(
    _$AppDatabase db,
    $BestiaryDiscoveriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BestiaryDiscoveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BestiaryDiscoveriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BestiaryDiscoveriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> monsterId = const Value.absent(),
                Value<int> defeatedCount = const Value.absent(),
                Value<DateTime> firstDefeatedAt = const Value.absent(),
                Value<DateTime> lastDefeatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BestiaryDiscoveriesCompanion(
                monsterId: monsterId,
                defeatedCount: defeatedCount,
                firstDefeatedAt: firstDefeatedAt,
                lastDefeatedAt: lastDefeatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String monsterId,
                Value<int> defeatedCount = const Value.absent(),
                Value<DateTime> firstDefeatedAt = const Value.absent(),
                Value<DateTime> lastDefeatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BestiaryDiscoveriesCompanion.insert(
                monsterId: monsterId,
                defeatedCount: defeatedCount,
                firstDefeatedAt: firstDefeatedAt,
                lastDefeatedAt: lastDefeatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BestiaryDiscoveriesTable, BestiaryDiscovery>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $BestiaryDiscoveriesTable,
                    BestiaryDiscovery
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BestiaryDiscoveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BestiaryDiscoveriesTable,
      BestiaryDiscovery,
      $$BestiaryDiscoveriesTableFilterComposer,
      $$BestiaryDiscoveriesTableOrderingComposer,
      $$BestiaryDiscoveriesTableAnnotationComposer,
      $$BestiaryDiscoveriesTableCreateCompanionBuilder,
      $$BestiaryDiscoveriesTableUpdateCompanionBuilder,
      (
        BestiaryDiscovery,
        BaseReferences<
          _$AppDatabase,
          $BestiaryDiscoveriesTable,
          BestiaryDiscovery
        >,
      ),
      BestiaryDiscovery,
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
  $$DungeonInventoryTableTableManager get dungeonInventory =>
      $$DungeonInventoryTableTableManager(_db, _db.dungeonInventory);
  $$DungeonProgressTableTableManager get dungeonProgress =>
      $$DungeonProgressTableTableManager(_db, _db.dungeonProgress);
  $$GratitudeLogsTableTableManager get gratitudeLogs =>
      $$GratitudeLogsTableTableManager(_db, _db.gratitudeLogs);
  $$BestiaryDiscoveriesTableTableManager get bestiaryDiscoveries =>
      $$BestiaryDiscoveriesTableTableManager(_db, _db.bestiaryDiscoveries);
}
