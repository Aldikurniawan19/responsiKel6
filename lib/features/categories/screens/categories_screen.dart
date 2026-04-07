import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/category_model.dart';
import '../widgets/category_card_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../products/screens/products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _currentIndex = 1;

  final List<CategoryModel> _categories = [
    CategoryModel(
      title: 'Men T-shirt',
      itemCount: 240,
      backgroundColorValue: 0xFFE6CDB8,
      imageUrl:
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?q=80&w=400',
    ),
    CategoryModel(
      title: 'Jackets',
      itemCount: 140,
      backgroundColorValue: 0xFFF1B7C1,
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
    ),
    CategoryModel(
      title: 'Shoes',
      itemCount: 104,
      backgroundColorValue: 0xFFF0F2F1,
      imageUrl:
          'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?q=80&w=400',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
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
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- BODY ---
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CategoryCardWidget(
            category: _categories[index],
            onShopNowTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsScreen(categoryTitle: _categories[index].title),
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

      // --- BOTTOM NAVIGATION BAR KUSTOM (Sama seperti di Home) ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        elevation: 10,
        shape: const ShapeHexagon(),
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 28,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: isDark ? AppColors.darkBackground : Colors.white,
        elevation: 20,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0, isDark),
              _buildNavItem(
                Icons.category_outlined,
                Icons.category,
                'Categories',
                1,
                isDark,
              ),
              const SizedBox(width: 40),
              _buildNavItem(
                Icons.favorite_border,
                Icons.favorite,
                'Wishlist',
                2,
                isDark,
              ),
              _buildNavItem(
                Icons.person_outline,
                Icons.person,
                'Profile',
                3,
                isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk item nav bawah
  Widget _buildNavItem(
    IconData outlineIcon,
    IconData filledIcon,
    String label,
    int index,
    bool isDark,
  ) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Jika klik Home, kembali ke halaman Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? filledIcon : outlineIcon,
            color: isActive
                ? AppColors.primary
                : (isDark ? AppColors.darkTextBody : AppColors.lightTextBody),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? AppColors.primary
                  : (isDark ? AppColors.darkTextBody : AppColors.lightTextBody),
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
