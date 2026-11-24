import 'package:material_ui/material_ui.dart';

/// Os 5 atributos fundamentais do LifeOS (1:1 com as 5 classes).
enum RpgAttribute {
  vigor(
    key: 'VIG',
    name: 'Vigor',
    shortName: 'VIG',
    description: 'Saúde, exercícios, água, alimentação e rotina física.',
    mechanicalBonus: 'Bônus em hábitos diários e resistência em dias cheios',
    color: Color(0xFFE05A5A),
    icon: Icons.favorite_rounded,
  ),
  intellect(
    key: 'INT',
    name: 'Intelecto',
    shortName: 'INT',
    description: 'Estudo, trabalho focado, leitura e projetos.',
    mechanicalBonus: '+2% XP em Raids por nível',
    color: Color(0xFF5A9BE0),
    icon: Icons.auto_stories_rounded,
  ),
  dexterity(
    key: 'DES',
    name: 'Destreza',
    shortName: 'DES',
    description: 'Tarefas práticas, organização e burocracias rápidas.',
    mechanicalBonus: '+0.5% chance de Acerto Crítico por nível',
    color: Color(0xFF56C271),
    icon: Icons.bolt_rounded,
  ),
  wisdom(
    key: 'SAB',
    name: 'Sabedoria',
    shortName: 'SAB',
    description: 'Sono, autocuidado, lazer consciente e finanças.',
    mechanicalBonus: 'Aumenta sorte de Baús e passivas da Casa Viva',
    color: Color(0xFF45B5AA),
    icon: Icons.spa_rounded,
  ),
  charisma(
    key: 'CAR',
    name: 'Carisma',
    shortName: 'CAR',
    description:
        'Tarefas sociais: conversar, apresentar trabalho, vendas e responder mensagens.',
    mechanicalBonus: '+1% desconto na Loja por nível (até 25%)',
    color: Color(0xFFE8A849),
    icon: Icons.forum_rounded,
  );

  const RpgAttribute({
    required this.key,
    required this.name,
    required this.shortName,
    required this.description,
    required this.mechanicalBonus,
    required this.color,
    required this.icon,
  });

  final String key;
  final String name;
  final String shortName;
  final String description;
  final String mechanicalBonus;
  final Color color;
  final IconData icon;

  static RpgAttribute fromKey(String key) {
    return RpgAttribute.values.firstWhere(
      (a) => a.key == key,
      orElse: () => RpgAttribute.vigor,
    );
  }
}

/// As 5 classes iniciais do LifeOS.
enum HeroClass {
  warrior(
    key: 'warrior',
    name: 'Guerreiro',
    title: 'Mestre da Disciplina',
    primaryAttribute: RpgAttribute.vigor,
    spriteAsset: 'assets/images/classes/warrior.png',
    passiveDescription: '+15% Ouro e XP em hábitos diários e tarefas de saúde.',
    abilityName: 'Golpe Constante',
    abilityDescription:
        'Concluir 3 tarefas no mesmo dia concede um bônus extra de Ouro.',
    accentColor: Color(0xFFC43848),
  ),
  mage(
    key: 'mage',
    name: 'Mago',
    title: 'Arcanista do Foco',
    primaryAttribute: RpgAttribute.intellect,
    spriteAsset: 'assets/images/classes/mage.png',
    passiveDescription: '+15% XP em inimigos de Raid e blocos de foco.',
    abilityName: 'Explosão Arcana',
    abilityDescription:
        'Ao limpar uma Raid, aumenta a chance do Baú subir de raridade.',
    accentColor: Color(0xFF5B6EE1),
  ),
  rogue(
    key: 'rogue',
    name: 'Ladino',
    title: 'Sombra da Agilidade',
    primaryAttribute: RpgAttribute.dexterity,
    spriteAsset: 'assets/images/classes/rogue.png',
    passiveDescription:
        '+8% de chance base de Acerto Crítico e +20% Ouro em Missões Relâmpago.',
    abilityName: 'Saque Rápido',
    abilityDescription:
        'Concluir uma tarefa atrasada do Google Tasks dá bônus extra de Ouro.',
    accentColor: Color(0xFF38B764),
  ),
  alchemist(
    key: 'alchemist',
    name: 'Alquimista',
    title: 'Guardião do Equilíbrio',
    primaryAttribute: RpgAttribute.wisdom,
    spriteAsset: 'assets/images/classes/alchemist.png',
    passiveDescription:
        '+20% eficácia nos móveis da Casa Viva e +15% XP em autocuidado.',
    abilityName: 'Elixir da Calma',
    abilityDescription:
        'No Modo Energia (1x/sem), 3 micro-vitórias garantem 1 Baú Comum extra.',
    accentColor: Color(0xFF3B9D9C),
  ),
  bard(
    key: 'bard',
    name: 'Bardo',
    title: 'Voz do Carisma',
    primaryAttribute: RpgAttribute.charisma,
    spriteAsset: 'assets/images/classes/bard.png',
    passiveDescription:
        '+15% Ouro/XP em tarefas sociais e 10% de desconto permanente na Loja.',
    abilityName: 'Inspiração do Bardo',
    abilityDescription:
        'Concluir uma tarefa de Carisma dá +25% XP na próxima tarefa de outro atributo.',
    accentColor: Color(0xFFD98A3C),
  );

  const HeroClass({
    required this.key,
    required this.name,
    required this.title,
    required this.primaryAttribute,
    required this.spriteAsset,
    required this.passiveDescription,
    required this.abilityName,
    required this.abilityDescription,
    required this.accentColor,
  });

  final String key;
  final String name;
  final String title;
  final RpgAttribute primaryAttribute;
  final String spriteAsset;
  final String passiveDescription;
  final String abilityName;
  final String abilityDescription;
  final Color accentColor;

  static HeroClass fromKey(String key) {
    return HeroClass.values.firstWhere(
      (c) => c.key == key,
      orElse: () => HeroClass.warrior,
    );
  }
}

/// Dificuldade das tarefas e tabela base de recompensas.
enum TaskDifficulty {
  micro(key: 'micro', label: 'Micro', baseXp: 15, baseGold: 10),
  easy(key: 'easy', label: 'Fácil', baseXp: 30, baseGold: 20),
  medium(key: 'medium', label: 'Média', baseXp: 60, baseGold: 40),
  hard(key: 'hard', label: 'Difícil', baseXp: 100, baseGold: 70);

  const TaskDifficulty({
    required this.key,
    required this.label,
    required this.baseXp,
    required this.baseGold,
  });

  final String key;
  final String label;
  final int baseXp;
  final int baseGold;
}

/// Fórmulas de progressão linear constante definidas no DESIGN.md.
class RpgProgression {
  const RpgProgression._();

  /// Nível do Personagem: 100 + (Nível - 1) * 50
  static int xpForNextHeroLevel(int level) => 100 + (level - 1) * 50;

  /// Nível de Atributo: 60 + (Nível - 1) * 30
  static int xpForNextAttributeLevel(int level) => 60 + (level - 1) * 30;

  /// Bônus de Ouro ao subir de Nível Geral.
  static const int levelUpGoldBonus = 50;

  /// Limite suave de micro-tarefas diárias antes da recomendação gentil.
  static const int softMicroTaskDailyLimit = 10;

  /// Estágio visual da Casa Viva conforme o nível do personagem.
  static String houseStageName(int heroLevel) {
    if (heroLevel >= 20) return 'Santuário Lendário';
    if (heroLevel >= 10) return 'Mansão do Aventureiro';
    if (heroLevel >= 5) return 'Casa de Madeira';
    return 'Cabana Inicial';
  }
}

/// Tinturas personalizáveis da armadura / manto / roupa do herói.
enum ArmorTint {
  original(key: 'default', label: 'Original', swatch: Color(0xFF94B0C2), tintColor: null),
  ruby(key: 'ruby', label: 'Rubi', swatch: Color(0xFFD94A54), tintColor: Color(0xFFD94A54)),
  emerald(key: 'emerald', label: 'Esmeralda', swatch: Color(0xFF38B764), tintColor: Color(0xFF38B764)),
  sapphire(key: 'sapphire', label: 'Safira', swatch: Color(0xFF4A86E8), tintColor: Color(0xFF4A86E8)),
  gold(key: 'gold', label: 'Ouro Real', swatch: Color(0xFFE8A849), tintColor: Color(0xFFE8A849)),
  amethyst(key: 'amethyst', label: 'Ametista', swatch: Color(0xFFB366E8), tintColor: Color(0xFFB366E8)),
  obsidian(key: 'obsidian', label: 'Obsidiana', swatch: Color(0xFF3A3644), tintColor: Color(0xFF4E485C));

  const ArmorTint({
    required this.key,
    required this.label,
    required this.swatch,
    required this.tintColor,
  });

  final String key;
  final String label;
  final Color swatch;
  final Color? tintColor;

  static ArmorTint fromKey(String key) {
    return ArmorTint.values.firstWhere(
      (t) => t.key == key,
      orElse: () => ArmorTint.original,
    );
  }
}

