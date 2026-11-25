import 'package:drift/drift.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/social/gratitude_seal.dart';
import '../database/app_database.dart';

class HeroRepository {
  HeroRepository(this._db, [RewardEngine? rewardEngine])
      : _rewardEngine = rewardEngine ?? RewardEngine();

  final AppDatabase _db;
  final RewardEngine _rewardEngine;

  /// Observa o perfil do herói (null se ainda não criou personagem).
  Stream<HeroProfile?> watchHero() {
    return (_db.select(_db.heroProfiles)..limit(1)).watchSingleOrNull();
  }

  /// Lê o perfil do herói uma única vez.
  Future<HeroProfile?> getHero() {
    return (_db.select(_db.heroProfiles)..limit(1)).getSingleOrNull();
  }

  /// Observa todos os 5 atributos ordenados na ordem oficial do LifeOS.
  Stream<List<AttributeStat>> watchAttributes() {
    return _db.select(_db.attributeStats).watch().map((rows) {
      final order = RpgAttribute.values.map((a) => a.key).toList();
      final sorted = [...rows];
      sorted.sort(
        (a, b) =>
            order.indexOf(a.attributeKey).compareTo(order.indexOf(b.attributeKey)),
      );
      return sorted;
    });
  }

  Future<Map<RpgAttribute, int>> getAttributeLevelsMap() async {
    final rows = await _db.select(_db.attributeStats).get();
    return {
      for (final row in rows) RpgAttribute.fromKey(row.attributeKey): row.level,
    };
  }

  /// Observa baús fechados aguardando abertura.
  Stream<List<MysteryChest>> watchUnopenedChests() {
    return (_db.select(_db.mysteryChests)
          ..where((t) => t.isOpened.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Verifica se o Modo Energia está ativo hoje.
  static bool isEnergyModeActive(HeroProfile hero, [DateTime? now]) {
    final until = hero.energyModeActiveUntil;
    if (until == null) return false;
    return (now ?? DateTime.now()).isBefore(until);
  }

  /// Quantos dias faltam para poder ativar o Modo Energia novamente (0 = disponível).
  static int energyModeCooldownDays(HeroProfile hero, [DateTime? now]) {
    final last = hero.lastEnergyModeAt;
    if (last == null) return 0;
    final current = now ?? DateTime.now();
    final nextAvailable = last.add(const Duration(days: 7));
    if (!current.isBefore(nextAvailable)) return 0;
    final diffHours = nextAvailable.difference(current).inHours;
    return (diffHours / 24).ceil().clamp(1, 7);
  }

  /// Cooldown da Missão Relâmpago (1 hora após ativada).
  static const Duration flashMissionCooldown = Duration(hours: 1);

  /// Tempo restante de recarga da Missão Relâmpago (Duration.zero se disponível).
  static Duration flashMissionRemaining(HeroProfile hero, [DateTime? now]) {
    final last = hero.lastFlashMissionAt;
    if (last == null) return Duration.zero;
    final nextReady = last.add(flashMissionCooldown);
    final current = now ?? DateTime.now();
    if (!current.isBefore(nextReady)) return Duration.zero;
    return nextReady.difference(current);
  }

  /// Progresso de recarga do botão da Missão Relâmpago (0.0 a 1.0).
  static double flashMissionChargeProgress(HeroProfile hero, [DateTime? now]) {
    final remaining = flashMissionRemaining(hero, now);
    if (remaining <= Duration.zero) return 1.0;
    final elapsed =
        flashMissionCooldown.inSeconds - remaining.inSeconds;
    return (elapsed / flashMissionCooldown.inSeconds).clamp(0.0, 1.0);
  }

  /// Registra o horário de ativação da Missão Relâmpago (inicia cooldown de 1h).
  Future<void> recordFlashMissionStart() async {
    final hero = await getHero();
    if (hero == null) return;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(HeroProfilesCompanion(lastFlashMissionAt: Value(DateTime.now())));
  }

  /// Ativa o Modo Energia / Dia Sem Culpa (limite: 1x a cada 7 dias).
  Future<bool> activateEnergyMode() async {
    final hero = await getHero();
    if (hero == null) return false;
    final now = DateTime.now();
    if (energyModeCooldownDays(hero, now) > 0) return false;

    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(
      HeroProfilesCompanion(
        lastEnergyModeAt: Value(now),
        energyModeActiveUntil: Value(endOfDay),
      ),
    );
    return true;
  }

  /// Cria o personagem inicial e inicializa os 5 atributos em transação local.
  Future<void> createHero({
    required String name,
    required HeroClass heroClass,
    ArmorTint armorTint = ArmorTint.original,
  }) async {
    await _db.transaction(() async {
      await _db.delete(_db.heroProfiles).go();
      await _db.delete(_db.attributeStats).go();

      await _db.into(_db.heroProfiles).insert(
            HeroProfilesCompanion.insert(
              name: name.trim(),
              heroClass: heroClass.key,
              level: const Value(1),
              currentXp: const Value(0),
              gold: const Value(50),
              armorTint: Value(armorTint.key),
              heroUid: Value(GratitudeSealCodec.generateUid()),
            ),
          );

      for (final attr in RpgAttribute.values) {
        final starterXp = attr == heroClass.primaryAttribute ? 15 : 0;
        await _db.into(_db.attributeStats).insert(
              AttributeStatsCompanion.insert(
                attributeKey: attr.key,
                level: const Value(1),
                currentXp: Value(starterXp),
              ),
            );
      }
    });
  }

  /// Atualiza a tintura da armadura/manto do herói.
  Future<void> updateArmorTint(ArmorTint tint) async {
    final hero = await getHero();
    if (hero == null) return;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(HeroProfilesCompanion(armorTint: Value(tint.key)));
  }

  /// Liga ou desliga o som do aplicativo.
  Future<void> setSoundEnabled(bool enabled) async {
    final hero = await getHero();
    if (hero == null) return;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(HeroProfilesCompanion(soundEnabled: Value(enabled)));
  }

  /// Atualiza a contagem de passos de hoje e o marco de encontros.
  Future<void> updateSteps({
    required int stepsToday,
    int? lastMilestone,
  }) async {
    final hero = await getHero();
    if (hero == null) return;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(
      HeroProfilesCompanion(
        stepsToday: Value(stepsToday),
        lastEncounterStepMilestone:
            lastMilestone != null ? Value(lastMilestone) : const Value.absent(),
      ),
    );
  }

  /// Apaga o personagem atual para iniciar um Novo Herói do zero.
  Future<void> resetHero() async {
    await _db.transaction(() async {
      await _db.delete(_db.heroProfiles).go();
      await _db.delete(_db.attributeStats).go();
      await _db.delete(_db.ownedItems).go();
      await _db.delete(_db.mysteryChests).go();
      await _db.delete(_db.dungeonInventory).go();
      await _db.delete(_db.dungeonProgress).go();
      await _db.delete(_db.gratitudeLogs).go();
    });
  }

  static const int maxExpeditionKeys = 10;

  static String _todayDateKey([DateTime? now]) {
    final d = now ?? DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  /// Concede 1 Chave de Expedição gratuita por dia (até o limite máximo de 10).
  Future<bool> claimDailyExpeditionKeyIfNeeded() async {
    final hero = await getHero();
    if (hero == null) return false;
    final today = _todayDateKey();
    if (hero.lastDailyKeyDate == today) return false;

    final nextKeys = (hero.expeditionKeys + 1).clamp(0, maxExpeditionKeys);
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(
      HeroProfilesCompanion(
        expeditionKeys: Value(nextKeys),
        lastDailyKeyDate: Value(today),
      ),
    );
    return true;
  }

  /// Concede +1 Chave de Expedição ao concluir tarefas, compromissos ou sidequests na vida real.
  Future<void> awardExpeditionKey({int amount = 1}) async {
    final hero = await getHero();
    if (hero == null) return;
    final nextKeys = (hero.expeditionKeys + amount).clamp(0, maxExpeditionKeys);
    if (nextKeys == hero.expeditionKeys) return;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(HeroProfilesCompanion(expeditionKeys: Value(nextKeys)));
  }

  /// Consome 1 Chave de Expedição para entrar em uma masmorra.
  Future<bool> spendExpeditionKey() async {
    final hero = await getHero();
    if (hero == null || hero.expeditionKeys <= 0) return false;
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(
      HeroProfilesCompanion(expeditionKeys: Value(hero.expeditionKeys - 1)),
    );
    return true;
  }

  /// Concede XP Geral, XP no Atributo específico (opcional) e Ouro, calculando Level Ups.
  Future<({bool heroLeveledUp, bool attributeLeveledUp})> awardProgress({
    RpgAttribute? attribute,
    required int xpGained,
    required int goldGained,
    ChestRarity? droppedChest,
    String chestSource = 'Recompensa',
    bool? setBardInspiration,
  }) async {
    var heroLeveledUp = false;
    var attributeLeveledUp = false;

    await _db.transaction(() async {
      final hero = await getHero();
      if (hero == null) return;

      var newHeroLevel = hero.level;
      var newHeroXp = hero.currentXp + xpGained;
      var newGold = hero.gold + goldGained;

      while (newHeroXp >= RpgProgression.xpForNextHeroLevel(newHeroLevel)) {
        newHeroXp -= RpgProgression.xpForNextHeroLevel(newHeroLevel);
        newHeroLevel += 1;
        newGold += RpgProgression.levelUpGoldBonus;
        heroLeveledUp = true;

        // A cada 5 níveis do personagem, concede 1 Baú Raro/Épico!
        if (newHeroLevel % 5 == 0) {
          final milestoneRarity =
              newHeroLevel % 10 == 0 ? ChestRarity.epic : ChestRarity.rare;
          await _db.into(_db.mysteryChests).insert(
                MysteryChestsCompanion.insert(
                  rarity: milestoneRarity.key,
                  source: 'Nível $newHeroLevel alcançado!',
                ),
              );
        }
      }

      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(
        HeroProfilesCompanion(
          level: Value(newHeroLevel),
          currentXp: Value(newHeroXp),
          gold: Value(newGold),
          bardInspirationActive: setBardInspiration != null
              ? Value(setBardInspiration)
              : const Value.absent(),
        ),
      );

      if (attribute != null) {
        final attrStat = await (_db.select(_db.attributeStats)
              ..where((t) => t.attributeKey.equals(attribute.key)))
            .getSingleOrNull();

        if (attrStat != null) {
          var newAttrLevel = attrStat.level;
          var newAttrXp = attrStat.currentXp + xpGained;

          while (newAttrXp >=
              RpgProgression.xpForNextAttributeLevel(newAttrLevel)) {
            newAttrXp -= RpgProgression.xpForNextAttributeLevel(newAttrLevel);
            newAttrLevel += 1;
            attributeLeveledUp = true;
          }

          await (_db.update(_db.attributeStats)
                ..where((t) => t.attributeKey.equals(attribute.key)))
              .write(
            AttributeStatsCompanion(
              level: Value(newAttrLevel),
              currentXp: Value(newAttrXp),
            ),
          );
        }
      }

      if (droppedChest != null) {
        await _db.into(_db.mysteryChests).insert(
              MysteryChestsCompanion.insert(
                rarity: droppedChest.key,
                source: chestSource,
              ),
            );
      }
    });

    return (
      heroLeveledUp: heroLeveledUp,
      attributeLeveledUp: attributeLeveledUp,
    );
  }

  /// Abre um Baú Misterioso e concede Ouro + XP Geral ao herói.
  Future<({ChestRarity rarity, int gold, int xp, bool heroLeveledUp})?>
      openChest(int chestId) async {
    final chest = await (_db.select(_db.mysteryChests)
          ..where((t) => t.id.equals(chestId)))
        .getSingleOrNull();
    if (chest == null || chest.isOpened) return null;

    final rarity = ChestRarity.fromKey(chest.rarity);
    final loot = _rewardEngine.rollChestLoot(rarity);

    final progress = await awardProgress(
      xpGained: loot.xp,
      goldGained: loot.gold,
    );

    await (_db.update(_db.mysteryChests)..where((t) => t.id.equals(chestId)))
        .write(
      MysteryChestsCompanion(
        isOpened: const Value(true),
        rewardSummary: Value('+${loot.gold} Ouro e +${loot.xp} XP'),
      ),
    );

    return (
      rarity: rarity,
      gold: loot.gold,
      xp: loot.xp,
      heroLeveledUp: progress.heroLeveledUp,
    );
  }
}
