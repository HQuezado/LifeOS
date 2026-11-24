import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../providers/app_providers.dart';

class CharacterCreationScreen extends ConsumerStatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  ConsumerState<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState
    extends ConsumerState<CharacterCreationScreen> {
  final _nameController = TextEditingController();
  HeroClass _selectedClass = HeroClass.warrior;
  ArmorTint _selectedTint = ArmorTint.original;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite o nome do seu herói para começar!'),
        ),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(heroRepositoryProvider).createHero(
            name: name,
            heroClass: _selectedClass,
            armorTint: _selectedTint,
          );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attr = _selectedClass.primaryAttribute;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'LIFE OS',
                      style: LifeOsTheme.pixelTitle(
                        size: 20,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Crie seu herói — 100% salvo no seu celular',
                      style: TextStyle(
                        color: LifeOsColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Nome do herói
              Text(
                '1. NOME DO HERÓI',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                maxLength: 24,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Ex.: Humberto, Aria, Kael...',
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),

              // Seletor das 5 classes
              Text(
                '2. ESCOLHA SUA CLASSE',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 112,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: HeroClass.values.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final heroClass = HeroClass.values[index];
                    final isSelected = heroClass == _selectedClass;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedClass = heroClass),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 92,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? LifeOsColors.surfaceHighlight
                              : LifeOsColors.surface,
                          border: Border.all(
                            color: isSelected
                                ? LifeOsColors.gold
                                : LifeOsColors.border,
                            width: isSelected ? 3 : 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeroSpriteWidget(
                              assetPath: heroClass.spriteAsset,
                              size: 54,
                              animate: isSelected,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              heroClass.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isSelected
                                    ? LifeOsColors.gold
                                    : LifeOsColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Ficha detalhada da classe selecionada
              PixelPanel(
                borderColor: _selectedClass.accentColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: LifeOsColors.bgDark,
                            border: Border.all(
                              color: _selectedClass.accentColor,
                              width: 2,
                            ),
                          ),
                          child: HeroSpriteWidget(
                            assetPath: _selectedClass.spriteAsset,
                            size: 72,
                            armorTint: _selectedTint,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedClass.name.toUpperCase(),
                                style: LifeOsTheme.pixelTitle(
                                  size: 13,
                                  color: LifeOsColors.gold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedClass.title,
                                style: const TextStyle(
                                  color: LifeOsColors.textSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                color: attr.color.withValues(alpha: 0.2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(attr.icon, size: 14, color: attr.color),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Atributo: ${attr.name} (${attr.shortName})',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: attr.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 22, color: LifeOsColors.border),
                    _DetailRow(
                      label: 'Passiva',
                      text: _selectedClass.passiveDescription,
                      color: LifeOsColors.xpBar,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      label: 'Habilidade — ${_selectedClass.abilityName}',
                      text: _selectedClass.abilityDescription,
                      color: LifeOsColors.gold,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      label: 'Evolui ${attr.name} com',
                      text: attr.description,
                      color: attr.color,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. Cor da Armadura / Manto
              Text(
                '3. COR DA ARMADURA / MANTO',
                style: LifeOsTheme.pixelTitle(
                  size: 10,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ArmorTint.values.map((tint) {
                  final selected = tint == _selectedTint;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTint = tint),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? tint.swatch.withValues(alpha: 0.25)
                            : LifeOsColors.surface,
                        border: Border.all(
                          color: selected ? LifeOsColors.gold : tint.swatch,
                          width: selected ? 2.5 : 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: tint.swatch,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tint.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: selected
                                  ? LifeOsColors.gold
                                  : LifeOsColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              PixelButton(
                label: 'INICIAR JORNADA',
                isLoading: _saving,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.text,
    required this.color,
  });

  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13.5,
            color: LifeOsColors.textPrimary,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

