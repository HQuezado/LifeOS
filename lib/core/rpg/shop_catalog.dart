import 'package:material_ui/material_ui.dart';

import 'rpg_models.dart';

enum ShopCategory {
  furniture(key: 'furniture', label: 'Móveis'),
  equipment(key: 'equipment', label: 'Equipamentos'),
  consumable(key: 'consumable', label: 'Consumíveis');

  const ShopCategory({required this.key, required this.label});

  final String key;
  final String label;
}

enum EquipmentSlot {
  weapon('Arma'),
  outfit('Visual'),
  pet('Pet'),
  scene('Cenário');

  const EquipmentSlot(this.label);
  final String label;
}

class ShopItem {
  const ShopItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.effectBadge,
    required this.icon,
    required this.color,
    this.minHeroLevel = 1,
    this.slot,
  });

  final String id;
  final String name;
  final ShopCategory category;
  final int price;
  final String description;
  final String effectBadge;
  final IconData icon;
  final Color color;
  final int minHeroLevel;
  final EquipmentSlot? slot;
}

/// Catálogo oficial da Loja do LifeOS (Móveis com passivas reais, Equipamentos/Pets e Consumíveis).
class ShopCatalog {
  const ShopCatalog._();

  static const List<ShopItem> all = [
    // ==================== MÓVEIS DA CASA (PASSIVAS REAIS) ====================
    ShopItem(
      id: 'furn_garden',
      name: 'Horta de Ervas',
      category: ShopCategory.furniture,
      price: 150,
      description: 'Canteiro aromático que floresce com seus hábitos de saúde.',
      effectBadge: '+10% Ouro em VIG',
      icon: Icons.eco_rounded,
      color: Color(0xFF56C271),
    ),
    ShopItem(
      id: 'furn_arcane_desk',
      name: 'Escrivaninha Arcana',
      category: ShopCategory.furniture,
      price: 220,
      description: 'Mesa iluminada por velas mágicas para estudos e foco profundo.',
      effectBadge: '+10% XP em INT e Raids',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF5A9BE0),
    ),
    ShopItem(
      id: 'furn_workbench',
      name: 'Bancada de Ferramentas',
      category: ShopCategory.furniture,
      price: 260,
      description: 'Tudo organizado no lugar certo para golpes precisos.',
      effectBadge: '+4% Chance de Crítico',
      icon: Icons.handyman_rounded,
      color: Color(0xFF73EFF7),
    ),
    ShopItem(
      id: 'furn_fireplace',
      name: 'Lareira Aconchegante',
      category: ShopCategory.furniture,
      price: 320,
      description: 'Aquece sua casa nos dias difíceis e fortalece o Modo Energia.',
      effectBadge: '+10% XP SAB • +15g no Modo Energia',
      icon: Icons.fireplace_rounded,
      color: Color(0xFFE8A849),
    ),
    ShopItem(
      id: 'furn_tavern_table',
      name: 'Mesa de Taverna',
      category: ShopCategory.furniture,
      price: 380,
      description: 'Um canto acolhedor para boas conversas e alianças.',
      effectBadge: '+15% Ouro em CAR',
      icon: Icons.table_restaurant_rounded,
      color: Color(0xFFD98A3C),
    ),
    ShopItem(
      id: 'furn_forge',
      name: 'Forja do Aventureiro',
      category: ShopCategory.furniture,
      price: 650,
      minHeroLevel: 5,
      description: 'Aumenta o brilho das suas conquistas em masmorras.',
      effectBadge: '+15% XP e Ouro em Raids',
      icon: Icons.whatshot_rounded,
      color: Color(0xFFE05A5A),
    ),
    ShopItem(
      id: 'furn_star_library',
      name: 'Biblioteca Estelar',
      category: ShopCategory.furniture,
      price: 1200,
      minHeroLevel: 10,
      description: 'O ápice do seu Santuário: sabedoria acumulada de toda a jornada.',
      effectBadge: '+10% XP Geral em tudo',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFD97BFF),
    ),

    // ==================== EQUIPAMENTOS & PETS ====================
    ShopItem(
      id: 'eq_iron_blade',
      name: 'Lâmina da Determinação',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.weapon,
      price: 120,
      description: 'Arma confiável forjada para vencer o primeiro passo.',
      effectBadge: 'Arma equipada',
      icon: Icons.gavel_rounded,
      color: Color(0xFF94B0C2),
    ),
    ShopItem(
      id: 'eq_star_cloak',
      name: 'Capa do Viajante',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.outfit,
      price: 200,
      description: 'Manto 16-bit com bordado dourado para qualquer expedição.',
      effectBadge: 'Visual equipado',
      icon: Icons.checkroom_rounded,
      color: Color(0xFF5B6EE1),
    ),
    ShopItem(
      id: 'pet_pixel_cat',
      name: 'Gato Pixelado',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.pet,
      price: 250,
      description: 'Um gatinho laranja que cochila ao lado da sua lareira.',
      effectBadge: 'Pet companheiro na Casa',
      icon: Icons.pets_rounded,
      color: Color(0xFFFFCD75),
    ),
    ShopItem(
      id: 'pet_arcane_owl',
      name: 'Coruja Arcana',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.pet,
      price: 450,
      minHeroLevel: 3,
      description: 'Observa sua rotina com sabedoria e olhos brilhantes.',
      effectBadge: 'Pet companheiro na Casa',
      icon: Icons.flutter_dash_rounded,
      color: Color(0xFF73EFF7),
    ),
    ShopItem(
      id: 'pet_pocket_dragon',
      name: 'Dragãozinho de Bolso',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.pet,
      price: 800,
      minHeroLevel: 5,
      description: 'Pequeno, leal e adora moedas de Ouro brilhantes.',
      effectBadge: 'Pet lendário na Casa',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFE43B44),
    ),

    // ==================== CENÁRIOS DA CASA VIVA ====================
    ShopItem(
      id: 'scene_tavern',
      name: 'Cenário: Taverna Aconchegante',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.scene,
      price: 300,
      description: 'Madeira quente, lareira acesa e clima de descanso após as missões.',
      effectBadge: 'Cenário equipado na Casa',
      icon: Icons.cottage_rounded,
      color: Color(0xFFE8A849),
    ),
    ShopItem(
      id: 'scene_tower',
      name: 'Cenário: Torre Arcana',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.scene,
      price: 450,
      description: 'Estantes de grimórios, janela noturna estrelada e velas flutuantes.',
      effectBadge: 'Cenário equipado na Casa',
      icon: Icons.castle_rounded,
      color: Color(0xFF5B6EE1),
    ),
    ShopItem(
      id: 'scene_greenhouse',
      name: 'Cenário: Estufa Encantada',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.scene,
      price: 550,
      description: 'Plantas luminosas, vasos de ervas e luz suave atravessando o vidro.',
      effectBadge: 'Cenário equipado na Casa',
      icon: Icons.park_rounded,
      color: Color(0xFF56C271),
    ),
    ShopItem(
      id: 'scene_sanctuary',
      name: 'Cenário: Santuário Estelar',
      category: ShopCategory.equipment,
      slot: EquipmentSlot.scene,
      price: 900,
      minHeroLevel: 5,
      description: 'Salão lendário com vitrais dourados e céu cósmico ao fundo.',
      effectBadge: 'Cenário lendário na Casa',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFD97BFF),
    ),

    // ==================== CONSUMÍVEIS & UTILIDADES ====================
    ShopItem(
      id: 'cons_focus_potion',
      name: 'Poção de Foco',
      category: ShopCategory.consumable,
      price: 80,
      description: 'Ativa imediatamente +25% XP em todas as tarefas por 1 hora.',
      effectBadge: '+25% XP por 1h',
      icon: Icons.science_rounded,
      color: Color(0xFF73EFF7),
    ),
    ShopItem(
      id: 'cons_mystery_chest',
      name: 'Baú Misterioso',
      category: ShopCategory.consumable,
      price: 140,
      description: 'Adiciona 1 Baú Misterioso (Comum, Raro ou Épico) na aba Herói.',
      effectBadge: 'Loot surpresa!',
      icon: Icons.inventory_2_rounded,
      color: Color(0xFFFFCD75),
    ),
    ShopItem(
      id: 'cons_reclass_scroll',
      name: 'Pergaminho de Reclasse',
      category: ShopCategory.consumable,
      price: 350,
      description:
          'Permite trocar de classe a qualquer momento sem perder nível, atributos ou itens.',
      effectBadge: 'Troca de Classe',
      icon: Icons.history_edu_rounded,
      color: Color(0xFFD97BFF),
    ),
  ];

  static ShopItem? byId(String id) {
    for (final item in all) {
      if (item.id == id) return item;
    }
    return null;
  }

  static List<ShopItem> byCategory(ShopCategory category) =>
      all.where((i) => i.category == category).toList();

  /// Calcula desconto total na Loja (Bardo = 10% + 1% por nível de CAR acima de 1, teto 25%).
  static double discountRate({
    required HeroClass heroClass,
    required int charismaLevel,
  }) {
    final bardBonus = heroClass == HeroClass.bard ? 0.10 : 0.0;
    final carBonus = ((charismaLevel - 1) * 0.01).clamp(0.0, 0.25);
    return (bardBonus + carBonus).clamp(0.0, 0.25);
  }

  static int discountedPrice({
    required int basePrice,
    required HeroClass heroClass,
    required int charismaLevel,
  }) {
    final rate = discountRate(
      heroClass: heroClass,
      charismaLevel: charismaLevel,
    );
    return (basePrice * (1.0 - rate)).round().clamp(1, basePrice);
  }
}

