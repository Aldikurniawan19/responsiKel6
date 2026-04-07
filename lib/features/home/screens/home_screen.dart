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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // --- DATA MOCK PRODUK POPULER ---
  // --- DATA MOCK PRODUK POPULER ---
  final List<Product> _products = [
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed Round Neck T-Shirt',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
        'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 2600,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: [0xFF000000, 0xFFADD8E6, 0xFF187C61, 0xFFD3D3D3],
      description:
          'There are many variations of passages of Lorem Ipsum available.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: 'SALE',
      isSale: true,
      isWishlist: true,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      ],
      rating: 4.8,
      reviewCount: 1200,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000, 0xFF808080],
      description: 'Premium quality denim jacket designed for winter wear.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      category: 'Jacket',
      title: 'Women Pink Leather Biker Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      ],
      rating: 4.7,
      reviewCount: 3400,
      sizes: ['S', 'M', 'L'],
      colors: [0xFFFFC0CB, 0xFF000000],
      description: 'Stylish pink leather biker jacket.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=400',
      category: 'T-Shirt',
      title: 'Classic White Basic T-Shirt',
      oldPrice: 15.00,
      currentPrice: 10.00,
      badgeText: 'HOT',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=400',
      ],
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
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 2547,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'Trending winter jacket for men.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      category: 'Jacket',
      title: 'Women Pink Leather Biker Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      ],
      rating: 4.8,
      reviewCount: 3102,
      sizes: ['S', 'M'],
      colors: [0xFFFFC0CB],
      description: 'Highly requested pink leather jacket.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
      ],
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
              const SizedBox(width: 40), // Ruang untuk FAB
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
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
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

class ShapeHexagon extends OutlinedBorder {
  const ShapeHexagon({super.side});

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return ShapeHexagon(side: side ?? this.side);
  }

  @override
  ShapeBorder scale(double t) {
    return ShapeHexagon(side: side.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getHexagonPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getHexagonPath(rect);
  }

  Path _getHexagonPath(Rect rect) {
    final Path path = Path();
    final double centerX = rect.left + rect.width / 2;
    final double centerY = rect.top + rect.height / 2;
    final double radius = rect.width / 2;

    path.moveTo(centerX + radius * 0.866, centerY - radius * 0.5);
    path.lineTo(centerX, centerY - radius);
    path.lineTo(centerX - radius * 0.866, centerY - radius * 0.5);
    path.lineTo(centerX - radius * 0.866, centerY + radius * 0.5);
    path.lineTo(centerX, centerY + radius);
    path.lineTo(centerX + radius * 0.866, centerY + radius * 0.5);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
