import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ColorSelectorWidget extends StatefulWidget {
  final List<int> colorARGBs;
  final bool isDark;

  const ColorSelectorWidget({
    super.key,
    required this.colorARGBs,
    required this.isDark,
  });

  @override
  State<ColorSelectorWidget> createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  int _selectedIndex = 0; // Default terpilih index 0

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.colorARGBs.length,
        (index) {
          final isSelected = _selectedIndex == index;
          final color = Color(widget.colorARGBs[index]);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (widget.isDark
                          ? AppColors.darkInputBorder
                          : AppColors.lightInputBorder),
                  width: isSelected ? 2.5 : 1.5,
                ),
              ),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: _isLightColor(color)
                            ? Colors.black87
                            : Colors.white,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Cek apakah warna terang agar icon check kontras
  bool _isLightColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5;
  }
}
