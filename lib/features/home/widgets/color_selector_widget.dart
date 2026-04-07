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
  int _selectedIndex = 0; // Default terpilih index 0 (Hitam)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.colorARGBs.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            width: 32, // Ukuran lingkaran semirip mungkin
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(
                widget.colorARGBs[index],
              ), // Ambil warna dari data int
              // Border putih sebagai penanda jika terpilih
              border: _selectedIndex == index
                  ? Border.all(
                      color: Colors.white,
                      width: 2,
                    ) // Border putih penanda
                  : Border.all(
                      color: Colors.transparent,
                      width: 2,
                    ), // Tidak ada border jika tidak terpilih
            ),
            // Tampilan lingkaran dalam yang solid
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(widget.colorARGBs[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
