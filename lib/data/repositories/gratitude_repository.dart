import 'package:drift/drift.dart';

import '../../core/dungeon/dungeon_catalog.dart';
import '../../core/dungeon/dungeon_models.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/social/gratitude_seal.dart';
import '../database/app_database.dart';
import 'dungeon_repository.dart';
import 'hero_repository.dart';

class GratitudeSendResult {
  const GratitudeSendResult({
    required this.ok,
    required this.message,
    this.sealCode,
    this.shareMessage,
    this.payload,
  });

  final bool ok;
  final String message;
  final String? sealCode;
  final String? shareMessage;
  final GratitudeSealPayload? payload;
}

class GratitudeRedeemResult {
  const GratitudeRedeemResult({
    required this.ok,
    required this.message,
    this.senderName,
    this.note,
    this.xpGained = 0,
    this.goldGained = 0,
    this.itemReceived,
    this.heroLeveledUp = false,
  });

  final bool ok;
  final String message;
  final String? senderName;
  final String? note;
  final int xpGained;
  final int goldGained;
  final DungeonItem? itemReceived;
  final bool heroLeveledUp;
}

/// Repositório local da Fase 7 — Gratidão entre Aventureiros.
class GratitudeRepository {
  GratitudeRepository(
    this._db,
    this._heroRepository,
    this._dungeonRepository,
  );

  final AppDatabase _db;
  final HeroRepository _heroRepository;
  final DungeonRepository _dungeonRepository;

  Stream<List<GratitudeLog>> watchLogs() {
    return (_db.select(_db.gratitudeLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Garante que o herói tenha um `heroUid` único (para bloquear auto-resgate).
  Future<String> ensureHeroUid(HeroProfile hero) async {
    final current = hero.heroUid;
    if (current != null && current.isNotEmpty) return current;
    final generated = GratitudeSealCodec.generateUid();
    await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
        .write(HeroProfilesCompanion(heroUid: Value(generated)));
    return generated;
  }

  /// Cria um Selo de Gratidão assinado:
  /// - XP é gerado pelo sistema (NÃO desconta do remetente!).
  /// - Ouro e Item (se escolhidos) são transferidos da conta/mochila do remetente.
  /// - Trava anti-abuso: 1x por nível do herói, máximo 5 envios no total.
  Future<GratitudeSendResult> createGratitudeSeal({
    required String note,
    required int goldGift,
    DungeonItem? itemGift,
  }) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) {
      return const GratitudeSendResult(ok: false, message: 'Herói não encontrado.');
    }

    final check = GratitudeSealCodec.canSend(
      heroLevel: hero.level,
      sentCount: hero.gratitudeSentCount,
      lastSentLevel: hero.lastGratitudeSentLevel,
    );
    if (!check.allowed) {
      return GratitudeSendResult(ok: false, message: check.reason);
    }

    final safeGold = goldGift.clamp(0, GratitudeSealCodec.maxGoldGift);
    if (safeGold > hero.gold) {
      return GratitudeSendResult(
        ok: false,
        message: 'Você só tem ${hero.gold} moedas disponíveis.',
      );
    }

    // Se escolheu item, valida se existe na mochila e se não é a única peça equipada
    if (itemGift != null) {
      final invRow = await (_db.select(_db.dungeonInventory)
            ..where((t) => t.itemId.equals(itemGift.id)))
          .getSingleOrNull();
      if (invRow == null || invRow.quantity <= 0) {
        return const GratitudeSendResult(
          ok: false,
          message: 'Item não encontrado na mochila.',
        );
      }
      if (invRow.isEquipped && invRow.quantity <= 1) {
        return const GratitudeSendResult(
          ok: false,
          message: 'Desequipe este item antes de presenteá-lo.',
        );
      }
    }

    final heroUid = await ensureHeroUid(hero);
    final xpBlessing = GratitudeSealCodec.systemBlessingXpForLevel(hero.level);
    final cleanNote = note.trim();
    final clippedNote =
        cleanNote.length > 90 ? cleanNote.substring(0, 90) : cleanNote;

    final payload = GratitudeSealPayload(
      tokenId: GratitudeSealCodec.generateUid(),
      senderUid: heroUid,
      senderName: hero.name,
      senderLevel: hero.level,
      xpAmount: xpBlessing,
      goldAmount: safeGold,
      itemId: itemGift?.id,
      note: clippedNote,
      createdEpochSec: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000,
    );

    final sealCode = GratitudeSealCodec.encode(payload);
    final shareMessage = GratitudeSealCodec.buildShareMessage(
      payload: payload,
      sealCode: sealCode,
      itemName: itemGift?.name,
    );

    await _db.transaction(() async {
      // Desconta ouro (se houver) + registra uso do nível e contador de envios
      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(
        HeroProfilesCompanion(
          gold: Value(hero.gold - safeGold),
          gratitudeSentCount: Value(hero.gratitudeSentCount + 1),
          lastGratitudeSentLevel: Value(hero.level),
        ),
      );

      // Remove 1 unidade do item presenteado da mochila do remetente
      if (itemGift != null) {
        final invRow = await (_db.select(_db.dungeonInventory)
              ..where((t) => t.itemId.equals(itemGift.id)))
            .getSingleOrNull();
        if (invRow != null) {
          if (invRow.quantity <= 1) {
            await (_db.delete(_db.dungeonInventory)
                  ..where((t) => t.itemId.equals(itemGift.id)))
                .go();
          } else {
            await (_db.update(_db.dungeonInventory)
                  ..where((t) => t.itemId.equals(itemGift.id)))
                .write(
              DungeonInventoryCompanion(quantity: Value(invRow.quantity - 1)),
            );
          }
        }
      }

      // Salva no Mural de Gratidão
      await _db.into(_db.gratitudeLogs).insert(
            GratitudeLogsCompanion.insert(
              tokenId: payload.tokenId,
              direction: 'sent',
              peerName: 'Amigo Aventureiro',
              note: Value(clippedNote),
              xpAmount: Value(xpBlessing),
              goldAmount: Value(safeGold),
              itemId: Value(itemGift?.id),
              itemName: Value(itemGift?.name),
              sealCode: sealCode,
            ),
          );
    });

    return GratitudeSendResult(
      ok: true,
      message: 'Selo de Gratidão gerado! Envie para quem te ajudou.',
      sealCode: sealCode,
      shareMessage: shareMessage,
      payload: payload,
    );
  }

  /// Valida e resgata um Selo de Gratidão recebido de outro aventureiro.
  Future<GratitudeRedeemResult> redeemGratitudeSeal(String rawInput) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) {
      return const GratitudeRedeemResult(
        ok: false,
        message: 'Crie um herói antes de resgatar um Selo.',
      );
    }

    final receiveCheck = GratitudeSealCodec.canReceive(
      heroLevel: hero.level,
      receivedCount: hero.gratitudeReceivedCount,
      lastReceivedLevel: hero.lastGratitudeReceivedLevel,
    );
    if (!receiveCheck.allowed) {
      return GratitudeRedeemResult(ok: false, message: receiveCheck.reason);
    }

    final decoded = GratitudeSealCodec.decodeAndVerify(rawInput);
    if (decoded.payload == null) {
      return GratitudeRedeemResult(
        ok: false,
        message: decoded.error ?? 'Selo inválido.',
      );
    }
    final payload = decoded.payload!;
    final myUid = await ensureHeroUid(hero);

    if (payload.senderUid == myUid) {
      return const GratitudeRedeemResult(
        ok: false,
        message: 'Você não pode resgatar um Selo gerado pelo seu próprio herói!',
      );
    }

    final alreadyUsed = await (_db.select(_db.gratitudeLogs)
          ..where((t) => t.tokenId.equals(payload.tokenId)))
        .getSingleOrNull();
    if (alreadyUsed != null) {
      return const GratitudeRedeemResult(
        ok: false,
        message: 'Este Selo de Gratidão já foi utilizado.',
      );
    }

    DungeonItem? receivedItem;
    if (payload.itemId != null && payload.itemId!.isNotEmpty) {
      final catalog = await DungeonCatalog.loadFromAssets();
      receivedItem = catalog.itemById(payload.itemId!);
    }

    // Registra uso e histórico antes de creditar
    await _db.transaction(() async {
      await (_db.update(_db.heroProfiles)..where((t) => t.id.equals(hero.id)))
          .write(
        HeroProfilesCompanion(
          gratitudeReceivedCount: Value(hero.gratitudeReceivedCount + 1),
          lastGratitudeReceivedLevel: Value(hero.level),
        ),
      );

      await _db.into(_db.gratitudeLogs).insert(
            GratitudeLogsCompanion.insert(
              tokenId: payload.tokenId,
              direction: 'received',
              peerName: payload.senderName,
              note: Value(payload.note),
              xpAmount: Value(payload.xpAmount),
              goldAmount: Value(payload.goldAmount),
              itemId: Value(receivedItem?.id),
              itemName: Value(receivedItem?.name),
              sealCode: GratitudeSealCodec.encode(payload),
            ),
          );
    });

    if (receivedItem != null) {
      await _dungeonRepository.addItem(receivedItem);
    }

    final progress = await _heroRepository.awardProgress(
      attribute: RpgAttribute.charisma,
      xpGained: payload.xpAmount,
      goldGained: payload.goldAmount,
    );

    return GratitudeRedeemResult(
      ok: true,
      message: 'Selo resgatado com sucesso!',
      senderName: payload.senderName,
      note: payload.note,
      xpGained: payload.xpAmount,
      goldGained: payload.goldAmount,
      itemReceived: receivedItem,
      heroLeveledUp: progress.heroLeveledUp,
    );
  }
}

