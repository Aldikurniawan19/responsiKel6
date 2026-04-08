import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../../home/widgets/product_card_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../profile/screens/profile_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _currentIndex = 2;

  // --- DATA MOCK PRODUK WISHLIST ---
  final List<Product> _wishlistProducts = [
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
      category: 'T-Shirt',
      title: 'Men Black Grey Allover Printed Round Neck...',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 2600,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'Casual printed t-shirt.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 25.13,
      currentPrice: 18.50,
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
          'https://images.unsplash.com/photo-1520975954732-57dd22299614?q=80&w=400',
      category: 'Jacket',
      title: 'Peter Longline Pure Cotton Jacket',
      oldPrice: 30.15,
      currentPrice: 25.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: true,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1520975954732-57dd22299614?q=80&w=400',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: isDark ? AppColors.primary : Colors.black,
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
        color: isDark ? AppColors.darkCardBackground : Colors.white,
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
