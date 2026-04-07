import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/catalog_product_card.dart';

class ProductsScreen extends StatefulWidget {
  final String categoryTitle;

  const ProductsScreen({super.key, required this.categoryTitle});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> _catalogProducts = [
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1520975954732-57dd22299614?q=80&w=400',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Jacket',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1520975954732-57dd22299614?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'High quality pure cotton jacket.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Leather',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M'],
      colors: [0xFF8B4513],
      description: 'Elegant casual leather jacket.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Biker',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1603217192634-6116899ff81b?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M', 'L'],
      colors: [0xFF000000],
      description: 'Classic black biker jacket.',
    ),
    Product(
      imageUrl:
          'https://images.unsplash.com/photo-1509631179647-0177331693ae?q=80&w=400',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'https://images.unsplash.com/photo-1509631179647-0177331693ae?q=80&w=400',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
          'Products',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildFilterChip(
                    'Sort By',
                    Icons.tune,
                    isDark,
                    isGreenIcon: true,
                    hasDropdown: true,
                  ),
                  _buildFilterChip(
                    'Filter',
                    Icons.filter_alt_outlined,
                    isDark,
                    isGreenIcon: true,
                  ),
                  _buildFilterChip('Brand', null, isDark, hasDropdown: true),
                  _buildFilterChip('Discount', null, isDark, hasDropdown: true),
                ],
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemCount: _catalogProducts.length,
              itemBuilder: (context, index) {
                return CatalogProductCard(
                  product: _catalogProducts[index],
                  isDark: isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk membuat tombol filter
  Widget _buildFilterChip(
    String label,
    IconData? icon,
    bool isDark, {
    bool isGreenIcon = false,
    bool hasDropdown = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkInputBackground
            : AppColors.lightInputBackground,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDark
              ? AppColors.darkInputBorder
              : AppColors.lightInputBorder,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: isGreenIcon
                  ? AppColors.primary
                  : (isDark ? Colors.white70 : Colors.black87),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasDropdown) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ],
        ],
      ),
    );
  }
}
