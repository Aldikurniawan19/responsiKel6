import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../../home/widgets/product_card_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../cart/screens/cart_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
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

class _WishlistScreenState extends State<WishlistScreen> {
  int _currentIndex = 2;

  // --- DATA MOCK PRODUK WISHLIST ---
  final List<Product> _wishlistProducts = [
    Product(
      imageUrl: 'assets/images/1.jpg',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed Round Neck...',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'assets/images/1.jpg',
      ],
      rating: 4.5,
      reviewCount: 2600,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'Casual printed t-shirt.',
    ),
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 25.13,
      currentPrice: 18.50,
      badgeText: 'SALE',
      isSale: true,
      isWishlist: true,
      thumbnailImages: [
        'assets/images/2.jpg',
      ],
      rating: 4.8,
      reviewCount: 1200,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000, 0xFF808080],
      description: 'Premium quality denim jacket designed for winter wear.',
    ),
    Product(
      imageUrl: 'assets/images/3.jpg',
      category: 'Jacket',
      title: 'Women Pink Leather Biker Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'assets/images/3.jpg',
      ],
      rating: 4.7,
      reviewCount: 3400,
      sizes: ['S', 'M', 'L'],
      colors: [0xFFFFC0CB, 0xFF000000],
      description: 'Stylish pink leather biker jacket.',
    ),
    Product(
      imageUrl: 'assets/images/1.jpg',
      category: 'Jacket',
      title: 'Peter Longline Pure Cotton Jacket',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'assets/images/1.jpg',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'High quality pure cotton jacket.',
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
          'Wishlist',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),

      // --- BODY (GRID PRODUK) ---
      body: GridView.builder(
        padding: const EdgeInsets.all(24.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.58,
        ),
        itemCount: _wishlistProducts.length,
        itemBuilder: (context, index) {
          return ProductCardWidget(
            product: _wishlistProducts[index],
            isDark: isDark,
          );
        },
      ),

      // --- BOTTOM NAVIGATION BAR ---
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
