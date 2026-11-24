import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';
import '../guide/guide_screen.dart';

/// Tela Inicial (Title Screen 16-bit) animada a 60 FPS:
/// paisagem crepuscular, estrelas cintilando, vaga-lumes dourados flutuando,
/// logo LIFE OS flutuante, controle de Som ON/OFF e Login Google.
class TitleScreen extends ConsumerStatefulWidget {
  const TitleScreen({
    super.key,
    required this.hero,
    required this.onContinue,
    required this.onNewHero,
  });

  final HeroProfile? hero;
  final VoidCallback onContinue;
  final VoidCallback onNewHero;

  @override
  ConsumerState<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends ConsumerState<TitleScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  bool _localSoundOn = true;
  bool _syncingGoogle = false;

  @override
  void initState() {
    super.initState();
    _localSoundOn = widget.hero?.soundEnabled ?? true;
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Future<void> _toggleSound() async {
    final next = !_localSoundOn;
    setState(() => _localSoundOn = next);
    if (next) {
      await SystemSound.play(SystemSoundType.click);
    }
    if (widget.hero != null) {
      await ref.read(heroRepositoryProvider).setSoundEnabled(next);
    }
  }

  Future<void> _connectGoogle() async {
    setState(() => _syncingGoogle = true);
    try {
      final res =
          await ref.read(googleSyncServiceProvider).connectAndSyncToday();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.message)),
      );
    } finally {
      if (mounted) setState(() => _syncingGoogle = false);
    }
  }

  Future<void> _confirmNewHero() async {
    if (widget.hero == null) {
      widget.onNewHero();
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'NOVO HERÓI?',
                style: LifeOsTheme.pixelTitle(size: 12, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 10),
              Text(
                'Isso apagará "${widget.hero!.name}" (Nv. ${widget.hero!.level}) para criar um novo personagem.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: LifeOsColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PixelButton(
                      label: 'CONFIRMAR',
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true) {
      await ref.read(heroRepositoryProvider).resetHero();
      widget.onNewHero();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;
    final heroClass = hero != null ? HeroClass.fromKey(hero.heroClass) : null;
    final tint = hero != null ? ArmorTint.fromKey(hero.armorTint) : ArmorTint.original;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Paisagem 9:16 com leve movimento de respiração (60 FPS)
          AnimatedBuilder(
            animation: _anim,
            builder: (context, child) {
              final wave = sin(_anim.value * 2 * pi);
              return Transform.scale(
                scale: 1.03 + wave * 0.012,
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/ui/title_bg.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
            ),
          ),

          // 2. Estrelas cintilando, vaga-lumes dourados e brilho suave da cabana (60 FPS)
          AnimatedBuilder(
            animation: _anim,
            builder: (context, _) => CustomPaint(
              painter: _TwilightParticlesPainter(_anim.value),
              size: Size.infinite,
            ),
          ),

          // 3. Vinheta suave na base para leitura cristalina dos botões
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.55, 1.0],
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.transparent,
                  LifeOsColors.bgDark.withValues(alpha: 0.88),
                ],
              ),
            ),
          ),

          // 4. Conteúdo da Tela Título
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
              child: Column(
                children: [
                  // Barra superior: Som ON/OFF, Guia e Login Google
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _TitleChipButton(
                        icon: _localSoundOn
                            ? Icons.volume_up_rounded
                            : Icons.volume_off_rounded,
                        label: _localSoundOn ? 'Som' : 'Mudo',
                        active: _localSoundOn,
                        onTap: _toggleSound,
                      ),
                      _TitleChipButton(
                        icon: Icons.menu_book_rounded,
                        label: 'Guia',
                        active: false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const GuideScreen(),
                            ),
                          );
                        },
                      ),
                      _TitleChipButton(
                        icon: _syncingGoogle
                            ? Icons.sync_rounded
                            : Icons.account_circle_rounded,
                        label: _syncingGoogle ? 'Sync...' : 'Google',
                        active: ref.read(googleSyncServiceProvider).isConnected,
                        onTap: _syncingGoogle ? null : _connectGoogle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // Logo LIFE OS flutuando suavemente
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (context, child) {
                      final dy = sin(_anim.value * 4 * pi) * 4.5;
                      return Transform.translate(
                        offset: Offset(0, dy),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/images/ui/logo_lifeos.png',
                      width: 280,
                      filterQuality: FilterQuality.none,
                    ),
                  ),

                  const Spacer(),

                  // Card resumido do herói salvo (se existir)
                  if (hero != null && heroClass != null) ...[
                    PixelPanel(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          HeroSpriteWidget(
                            assetPath: heroClass.spriteAsset,
                            size: 52,
                            armorTint: tint,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hero.name,
                                  style: LifeOsTheme.pixelTitle(
                                    size: 11,
                                    color: LifeOsColors.gold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${heroClass.name} • Nv. ${hero.level} • ${hero.gold} Ouro',
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: LifeOsColors.textSecondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    PixelButton(
                      label: 'CONTINUAR JORNADA',
                      onPressed: () {
                        if (_localSoundOn) {
                          SystemSound.play(SystemSoundType.click);
                        }
                        widget.onContinue();
                      },
                    ),
                    const SizedBox(height: 10),
                    PixelButton(
                      label: 'NOVO HERÓI',
                      backgroundColor: LifeOsColors.surface,
                      onPressed: _confirmNewHero,
                    ),
                  ] else ...[
                    PixelButton(
                      label: 'INICIAR AVENTURA',
                      onPressed: () {
                        if (_localSoundOn) {
                          SystemSound.play(SystemSoundType.click);
                        }
                        widget.onNewHero();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleChipButton extends StatelessWidget {
  const _TitleChipButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: LifeOsColors.bgDark.withValues(alpha: 0.78),
          border: Border.all(
            color: active ? LifeOsColors.gold : LifeOsColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: active ? LifeOsColors.gold : LifeOsColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: active ? LifeOsColors.gold : LifeOsColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animação nativa a 60 FPS: estrelas cintilando, vaga-lumes dourados e brilho suave.
class _TwilightParticlesPainter extends CustomPainter {
  _TwilightParticlesPainter(this.t);

  final double t;

  static final List<({double x, double y, double phase, double size})> _stars =
      List.generate(26, (i) {
    final rng = Random(100 + i);
    return (
      x: rng.nextDouble(),
      y: rng.nextDouble() * 0.42,
      phase: rng.nextDouble() * 2 * pi,
      size: rng.nextBool() ? 2.5 : 3.5,
    );
  });

  static final List<({double x, double y, double phase, double drift})>
      _fireflies = List.generate(14, (i) {
    final rng = Random(500 + i);
    return (
      x: rng.nextDouble(),
      y: 0.50 + rng.nextDouble() * 0.40,
      phase: rng.nextDouble() * 2 * pi,
      drift: 0.018 + rng.nextDouble() * 0.03,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    final angle = t * 2 * pi;

    // 1. Estrelas pixeladas cintilando no céu
    for (final s in _stars) {
      final alpha = 0.25 + 0.70 * (0.5 + 0.5 * sin(angle * 2 + s.phase));
      final paint = Paint()
        ..color = const Color(0xFFFFF4CC).withValues(alpha: alpha);
      final px = s.x * size.width;
      final py = s.y * size.height;
      canvas.drawRect(Rect.fromLTWH(px, py, s.size, s.size), paint);
    }

    // 2. Brilho quente suave pulsando na cabana (lado direito)
    final glowAlpha = 0.10 + 0.07 * sin(angle * 3);
    final cabinCenter = Offset(size.width * 0.78, size.height * 0.62);
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFB74D).withValues(alpha: glowAlpha),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: cabinCenter, radius: 95));
    canvas.drawCircle(cabinCenter, 95, glowPaint);

    // 3. Vaga-lumes dourados flutuando suavemente
    for (final f in _fireflies) {
      final fx = (f.x + sin(angle + f.phase) * f.drift) * size.width;
      final fy = (f.y + cos(angle * 1.5 + f.phase) * 0.025) * size.height;
      final pulse = 0.35 + 0.65 * (0.5 + 0.5 * sin(angle * 3 + f.phase));

      final halo = Paint()
        ..color = const Color(0xFFFFD54F).withValues(alpha: pulse * 0.28);
      canvas.drawCircle(Offset(fx, fy), 8, halo);

      final core = Paint()
        ..color = const Color(0xFFFFF1A8).withValues(alpha: pulse);
      canvas.drawRect(Rect.fromLTWH(fx - 1.5, fy - 1.5, 3, 3), core);
    }
  }

  @override
  bool shouldRepaint(covariant _TwilightParticlesPainter oldDelegate) =>
      oldDelegate.t != t;
}

