import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Custom page route dengan animasi loading screen overlay.
///
/// Alur animasi:
/// 1. Overlay gelap muncul dari bawah ke atas (slide up)
/// 2. Spinner/logo berputar di tengah overlay
/// 3. Overlay slide ke atas keluar layar, reveal halaman baru di bawahnya
///
/// Durasi total ≈ 900ms, terasa premium tapi tidak lambat.
class LoadingPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  LoadingPageRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 900),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _LoadingTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        );
}

class _LoadingTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const _LoadingTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- Fase 1 (0.0 → 0.45): Overlay masuk dari bawah ---
    final overlayEnter = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    );

    // --- Fase 2 (0.35 → 0.65): Loading spinner muncul & spin ---
    final spinnerOpacity = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.25, 0.55, curve: Curves.easeIn),
    );
    final spinnerFadeOut = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.55, 0.70, curve: Curves.easeOut),
    );

    // --- Fase 3 (0.55 → 1.0): Overlay keluar ke atas, reveal page ---
    final overlayExit = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.55, 1.0, curve: Curves.easeInCubic),
    );

    // --- Fade in halaman baru ---
    final pageFade = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
    final pageScale = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // --- Secondary animation (halaman ini di-push keluar oleh halaman baru) ---
    final secondaryFade = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut),
    );

    final overlayColor = isDark
        ? const Color(0xFF0D0E1A)
        : const Color(0xFFF5F6FA);

    return Stack(
      children: [
        // Halaman baru (di bawah overlay)
        FadeTransition(
          opacity: pageFade,
          child: ScaleTransition(
            scale: pageScale,
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: secondaryFade,
              child: child,
            ),
          ),
        ),

        // Overlay loading screen
        if (animation.value < 1.0)
          _buildOverlay(
            overlayEnter: overlayEnter,
            overlayExit: overlayExit,
            spinnerOpacity: spinnerOpacity,
            spinnerFadeOut: spinnerFadeOut,
            overlayColor: overlayColor,
            isDark: isDark,
            animation: animation,
          ),
      ],
    );
  }

  Widget _buildOverlay({
    required Animation<double> overlayEnter,
    required Animation<double> overlayExit,
    required Animation<double> spinnerOpacity,
    required Animation<double> spinnerFadeOut,
    required Color overlayColor,
    required bool isDark,
    required Animation<double> animation,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final screenHeight = MediaQuery.of(context).size.height;

        // Overlay position: masuk dari bawah, lalu keluar ke atas
        double overlayY;
        if (animation.value <= 0.55) {
          // Masuk dari bawah
          overlayY = screenHeight * (1.0 - overlayEnter.value);
        } else {
          // Keluar ke atas
          overlayY = -screenHeight * overlayExit.value;
        }

        // Spinner opacity: fade in lalu fade out
        final spinnerAlpha = animation.value <= 0.55
            ? spinnerOpacity.value
            : (1.0 - spinnerFadeOut.value).clamp(0.0, 1.0);

        return Positioned(
          top: overlayY,
          left: 0,
          right: 0,
          height: screenHeight,
          child: Container(
            color: overlayColor,
            child: Center(
              child: Opacity(
                opacity: spinnerAlpha,
                child: _LoadingSpinner(
                  progress: animation.value,
                  isDark: isDark,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Widget spinner kustom dengan animasi lingkaran + ikon brand
class _LoadingSpinner extends StatelessWidget {
  final double progress;
  final bool isDark;

  const _LoadingSpinner({
    required this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Spin angle berdasarkan progress (beberapa putaran)
    final spinAngle = progress * 4 * math.pi;
    // Pulse scale
    final pulse = 1.0 + 0.08 * math.sin(progress * 6 * math.pi);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer spinning ring
              Transform.rotate(
                angle: spinAngle,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.15),
                      width: 3,
                    ),
                  ),
                  child: CustomPaint(
                    painter: _ArcPainter(
                      progress: progress,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              // Inner pulsing icon
              Transform.scale(
                scale: pulse,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.accent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Animated dots
        _buildAnimatedDots(progress),
      ],
    );
  }

  Widget _buildAnimatedDots(double progress) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final delay = i * 0.15;
        final t = ((progress * 3) - delay) % 1.0;
        final bounce = math.sin(t.clamp(0.0, 1.0) * math.pi);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          child: Transform.translate(
            offset: Offset(0, -4 * bounce),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.lerp(
                  AppColors.primary.withOpacity(0.3),
                  AppColors.accent,
                  bounce,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2 * bounce),
                    blurRadius: 4 * bounce,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Painter untuk arc spinner
class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // Arc length bervariasi
    final sweep = 0.8 + 0.6 * math.sin(progress * 2 * math.pi);
    canvas.drawArc(rect, 0, sweep * math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
