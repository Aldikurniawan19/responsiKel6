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
  String _selectedSort = 'Recommended';
  List<String> _selectedBrands = [];
  String _selectedDiscount = '';

  final List<Product> _catalogProducts = [
    Product(
      imageUrl: 'assets/images/4.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Jacket',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'assets/images/4.jpeg',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'High quality pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/5.jpeg',
      category: 'Jacket',
      brand: 'Zara Men',
      title: 'Peter Longline Pure Cotton Leather',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'assets/images/5.jpeg',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M'],
      colors: [0xFF8B4513],
      description: 'Elegant casual leather jacket.',
    ),
    Product(
      imageUrl: 'assets/images/6.jpeg',
      category: 'Jacket',
      brand: 'H&M',
      title: 'Peter Longline Pure Cotton Biker',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'assets/images/6.jpeg',
      ],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M', 'L'],
      colors: [0xFF000000],
      description: 'Classic black biker jacket.',
    ),
    Product(
      imageUrl: 'assets/images/7.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: [
        'assets/images/7.jpeg',
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
          widget.categoryTitle,
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
          // --- HORIZONTAL FILTER BAR ---
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
                    onTap: () => _showSortBottomSheet(isDark),
                  ),
                  _buildFilterChip(
                    'Filter',
                    Icons.filter_alt_outlined,
                    isDark,
                    isGreenIcon: true,
                    onTap: () => _showFilterBottomSheet(isDark),
                  ),
                  _buildFilterChip(
                    'Brand',
                    null,
                    isDark,
                    hasDropdown: true,
                    onTap: () => _showBrandBottomSheet(isDark),
                  ),
                  _buildFilterChip(
                    'Discount',
                    null,
                    isDark,
                    hasDropdown: true,
                    onTap: () => _showDiscountBottomSheet(isDark),
                  ),
                ],
              ),
            ),
          ),

          // --- PRODUCT GRID ---
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

  // --- WIDGET HELPER CHIP
  Widget _buildFilterChip(
    String label,
    IconData? icon,
    bool isDark, {
    bool isGreenIcon = false,
    bool hasDropdown = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  // 1. Bottom Sheet: SORT BY
  void _showSortBottomSheet(bool isDark) {
    final sortOptions = [
      'Recommended',
      'Newest',
      'Price: Low to High',
      'Price: High to Low',
      'Customer Rating',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Sort By',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...sortOptions.map(
                    (option) => RadioListTile<String>(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      value: option,
                      groupValue: _selectedSort,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setModalState(() => _selectedSort = value!);
                        setState(() => _selectedSort = value!);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 2. Bottom Sheet: FILTER (Kompleks: Harga & Ukuran)
  void _showFilterBottomSheet(bool isDark) {
    RangeValues currentRangeValues = const RangeValues(20, 150);

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: currentRangeValues,
                    min: 0,
                    max: 300,
                    activeColor: AppColors.primary,
                    inactiveColor: isDark
                        ? AppColors.darkInputBorder
                        : AppColors.lightInputBorder,
                    labels: RangeLabels(
                      '\$${currentRangeValues.start.round()}',
                      '\$${currentRangeValues.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() => currentRangeValues = values);
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 3. Bottom Sheet: BRAND (Checkboxes)
  void _showBrandBottomSheet(bool isDark) {
    final brands = [
      'Peter England Casual',
      'Zara Men',
      'H&M',
      'Levi\'s',
      'Gucci',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Select Brands',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...brands.map(
                    (brand) => CheckboxListTile(
                      title: Text(
                        brand,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      value: _selectedBrands.contains(brand),
                      activeColor: AppColors.primary,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setModalState(() {
                          if (value == true) {
                            _selectedBrands.add(brand);
                          } else {
                            _selectedBrands.remove(brand);
                          }
                        });
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 4. Bottom Sheet: DISCOUNT (Radio)
  void _showDiscountBottomSheet(bool isDark) {
    final discounts = [
      '10% and above',
      '20% and above',
      '30% and above',
      '50% and above',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...discounts.map(
                    (discount) => RadioListTile<String>(
                      title: Text(
                        discount,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      value: discount,
                      groupValue: _selectedDiscount,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setModalState(() => _selectedDiscount = value!);
                        setState(() => _selectedSort = value!);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
