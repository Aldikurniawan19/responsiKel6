import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../../home/widgets/product_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _recentSearches = [
    'Jacket',
    'T-Shirt Men',
    'Leather',
    'Pink',
  ];

  final List<Product> _allProducts = [
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      title: 'Men Black Denim Winter Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: 'SALE',
      isSale: true,
      isWishlist: true,
      thumbnailImages: ['assets/images/2.jpg'],
      rating: 4.8,
      reviewCount: 1200,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000, 0xFF808080],
      description: 'Premium quality denim jacket.',
    ),
    Product(
      imageUrl: 'assets/images/3.jpg',
      category: 'Jacket',
      title: 'Women Pink Leather Biker Jacket',
      oldPrice: 40.55,
      currentPrice: 20.15,
      badgeText: '32% off',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/3.jpg'],
      rating: 4.7,
      reviewCount: 3400,
      sizes: ['S', 'M', 'L'],
      colors: [0xFFFFC0CB, 0xFF000000],
      description: 'Stylish pink leather biker jacket.',
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
      rating: 4.5,
      reviewCount: 2600,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: [0xFF000000, 0xFFADD8E6],
      description: 'Casual printed t-shirt.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredProducts = _allProducts.where((product) {
      final queryLower = _searchQuery.toLowerCase();
      return product.title.toLowerCase().contains(queryLower) ||
          product.category.toLowerCase().contains(queryLower);
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(
                          color: isDark
                              ? AppColors.darkTextBody
                              : AppColors.lightTextBody,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDark
                              ? AppColors.darkTextBody
                              : AppColors.lightTextBody,
                          size: 20,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: isDark
                                      ? AppColors.darkTextBody
                                      : AppColors.lightTextBody,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: isDark
                            ? AppColors.darkInputBackground
                            : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _searchQuery.isEmpty
                  ? _buildRecentSearches(isDark)
                  : _buildSearchResults(filteredProducts, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Clear all',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _recentSearches.map((term) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = term;
                  setState(() {
                    _searchQuery = term;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBackground : Colors.white,
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkInputBorder
                          : AppColors.lightInputBorder,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    term,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Product> products, bool isDark) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          'No products found for "$_searchQuery"',
          style: TextStyle(
            color: isDark ? AppColors.darkTextBody : AppColors.lightTextBody,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(24.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.58,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(product: products[index], isDark: isDark);
      },
    );
  }
}
