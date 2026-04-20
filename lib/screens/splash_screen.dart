import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _pulseController;
  late final AnimationController _dotsController;
  late final AnimationController _textController;
  late final AnimationController _exitController;
  late final AnimationController _particleController;
  late final AnimationController _shimmerController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoRotation;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _pulseScale;
  late final Animation<double> _pulseOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _exitOpacity;
  late final Animation<double> _exitScale;

  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _initParticles();
    _initAnimations();
    _startAnimationSequence();
  }

  void _initParticles() {
    final rng = math.Random(42);
    _particles = List.generate(20, (i) {
      return _Particle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        size: 2 + rng.nextDouble() * 4,
        speed: 0.2 + rng.nextDouble() * 0.8,
        opacity: 0.1 + rng.nextDouble() * 0.3,
      );
    });
  }

  void _initAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );
    _logoRotation = Tween<double>(begin: -0.15, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseScale = Tween<double>(
      begin: 0.8,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
    _pulseOpacity = Tween<double>(
      begin: 0.6,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInQuart),
    );
    _exitScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInQuart),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _pulseController.repeat();

    await Future.delayed(const Duration(milliseconds: 400));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _dotsController.repeat();

    await Future.delayed(const Duration(milliseconds: 2000));

    _exitController.forward();
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => MainScreen(key: MainScreen.mainKey),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    _dotsController.dispose();
    _textController.dispose();
    _exitController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor1 = isDark ? const Color(0xFF0A0B14) : const Color(0xFFF0FFF7);
    final bgColor2 = isDark ? const Color(0xFF161722) : const Color(0xFFFFFFFF);

    return AnimatedBuilder(
      animation: _exitController,
      builder: (context, child) {
        return Opacity(
          opacity: _exitOpacity.value,
          child: Transform.scale(scale: _exitScale.value, child: child),
        );
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [bgColor1, bgColor2],
            ),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _particleController,
                builder: (context, _) {
                  return CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: _ParticlePainter(
                      particles: _particles,
                      progress: _particleController.value,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  );
                },
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPulseRing(isDark),

                    const SizedBox(height: 40),

                    _buildBrandText(isDark),

                    const SizedBox(height: 12),

                    _buildTagline(isDark),

                    const SizedBox(height: 48),

                    _buildLoadingDots(isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulseRing(bool isDark) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              return Transform.scale(
                scale: _pulseScale.value,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(
                        _pulseOpacity.value * 0.5,
                      ),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final delayed = (_pulseController.value + 0.4).clamp(0.0, 1.0);
              final scale = 0.8 + (1.6 - 0.8) * delayed;
              final opacity = 0.6 * (1.0 - delayed);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accent.withOpacity(opacity * 0.4),
                      width: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    startAngle: _shimmerController.value * 2 * math.pi,
                    colors: [
                      AppColors.primary.withOpacity(0.0),
                      AppColors.primary.withOpacity(0.15),
                      AppColors.accent.withOpacity(0.1),
                      AppColors.primary.withOpacity(0.0),
                    ],
                  ),
                ),
                child: child,
              );
            },
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF1A1C2C)
                    : const Color(0xFFF5FFF7),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return Opacity(
                opacity: _logoOpacity.value,
                child: Transform.scale(
                  scale: _logoScale.value,
                  child: Transform.rotate(
                    angle: _logoRotation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.local_fire_department_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandText(bool isDark) {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [AppColors.primary, AppColors.accent, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'HOTDIE',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              letterSpacing: 8,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagline(bool isDark) {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: Text(
          'STYLE THAT BURNS',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 4,
            color: isDark
                ? AppColors.darkTextBody.withOpacity(0.7)
                : AppColors.lightTextBody.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingDots(bool isDark) {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (i) {
            final delay = i * 0.2;
            final t = (_dotsController.value - delay).clamp(0.0, 1.0);
            final bounce = math.sin(t * math.pi);
            final dotColor = Color.lerp(
              AppColors.primary.withOpacity(0.3),
              AppColors.accent,
              bounce,
            )!;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Transform.translate(
                offset: Offset(0, -8 * bounce),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3 * bounce),
                        blurRadius: 8 * bounce,
                        spreadRadius: 1 * bounce,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final yOffset = ((p.y + progress * p.speed) % 1.2) - 0.1;
      final xWave = math.sin((progress + p.x) * 2 * math.pi) * 0.02;
      final dx = (p.x + xWave) * size.width;
      final dy = yOffset * size.height;

      final paint = Paint()
        ..color = color.withOpacity(p.opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.5);

      canvas.drawCircle(Offset(dx, dy), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
