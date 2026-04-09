import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/category_model.dart';
import '../widgets/category_card_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../products/screens/products_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../cart/screens/cart_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// Custom Hexagon Shape yang rounded
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
      (i) => (i * 60 - 90) * (3.141592653589793 / 180),
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

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _currentIndex = 1;

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
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl: 'assets/images/6.jpeg',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl: 'assets/images/7.jpeg',
    ),
    CategoryModel(
      title: 'Sunglasses',
      itemCount: 100,
      backgroundColorValue: 0xFFB8F2ED,
      imageUrl: 'assets/images/8.jpeg',
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
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 16), // Turunkan posisi
        child: Container(
          width: 72,
          height: 72,
          decoration: ShapeDecoration(
            color: isDark ? AppColors.primary : Colors.black,
            shape: const RoundedHexagonBorder(),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const RoundedHexagonBorder(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),

      // BottomAppBar tanpa notch agar navbar tetap solid dan FAB benar-benar di depan
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBackground : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  Icons.home_outlined,
                  Icons.home,
                  'Home',
                  0,
                  isDark,
                ),
                _buildNavItem(
                  Icons.grid_view_outlined,
                  Icons.grid_view,
                  'Categories',
                  1,
                  isDark,
                ),
                const SizedBox(width: 56), // Ruang tengah untuk FAB
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
      ),
    );
  }

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
        if (index == 0 && _currentIndex != 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 1 && _currentIndex != 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
          );
        } else if (index == 2 && _currentIndex != 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        } else if (index == 3 && _currentIndex != 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
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
