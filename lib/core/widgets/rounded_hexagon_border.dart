import 'dart:math';
import 'package:flutter/material.dart';

/// Custom Hexagon Shape yang rounded — dipakai untuk FAB cart di tengah navbar.
/// Sekarang hanya ada satu definisi di sini, tidak perlu copy-paste di setiap screen.
class RoundedHexagonBorder extends ShapeBorder {
  const RoundedHexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final cx = rect.center.dx;
    final cy = rect.center.dy;
    final r = rect.shortestSide / 2;
    final cornerRadius = r * 0.25;

    // 6 titik hexagon (flat-top, dirotasi 90°)
    final angles = List.generate(
      6,
      (i) => (i * 60 - 90) * (pi / 180),
    );
    final points = angles
        .map((a) => Offset(cx + r * cos(a), cy + r * sin(a)))
        .toList();

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final curr = points[i];
      final next = points[(i + 1) % 6];
      final prev = points[(i + 5) % 6];

      final toCurr = (curr - prev);
      final toNext = (next - curr);

      final len1 = toCurr.distance;
      final len2 = toNext.distance;

      final p1 =
          curr -
          Offset(
            toCurr.dx / len1 * cornerRadius,
            toCurr.dy / len1 * cornerRadius,
          );
      final p2 =
          curr +
          Offset(
            toNext.dx / len2 * cornerRadius,
            toNext.dy / len2 * cornerRadius,
          );

      if (i == 0) {
        path.moveTo(p1.dx, p1.dy);
      } else {
        path.lineTo(p1.dx, p1.dy);
      }
      path.quadraticBezierTo(curr.dx, curr.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
