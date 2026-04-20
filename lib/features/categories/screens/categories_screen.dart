import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../models/category_model.dart';
import '../widgets/category_card_widget.dart';
import '../../search/screens/search_screen.dart';
import '../../../screens/main_screen.dart';
import '../../products/screens/products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<CategoryModel> _categories = [
    CategoryModel(
      title: 'Men T-shirt',
      itemCount: 240,
      backgroundColorValue: 0xFFE6CDB8,
      imageUrl: 'assets/images/1.jpg',
    ),
    CategoryModel(
      title: 'Jackets',
      itemCount: 140,
      backgroundColorValue: 0xFFF1B7C1,
      imageUrl: 'assets/images/2.jpg',
    ),
    CategoryModel(
      title: 'Shoes',
      itemCount: 104,
      backgroundColorValue: 0xFFF0F2F1,
      imageUrl: 'assets/images/4.jpeg',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl: 'assets/images/5.jpeg',
    ),
    CategoryModel(
      title: 'Accessories',
      itemCount: 85,
      backgroundColorValue: 0xFFF5E6CC,
      imageUrl: 'assets/images/6.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            MainScreen.mainKey.currentState?.switchTab(0);
          },
        ),
        title: Text(
          'All Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                LoadingPageRoute(page: const SearchScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CategoryCardWidget(
            category: _categories[index],
            onShopNowTap: () {
              Navigator.push(
                context,
                LoadingPageRoute(
                  page: ProductsScreen(categoryTitle: _categories[index].title),
                ),
              );

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Menuju halaman koleksi ${_categories[index].title}...',
                  ),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
