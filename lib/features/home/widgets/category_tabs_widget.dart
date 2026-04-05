import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CategoryTabsWidget extends StatefulWidget {
  final bool isDark;

  const CategoryTabsWidget({super.key, required this.isDark});

  @override
  State<CategoryTabsWidget> createState() => _CategoryTabsWidgetState();
}

class _CategoryTabsWidgetState extends State<CategoryTabsWidget> {
  final List<String> categories = [
    'All',
    'Men',
    'T-Shirt',
    'Women',
    'Kids',
    'Shoes',
    'Winter',
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == categories.length - 1 ? 24 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? (widget.isDark
                          ? AppColors.primary
                          : AppColors.lightTabBackground)
                    : (widget.isDark
                          ? AppColors.darkTabBackground
                          : Colors.white),
                borderRadius: BorderRadius.circular(4),
                border: selectedIndex == index
                    ? null
                    : Border.all(
                        color: widget.isDark
                            ? AppColors.darkInputBorder
                            : AppColors.lightInputBorder,
                      ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: selectedIndex == index
                      ? (widget.isDark ? Colors.white : AppColors.primary)
                      : (widget.isDark
                            ? Colors.white
                            : AppColors.lightTextTitle),
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
