import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/promo_banner_widget.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/trending_carousel_widget.dart';
import '../widgets/app_drawer.dart';
import '../../search/screens/search_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../cart/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // --- DATA MOCK PRODUK POPULER ---
  final List<Product> _products = [
    Product(
      imageUrl: 'assets/images/1.jpg',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed Round Neck T-Shirt',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'assets/images/1.jpg',
        'assets/images/1.jpg',
        'assets/images/1.jpg',
      ],
      rating: 4.5,
      reviewCount: 2600,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: [0xFF000000, 0xFFADD8E6, 0xFF187C61, 0xFFD3D3D3],
      description:
          'There are many variations of passages of Lorem Ipsum available.',
    ),
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: 'SALE',
      isSale: true,
      isWishlist: true,
      thumbnailImages: [
        'assets/images/2.jpg',
        'assets/images/2.jpg',
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
        'assets/images/3.jpg',
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
      category: 'T-Shirt',
      title: 'Classic White Basic T-Shirt',
      oldPrice: 15.00,
      currentPrice: 10.00,
      badgeText: 'HOT',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/1.jpg'],
      rating: 4.9,
      reviewCount: 8900,
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: [0xFFFFFFFF, 0xFF000000],
      description: 'A wardrobe essential.',
    ),
  ];

  // --- DATA MOCK PRODUK TRENDING ---
  final List<Product> _trendingProducts = [
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/2.jpg'],
      rating: 4.5,
      reviewCount: 2547,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'Trending winter jacket for men.',
    ),
    Product(
      imageUrl: 'assets/images/3.jpg',
      category: 'Jacket',
      title: 'Women Pink Leather Biker Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/3.jpg'],
      rating: 4.8,
      reviewCount: 3102,
      sizes: ['S', 'M'],
      colors: [0xFFFFC0CB],
      description: 'Highly requested pink leather jacket.',
    ),
    Product(
      imageUrl: 'assets/images/1.jpg',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/1.jpg'],
      rating: 4.3,
      reviewCount: 1540,
      sizes: ['M', 'L'],
      colors: [0xFF000000],
      description: 'Casual printed t-shirt.',
    ),
  ];

  // --- DATA MOCK PRODUK TRENDING ---

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // --- DRAWER KUSTOM ---
      drawer: const AppDrawer(),

      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ), // Warna Icon Menu
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'HotDiee',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
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

      // --- BODY UTAMA ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PromoBannerWidget(isDark: isDark),
            ),
            const SizedBox(height: 30),

            // Tabs Kategori
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: CategoryTabsWidget(isDark: isDark),
            ),
            const SizedBox(height: 30),

            // Most Popular Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const Text(
                    'See more',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Grid Produk Popular
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.58, // Mengatasi Bottom Overflowed
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ProductCardWidget(
                    product: _products[index],
                    isDark: isDark,
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Trending Now Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const Text(
                    'See more',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Trending Carousel
            TrendingCarouselWidget(products: _trendingProducts, isDark: isDark),
          ],
        ),
      ),

      // --- BOTTOM NAVIGATION BAR KUSTOM ---
      // FAB dengan hexagon rounded yang muncul di depan navbar
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
          // --- TAMBAHAN NAVIGASI KE PROFILE ---
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
