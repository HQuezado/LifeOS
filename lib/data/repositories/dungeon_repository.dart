import 'package:drift/drift.dart';

import '../../core/dungeon/dungeon_models.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/rpg/shop_catalog.dart';
import '../database/app_database.dart';
import 'hero_repository.dart';

/// Gerencia o Inventário da Masmorra (equipamentos + consumíveis), o Mercado do Ferreiro
/// e o progresso/recorde de andares em cada bioma (100% local SQLite).
class DungeonRepository {
  DungeonRepository(this._db, this._heroRepository);

  final AppDatabase _db;
  final HeroRepository _heroRepository;

  Stream<List<DungeonInventoryData>> watchInventory() {
    return (_db.select(_db.dungeonInventory)
          ..orderBy([
            (t) => OrderingTerm.desc(t.isEquipped),
            (t) => OrderingTerm.asc(t.slot),
            (t) => OrderingTerm.desc(t.acquiredAt),
          ]))
        .watch();
  }

  Future<List<DungeonInventoryData>> getInventory() {
    return _db.select(_db.dungeonInventory).get();
  }

  Stream<List<DungeonProgressData>> watchProgress() {
    return _db.select(_db.dungeonProgress).watch();
  }

  /// Garante que o herói comece com um kit básico de expedição caso o inventário esteja vazio.
  Future<void> ensureStarterGear(HeroClass heroClass) async {
    final existing = await getInventory();
    if (existing.isNotEmpty) return;

    final starterWeapon = (heroClass == HeroClass.mage || heroClass == HeroClass.alchemist)
        ? 'wpn_wood_staff'
        : (heroClass == HeroClass.rogue ? 'wpn_bone_dagger' : 'wpn_wood_club');

    await _db.transaction(() async {
      await _db.into(_db.dungeonInventory).insert(
            DungeonInventoryCompanion.insert(
              itemId: starterWeapon,
              slot: DungeonItemSlot.weapon.key,
              quantity: const Value(1),
              isEquipped: const Value(true),
            ),
          );
      await _db.into(_db.dungeonInventory).insert(
            DungeonInventoryCompanion.insert(
              itemId: 'arm_leather_jerkin',
              slot: DungeonItemSlot.armor.key,
              quantity: const Value(1),
              isEquipped: const Value(true),
            ),
          );
      await _db.into(_db.dungeonInventory).insert(
            DungeonInventoryCompanion.insert(
              itemId: 'cons_hp_small',
              slot: DungeonItemSlot.consumable.key,
              quantity: const Value(3),
              isEquipped: const Value(false),
            ),
          );
      await _db.into(_db.dungeonInventory).insert(
            DungeonInventoryCompanion.insert(
              itemId: 'cons_mana_small',
              slot: DungeonItemSlot.consumable.key,
              quantity: const Value(2),
              isEquipped: const Value(false),
            ),
          );
    });
  }

  /// Adiciona um item (loot de baú/boss ou compra) ao inventário.
  Future<void> addItem(DungeonItem item, {int quantity = 1}) async {
    await _db.transaction(() async {
      final existing = await (_db.select(_db.dungeonInventory)
            ..where((t) => t.itemId.equals(item.id)))
          .getSingleOrNull();

      if (existing != null) {
        await (_db.update(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(item.id)))
            .write(
          DungeonInventoryCompanion(
            quantity: Value(existing.quantity + quantity),
          ),
        );
      } else {
        await _db.into(_db.dungeonInventory).insert(
              DungeonInventoryCompanion.insert(
                itemId: item.id,
                slot: item.slot.key,
                quantity: Value(quantity),
                isEquipped: const Value(false),
              ),
            );
      }
    });
  }

  /// Equipa um equipamento em seu slot (desequipando automaticamente o anterior do mesmo slot).
  Future<void> equipItem(String itemId, DungeonItemSlot slot) async {
    if (slot == DungeonItemSlot.consumable) return;
    await _db.transaction(() async {
      await (_db.update(_db.dungeonInventory)
            ..where((t) => t.slot.equals(slot.key)))
          .write(const DungeonInventoryCompanion(isEquipped: Value(false)));

      await (_db.update(_db.dungeonInventory)
            ..where((t) => t.itemId.equals(itemId)))
          .write(const DungeonInventoryCompanion(isEquipped: Value(true)));
    });
  }

  /// Desequipa um equipamento específico.
  Future<void> unequipItem(String itemId) async {
    await (_db.update(_db.dungeonInventory)
          ..where((t) => t.itemId.equals(itemId)))
        .write(const DungeonInventoryCompanion(isEquipped: Value(false)));
  }

  /// Consome 1 unidade de um consumível no inventário.
  Future<bool> consumeItem(String itemId) async {
    return _db.transaction(() async {
      final existing = await (_db.select(_db.dungeonInventory)
            ..where((t) => t.itemId.equals(itemId)))
          .getSingleOrNull();
      if (existing == null || existing.quantity <= 0) return false;

      if (existing.quantity <= 1) {
        await (_db.delete(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(itemId)))
            .go();
      } else {
        await (_db.update(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(itemId)))
            .write(DungeonInventoryCompanion(quantity: Value(existing.quantity - 1)));
      }
      return true;
    });
  }

  /// Compra um equipamento ou consumível na Forja usando o ouro do herói (com desconto de Bardo/CAR).
  Future<({bool ok, String message})> buyItem(DungeonItem item) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) return (ok: false, message: 'Herói não encontrado.');

    final attrLevels = await _heroRepository.getAttributeLevelsMap();
    final heroClass = HeroClass.fromKey(hero.heroClass);
    final finalPrice = ShopCatalog.discountedPrice(
      basePrice: item.price,
      heroClass: heroClass,
      charismaLevel: attrLevels[RpgAttribute.charisma] ?? 1,
    );

    if (hero.gold < finalPrice) {
      return (
        ok: false,
        message: 'Ouro insuficiente (precisa de $finalPrice moedas).',
      );
    }

    await _db.transaction(() async {
      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(HeroProfilesCompanion(gold: Value(hero.gold - finalPrice)));

      final existing = await (_db.select(_db.dungeonInventory)
            ..where((t) => t.itemId.equals(item.id)))
          .getSingleOrNull();

      if (existing != null) {
        await (_db.update(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(item.id)))
            .write(
          DungeonInventoryCompanion(quantity: Value(existing.quantity + 1)),
        );
      } else {
        await _db.into(_db.dungeonInventory).insert(
              DungeonInventoryCompanion.insert(
                itemId: item.id,
                slot: item.slot.key,
                quantity: const Value(1),
                isEquipped: const Value(false),
              ),
            );
      }
    });

    return (ok: true, message: '${item.name} adicionado à mochila!');
  }

  /// Vende 1 unidade de um item por 50% do preço.
  Future<({bool ok, String message, int goldEarned})> sellItem(
    DungeonItem item,
  ) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) {
      return (ok: false, message: 'Herói não encontrado.', goldEarned: 0);
    }

    final existing = await (_db.select(_db.dungeonInventory)
          ..where((t) => t.itemId.equals(item.id)))
        .getSingleOrNull();
    if (existing == null || existing.quantity <= 0) {
      return (ok: false, message: 'Item não encontrado.', goldEarned: 0);
    }

    if (existing.isEquipped && existing.quantity <= 1) {
      return (
        ok: false,
        message: 'Desequipe antes de vender sua última peça.',
        goldEarned: 0,
      );
    }

    final goldEarned = item.sellPrice;
    await _db.transaction(() async {
      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(HeroProfilesCompanion(gold: Value(hero.gold + goldEarned)));

      if (existing.quantity <= 1) {
        await (_db.delete(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(item.id)))
            .go();
      } else {
        await (_db.update(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(item.id)))
            .write(
          DungeonInventoryCompanion(quantity: Value(existing.quantity - 1)),
        );
      }
    });

    return (
      ok: true,
      message: 'Vendido por +$goldEarned ouro!',
      goldEarned: goldEarned,
    );
  }

  /// Registra o recorde de andar alcançado no bioma e se o Boss foi vencido.
  Future<void> recordProgress({
    required DungeonBiome biome,
    required int reachedFloor,
    required int seed,
    required bool defeatedBoss,
  }) async {
    await _db.transaction(() async {
      final existing = await (_db.select(_db.dungeonProgress)
            ..where((t) => t.biomeKey.equals(biome.key)))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.dungeonProgress).insert(
              DungeonProgressCompanion.insert(
                biomeKey: biome.key,
                bestFloor: Value(reachedFloor),
                clearsCount: Value(defeatedBoss ? 1 : 0),
                lastSeed: Value(seed),
              ),
            );
      } else {
        final newBest =
            reachedFloor > existing.bestFloor ? reachedFloor : existing.bestFloor;
        await (_db.update(_db.dungeonProgress)
              ..where((t) => t.biomeKey.equals(biome.key)))
            .write(
          DungeonProgressCompanion(
            bestFloor: Value(newBest),
            clearsCount:
                Value(existing.clearsCount + (defeatedBoss ? 1 : 0)),
            lastSeed: Value(seed),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }
}

