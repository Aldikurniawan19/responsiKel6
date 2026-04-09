import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../../home/widgets/product_card_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
        automaticallyImplyLeading: false,
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
    );
  }
}
