import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/core/rpg/rpg_models.dart';

void main() {
  group('LifeOS RPG Progression', () {
    test('5 classes map 1:1 to all 5 attributes', () {
      expect(HeroClass.values.length, 5);
      expect(RpgAttribute.values.length, 5);

      final mappedAttributes =
          HeroClass.values.map((c) => c.primaryAttribute).toSet();
      expect(mappedAttributes, RpgAttribute.values.toSet());
    });

    test('Hero general XP curve is linear and constant', () {
      expect(RpgProgression.xpForNextHeroLevel(1), 100);
      expect(RpgProgression.xpForNextHeroLevel(2), 150);
      expect(RpgProgression.xpForNextHeroLevel(5), 300);
      expect(RpgProgression.xpForNextHeroLevel(10), 550);
    });

    test('Attribute XP curve is linear and lighter than general XP', () {
      expect(RpgProgression.xpForNextAttributeLevel(1), 60);
      expect(RpgProgression.xpForNextAttributeLevel(2), 90);
      expect(RpgProgression.xpForNextAttributeLevel(5), 180);
      expect(RpgProgression.xpForNextAttributeLevel(10), 330);
    });

    test('House stages unlock at levels 1, 5, 10, 20', () {
      expect(RpgProgression.houseStageName(1), 'Cabana Inicial');
      expect(RpgProgression.houseStageName(5), 'Casa de Madeira');
      expect(RpgProgression.houseStageName(10), 'Mansão do Aventureiro');
      expect(RpgProgression.houseStageName(20), 'Santuário Lendário');
    });
  });
}
