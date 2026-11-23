import 'dart:math';

import 'package:drift/drift.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/rpg/shop_catalog.dart';
import '../database/app_database.dart';
import 'hero_repository.dart';

class ShopRepository {
  ShopRepository(this._db, this._heroRepository);

  final AppDatabase _db;
  final HeroRepository _heroRepository;

  Stream<List<OwnedItem>> watchOwnedItems() {
    return _db.select(_db.ownedItems).watch();
  }

  Future<Set<String>> getOwnedFurnitureIds() async {
    final rows = await (_db.select(_db.ownedItems)
          ..where((t) => t.category.equals(ShopCategory.furniture.key)))
        .get();
    return rows.map((r) => r.itemId).toSet();
  }

  static bool isFocusPotionActive(HeroProfile hero, [DateTime? now]) {
    final until = hero.focusPotionUntil;
    if (until == null) return false;
    return (now ?? DateTime.now()).isBefore(until);
  }

  /// Compra um item permanente (Móvel/Equipamento/Pet) ou consumível (Poção/Baú).
  Future<({bool ok, String message})> purchaseItem(ShopItem item) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) return (ok: false, message: 'Herói não encontrado.');

    if (hero.level < item.minHeroLevel) {
      return (
        ok: false,
        message: 'Requer Nível ${item.minHeroLevel} do Herói.',
      );
    }

    final heroClass = HeroClass.fromKey(hero.heroClass);
    final attrLevels = await _heroRepository.getAttributeLevelsMap();
    final carLevel = attrLevels[RpgAttribute.charisma] ?? 1;
    final finalPrice = ShopCatalog.discountedPrice(
      basePrice: item.price,
      heroClass: heroClass,
      charismaLevel: carLevel,
    );

    if (hero.gold < finalPrice) {
      return (
        ok: false,
        message: 'Ouro insuficiente (precisa de $finalPrice Ouro).',
      );
    }

    // Se for permanente, evita compra duplicada
    if (item.category != ShopCategory.consumable) {
      final existing = await (_db.select(_db.ownedItems)
            ..where((t) => t.itemId.equals(item.id)))
          .getSingleOrNull();
      if (existing != null) {
        return (ok: false, message: 'Você já possui este item!');
      }
    }

    await _db.transaction(() async {
      // Debita Ouro
      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(HeroProfilesCompanion(gold: Value(hero.gold - finalPrice)));

      if (item.category == ShopCategory.furniture) {
        await _db.into(_db.ownedItems).insert(
              OwnedItemsCompanion.insert(
                itemId: item.id,
                category: ShopCategory.furniture.key,
                isEquipped: const Value(true),
              ),
            );
      } else if (item.category == ShopCategory.equipment) {
        // Desequipa outro item do mesmo slot antes de equipar o novo
        if (item.slot != null) {
          final owned = await (_db.select(_db.ownedItems)
                ..where((t) => t.category.equals(ShopCategory.equipment.key)))
              .get();
          for (final row in owned) {
            final meta = ShopCatalog.byId(row.itemId);
            if (meta?.slot == item.slot && row.isEquipped) {
              await (_db.update(_db.ownedItems)
                    ..where((t) => t.itemId.equals(row.itemId)))
                  .write(const OwnedItemsCompanion(isEquipped: Value(false)));
            }
          }
        }
        await _db.into(_db.ownedItems).insert(
              OwnedItemsCompanion.insert(
                itemId: item.id,
                category: ShopCategory.equipment.key,
                isEquipped: const Value(true),
              ),
            );
      } else if (item.id == 'cons_focus_potion') {
        final now = DateTime.now();
        final base = (hero.focusPotionUntil != null &&
                hero.focusPotionUntil!.isAfter(now))
            ? hero.focusPotionUntil!
            : now;
        await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
            .write(
          HeroProfilesCompanion(
            focusPotionUntil: Value(base.add(const Duration(hours: 1))),
          ),
        );
      } else if (item.id == 'cons_mystery_chest') {
        final roll = Random().nextDouble();
        final rarity = roll >= 0.88
            ? ChestRarity.epic
            : (roll >= 0.50 ? ChestRarity.rare : ChestRarity.common);
        await _db.into(_db.mysteryChests).insert(
              MysteryChestsCompanion.insert(
                rarity: rarity.key,
                source: 'Comprado na Loja',
              ),
            );
      }
    });

    final msg = switch (item.id) {
      'cons_focus_potion' => 'Poção de Foco ativa! +25% XP por 1 hora.',
      'cons_mystery_chest' => 'Baú Misterioso adicionado na aba Herói!',
      _ => '${item.name} adquirido por $finalPrice Ouro!',
    };
    return (ok: true, message: msg);
  }

  /// Compra e aplica o Pergaminho de Reclasse (troca a classe sem perder progresso).
  Future<({bool ok, String message})> purchaseReclass(
    HeroClass newClass,
  ) async {
    final scroll = ShopCatalog.byId('cons_reclass_scroll')!;
    final hero = await _heroRepository.getHero();
    if (hero == null) return (ok: false, message: 'Herói não encontrado.');
    if (hero.heroClass == newClass.key) {
      return (ok: false, message: 'Você já pertence à classe ${newClass.name}.');
    }

    final heroClass = HeroClass.fromKey(hero.heroClass);
    final attrLevels = await _heroRepository.getAttributeLevelsMap();
    final carLevel = attrLevels[RpgAttribute.charisma] ?? 1;
    final finalPrice = ShopCatalog.discountedPrice(
      basePrice: scroll.price,
      heroClass: heroClass,
      charismaLevel: carLevel,
    );

    if (hero.gold < finalPrice) {
      return (
        ok: false,
        message: 'Ouro insuficiente (precisa de $finalPrice Ouro).',
      );
    }

    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(
      HeroProfilesCompanion(
        gold: Value(hero.gold - finalPrice),
        heroClass: Value(newClass.key),
      ),
    );
    return (
      ok: true,
      message: 'Agora você é ${newClass.name} (${newClass.title})!',
    );
  }

  /// Alterna equipar/desequipar de um equipamento ou pet já possuído.
  Future<void> toggleEquip(ShopItem item) async {
    final current = await (_db.select(_db.ownedItems)
          ..where((t) => t.itemId.equals(item.id)))
        .getSingleOrNull();
    if (current == null) return;

    final nextState = !current.isEquipped;
    await _db.transaction(() async {
      if (nextState && item.slot != null) {
        final owned = await (_db.select(_db.ownedItems)
              ..where((t) => t.category.equals(ShopCategory.equipment.key)))
            .get();
        for (final row in owned) {
          final meta = ShopCatalog.byId(row.itemId);
          if (meta?.slot == item.slot && row.isEquipped) {
            await (_db.update(_db.ownedItems)
                  ..where((t) => t.itemId.equals(row.itemId)))
                .write(const OwnedItemsCompanion(isEquipped: Value(false)));
          }
        }
      }
      await (_db.update(_db.ownedItems)..where((t) => t.itemId.equals(item.id)))
          .write(OwnedItemsCompanion(isEquipped: Value(nextState)));
    });
  }
}

