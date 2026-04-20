import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SizeSelectorWidget extends StatefulWidget {
  final List<String> sizes;
  final bool isDark;

  const SizeSelectorWidget({
    super.key,
    required this.sizes,
    required this.isDark,
  });

  @override
  State<SizeSelectorWidget> createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.sizes.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? AppColors.primary
                    : Colors.transparent,
                border: _selectedIndex == index
                    ? null
                    : Border.all(
                        color: widget.isDark
                            ? AppColors.darkInputBorder
                            : AppColors.lightInputBorder,
                      ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.sizes[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _selectedIndex == index
                      ? Colors.white
                      : (widget.isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
