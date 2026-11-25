import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

/// Payload assinado de um **Selo de Gratidão** trocado entre aventureiros do LifeOS (Fase 7).
class GratitudeSealPayload {
  const GratitudeSealPayload({
    required this.tokenId,
    required this.senderUid,
    required this.senderName,
    required this.senderLevel,
    required this.xpAmount,
    required this.goldAmount,
    required this.createdEpochSec,
    this.itemId,
    this.note = '',
  });

  final String tokenId;
  final String senderUid;
  final String senderName;
  final int senderLevel;
  final int xpAmount;
  final int goldAmount;
  final String? itemId;
  final String note;
  final int createdEpochSec;

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(createdEpochSec * 1000, isUtc: true)
          .toLocal();

  Map<String, dynamic> toCompactJson() => {
        't': tokenId,
        'u': senderUid,
        'n': senderName,
        'l': senderLevel,
        'x': xpAmount,
        'g': goldAmount,
        if (itemId != null && itemId!.isNotEmpty) 'i': itemId,
        if (note.isNotEmpty) 'm': note,
        'c': createdEpochSec,
      };

  factory GratitudeSealPayload.fromCompactJson(Map<String, dynamic> map) {
    return GratitudeSealPayload(
      tokenId: map['t'] as String,
      senderUid: map['u'] as String,
      senderName: map['n'] as String,
      senderLevel: (map['l'] as num).toInt(),
      xpAmount: (map['x'] as num).toInt(),
      goldAmount: (map['g'] as num).toInt(),
      itemId: map['i'] as String?,
      note: (map['m'] as String?) ?? '',
      createdEpochSec: (map['c'] as num).toInt(),
    );
  }
}

/// Regras anti-abuso e motor criptográfico (HMAC-SHA256 puro em Dart) dos Selos de Gratidão.
class GratitudeSealCodec {
  const GratitudeSealCodec._();

  static const String prefix = 'LIFEOS-GRAT-';
  static const int maxUsesPerHero = 5;
  static const int maxGoldGift = 500;
  static const Duration sealValidity = Duration(days: 14);

  /// Chave de integridade embutida no app para impedir adulteração manual dos códigos.
  static const String _hmacSecret = 'LifeOS::Phase7::GratitudeSeal::v1::2026!';

  /// Calcula a Bênção de XP gerada pelo sistema (sem descontar do remetente).
  static int systemBlessingXpForLevel(int senderLevel) {
    final safeLv = senderLevel < 1 ? 1 : senderLevel;
    return 75 + (safeLv * 15);
  }

  /// Gera um identificador único seguro de 16 caracteres hexadecimais.
  static String generateUid([Random? rng]) {
    final r = rng ?? Random.secure();
    final bytes = List<int>.generate(8, (_) => r.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Verifica se o herói pode ENVIAR um Selo agora (1x por nível, máx. 5 no total).
  static ({bool allowed, String reason}) canSend({
    required int heroLevel,
    required int sentCount,
    required int lastSentLevel,
  }) {
    if (sentCount >= maxUsesPerHero) {
      return (
        allowed: false,
        reason: 'Você já usou todos os $maxUsesPerHero Selos de Gratidão disponíveis.',
      );
    }
    if (lastSentLevel >= heroLevel) {
      return (
        allowed: false,
        reason:
            'Você já enviou um Selo no Nível $heroLevel. O próximo libera ao chegar no Nível ${heroLevel + 1}!',
      );
    }
    return (allowed: true, reason: '');
  }

  /// Verifica se o herói pode RECEBER um Selo agora (1x por nível, máx. 5 no total).
  static ({bool allowed, String reason}) canReceive({
    required int heroLevel,
    required int receivedCount,
    required int lastReceivedLevel,
  }) {
    if (receivedCount >= maxUsesPerHero) {
      return (
        allowed: false,
        reason:
            'Você já atingiu o limite máximo de $maxUsesPerHero Selos recebidos.',
      );
    }
    if (lastReceivedLevel >= heroLevel) {
      return (
        allowed: false,
        reason:
            'Você já resgatou um Selo no Nível $heroLevel. Suba para o Nível ${heroLevel + 1} para resgatar outro!',
      );
    }
    return (allowed: true, reason: '');
  }

  /// Codifica e assina um Selo de Gratidão pronto para copiar ou enviar no WhatsApp.
  static String encode(GratitudeSealPayload payload) {
    final jsonBytes = utf8.encode(jsonEncode(payload.toCompactJson()));
    final encodedBody = base64Url.encode(jsonBytes).replaceAll('=', '');
    final sig = _hmacSha256Hex(_hmacSecret, encodedBody).substring(0, 16);
    return '$prefix$encodedBody.$sig';
  }

  /// Decodifica, extrai (mesmo colado dentro de uma mensagem de WhatsApp!) e valida a assinatura.
  static ({GratitudeSealPayload? payload, String? error}) decodeAndVerify(
    String rawInput, {
    DateTime? now,
  }) {
    final match = RegExp(r'LIFEOS-GRAT-([A-Za-z0-9\-_]+)\.([a-fA-F0-9]{16})')
        .firstMatch(rawInput.trim());
    if (match == null) {
      return (
        payload: null,
        error: 'Código inválido. Cole o Selo começando com LIFEOS-GRAT-...',
      );
    }

    final encodedBody = match.group(1)!;
    final providedSig = match.group(2)!.toLowerCase();
    final expectedSig = _hmacSha256Hex(_hmacSecret, encodedBody).substring(0, 16);
    if (providedSig != expectedSig) {
      return (
        payload: null,
        error: 'Assinatura do Selo inválida ou código adulterado.',
      );
    }

    try {
      final padded = encodedBody.padRight(
        (encodedBody.length + 3) ~/ 4 * 4,
        '=',
      );
      final jsonStr = utf8.decode(base64Url.decode(padded));
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      final payload = GratitudeSealPayload.fromCompactJson(map);

      if (payload.xpAmount < 0 ||
          payload.xpAmount > 2000 ||
          payload.goldAmount < 0 ||
          payload.goldAmount > maxGoldGift) {
        return (payload: null, error: 'Valores fora do limite permitido.');
      }

      final current = now ?? DateTime.now();
      if (current.difference(payload.createdAt) > sealValidity) {
        return (
          payload: null,
          error: 'Este Selo expirou (validade de ${sealValidity.inDays} dias).',
        );
      }

      return (payload: payload, error: null);
    } catch (_) {
      return (
        payload: null,
        error: 'Não foi possível ler o Selo de Gratidão.',
      );
    }
  }

  /// Mensagem pronta e calorosa para enviar no WhatsApp.
  static String buildShareMessage({
    required GratitudeSealPayload payload,
    required String sealCode,
    String? itemName,
  }) {
    final gifts = <String>[
      if (payload.xpAmount > 0) '+${payload.xpAmount} XP',
      if (payload.goldAmount > 0) '+${payload.goldAmount} Ouro',
      ?itemName,
    ].join(' • ');

    final noteLine = payload.note.isNotEmpty ? '"${payload.note}"\n\n' : '';
    return '✨ ${payload.senderName} te enviou um Selo de Gratidão no LifeOS!\n'
        '$noteLine'
        '🎁 Presente: $gifts\n'
        'Abra o LifeOS → Herói → Gratidão e cole esta mensagem:\n'
        '$sealCode';
  }

  // --- Implementação pura em Dart de SHA-256 (RFC 6234) + HMAC-SHA256 ---

  static String _hmacSha256Hex(String keyStr, String messageStr) {
    const blockSize = 64;
    var key = Uint8List.fromList(utf8.encode(keyStr));
    if (key.length > blockSize) {
      key = _sha256(key);
    }
    final paddedKey = Uint8List(blockSize)..setRange(0, key.length, key);

    final oKeyPad = Uint8List(blockSize);
    final iKeyPad = Uint8List(blockSize);
    for (var i = 0; i < blockSize; i++) {
      oKeyPad[i] = paddedKey[i] ^ 0x5c;
      iKeyPad[i] = paddedKey[i] ^ 0x36;
    }

    final msgBytes = utf8.encode(messageStr);
    final inner = Uint8List(blockSize + msgBytes.length)
      ..setRange(0, blockSize, iKeyPad)
      ..setRange(blockSize, blockSize + msgBytes.length, msgBytes);
    final innerHash = _sha256(inner);

    final outer = Uint8List(blockSize + innerHash.length)
      ..setRange(0, blockSize, oKeyPad)
      ..setRange(blockSize, blockSize + innerHash.length, innerHash);
    final digest = _sha256(outer);

    return digest.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  static const List<int> _k = [
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
  ];

  static Uint8List _sha256(Uint8List input) {
    final bitLen = input.length * 8;
    final padLen = ((input.length + 9 + 63) ~/ 64) * 64;
    final data = Uint8List(padLen)..setRange(0, input.length, input);
    data[input.length] = 0x80;
    final bd = ByteData.view(data.buffer);
    bd.setUint32(padLen - 8, (bitLen ~/ 0x100000000) & 0xFFFFFFFF);
    bd.setUint32(padLen - 4, bitLen & 0xFFFFFFFF);

    var h0 = 0x6a09e667;
    var h1 = 0xbb67ae85;
    var h2 = 0x3c6ef372;
    var h3 = 0xa54ff53a;
    var h4 = 0x510e527f;
    var h5 = 0x9b05688c;
    var h6 = 0x1f83d9ab;
    var h7 = 0x5be0cd19;

    final w = List<int>.filled(64, 0);
    int rotr(int x, int n) => ((x >>> n) | (x << (32 - n))) & 0xFFFFFFFF;

    for (var offset = 0; offset < padLen; offset += 64) {
      for (var i = 0; i < 16; i++) {
        w[i] = bd.getUint32(offset + i * 4);
      }
      for (var i = 16; i < 64; i++) {
        final s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >>> 3);
        final s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >>> 10);
        w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xFFFFFFFF;
      }

      var a = h0, b = h1, c = h2, d = h3, e = h4, f = h5, g = h6, h = h7;
      for (var i = 0; i < 64; i++) {
        final s1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25);
        final ch = (e & f) ^ ((~e & 0xFFFFFFFF) & g);
        final temp1 = (h + s1 + ch + _k[i] + w[i]) & 0xFFFFFFFF;
        final s0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22);
        final maj = (a & b) ^ (a & c) ^ (b & c);
        final temp2 = (s0 + maj) & 0xFFFFFFFF;

        h = g;
        g = f;
        f = e;
        e = (d + temp1) & 0xFFFFFFFF;
        d = c;
        c = b;
        b = a;
        a = (temp1 + temp2) & 0xFFFFFFFF;
      }

      h0 = (h0 + a) & 0xFFFFFFFF;
      h1 = (h1 + b) & 0xFFFFFFFF;
      h2 = (h2 + c) & 0xFFFFFFFF;
      h3 = (h3 + d) & 0xFFFFFFFF;
      h4 = (h4 + e) & 0xFFFFFFFF;
      h5 = (h5 + f) & 0xFFFFFFFF;
      h6 = (h6 + g) & 0xFFFFFFFF;
      h7 = (h7 + h) & 0xFFFFFFFF;
    }

    final out = Uint8List(32);
    final outBd = ByteData.view(out.buffer);
    outBd.setUint32(0, h0);
    outBd.setUint32(4, h1);
    outBd.setUint32(8, h2);
    outBd.setUint32(12, h3);
    outBd.setUint32(16, h4);
    outBd.setUint32(20, h5);
    outBd.setUint32(24, h6);
    outBd.setUint32(28, h7);
    return out;
  }
}
