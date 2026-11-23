import 'package:drift/drift.dart';

import '../../core/rpg/rpg_models.dart';
import '../database/app_database.dart';

class HeroRepository {
  HeroRepository(this._db);

  final AppDatabase _db;

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

  /// Cria o personagem inicial e inicializa os 5 atributos em transação local.
  Future<void> createHero({
    required String name,
    required HeroClass heroClass,
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
            ),
          );

      for (final attr in RpgAttribute.values) {
        // Pequena afinidade inicial (+15 XP) no atributo paralelo da classe escolhida.
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

  /// Concede XP Geral, XP no Atributo específico e Ouro, calculando Level Ups.
  Future<({bool heroLeveledUp, bool attributeLeveledUp})> awardProgress({
    required RpgAttribute attribute,
    required int xpGained,
    required int goldGained,
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
      }

      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(
        HeroProfilesCompanion(
          level: Value(newHeroLevel),
          currentXp: Value(newHeroXp),
          gold: Value(newGold),
        ),
      );

      final attrStat = await (_db.select(_db.attributeStats)
            ..where((t) => t.attributeKey.equals(attribute.key)))
          .getSingleOrNull();

      if (attrStat != null) {
        var newAttrLevel = attrStat.level;
        var newAttrXp = attrStat.currentXp + xpGained;

        while (
            newAttrXp >= RpgProgression.xpForNextAttributeLevel(newAttrLevel)) {
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
    });

    return (
      heroLeveledUp: heroLeveledUp,
      attributeLeveledUp: attributeLeveledUp,
    );
  }
}

