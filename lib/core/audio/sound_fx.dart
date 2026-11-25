import 'package:flutter/services.dart';

/// Efeitos sonoros 16-bit Chiptune + feedback tátil do LifeOS.
/// Respeita sempre a preferência `soundEnabled` do herói.
class LifeOsSfx {
  const LifeOsSfx._();

  static const _channel = MethodChannel('com.lifeos.lifeos/sfx');

  static Future<void> play(
    String effect, {
    required bool soundEnabled,
    bool haptic = false,
    bool heavyHaptic = false,
  }) async {
    if (heavyHaptic) {
      HapticFeedback.heavyImpact();
    } else if (haptic) {
      HapticFeedback.lightImpact();
    }

    if (!soundEnabled) return;
    try {
      await _channel.invokeMethod<bool>('play', {'effect': effect});
    } catch (_) {}
  }
}

