import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/promo_banner_widget.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/trending_carousel_widget.dart';
import '../widgets/app_drawer.dart';
import '../../search/screens/search_screen.dart';
import '../../products/screens/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // --- DRAWER KUSTOM ---
      drawer: const AppDrawer(),

      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
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
              'W3Cart',
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
                LoadingPageRoute(page: const SearchScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- BODY UTAMA ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo (full width, tanpa padding)
            PromoBannerWidget(isDark: isDark),
            const SizedBox(height: 20),

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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        LoadingPageRoute(
                          page: const ProductsScreen(
                            categoryTitle: 'Most Popular',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'See more',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        LoadingPageRoute(
                          page: const ProductsScreen(
                            categoryTitle: 'Trending Now',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'See more',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
    );
  }
}
