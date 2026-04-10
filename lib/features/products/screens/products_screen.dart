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
      imageUrl: 'assets/images/1.jpg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Jacket',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/1.jpg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L', 'XL'],
      colors: [0xFF000000],
      description: 'High quality pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      brand: 'Zara Men',
      title: 'Peter Longline Pure Cotton Leather',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/2.jpg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M'],
      colors: [0xFF8B4513],
      description: 'Elegant casual leather jacket.',
    ),
    Product(
      imageUrl: 'assets/images/3.jpg',
      category: 'Jacket',
      brand: 'H&M',
      title: 'Peter Longline Pure Cotton Biker',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/3.jpg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['S', 'M', 'L'],
      colors: [0xFF000000],
      description: 'Classic black biker jacket.',
    ),
    Product(
      imageUrl: 'assets/images/4.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/4.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/5.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/5.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/6.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/6.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
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
      thumbnailImages: ['assets/images/7.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/8.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/8.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/9.jpeg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/9.jpeg'],
      rating: 4.5,
      reviewCount: 265,
      sizes: ['M', 'L'],
      colors: [0xFFD2B48C],
      description: 'Tan colored pure cotton jacket.',
    ),
    Product(
      imageUrl: 'assets/images/2.jpg',
      category: 'Jacket',
      brand: 'Peter England Casual',
      title: 'Peter Longline Pure Cotton Tan',
      oldPrice: 255.11,
      currentPrice: 151.15,
      badgeText: '',
      isSale: false,
      isWishlist: false,
      thumbnailImages: ['assets/images/2.jpg'],
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
    final activeFilterCount =
        (_selectedBrands.isNotEmpty ? 1 : 0) +
        (_selectedDiscount.isNotEmpty ? 1 : 0) +
        (_selectedSort != 'Recommended' ? 1 : 0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              '${_catalogProducts.length} Products Found',
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.darkTextBody
                    : AppColors.lightTextBody,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // --- FILTER BAR ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBackground : Colors.white,
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
                  _buildIconChip(
                    Icons.tune,
                    isDark,
                    badge: activeFilterCount > 0 ? activeFilterCount : null,
                    onTap: () => _showFilterBottomSheet(isDark),
                  ),
                  const SizedBox(width: 8),
                  _buildChip(
                    _selectedSort == 'Recommended' ? 'Sort By' : _selectedSort,
                    isDark,
                    isActive: _selectedSort != 'Recommended',
                    hasDropdown: true,
                    onTap: () => _showSortBottomSheet(isDark),
                  ),
                  _buildChip(
                    _selectedBrands.isEmpty
                        ? 'Brand'
                        : '${_selectedBrands.length} Brand',
                    isDark,
                    isActive: _selectedBrands.isNotEmpty,
                    hasDropdown: true,
                    onTap: () => _showBrandBottomSheet(isDark),
                  ),
                  _buildChip(
                    _selectedDiscount.isEmpty ? 'Discount' : _selectedDiscount,
                    isDark,
                    isActive: _selectedDiscount.isNotEmpty,
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

  // --- ICON CHIP ---
  Widget _buildIconChip(
    IconData icon,
    bool isDark, {
    int? badge,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: badge != null
              ? AppColors.primary.withOpacity(0.1)
              : (isDark
                    ? AppColors.darkInputBackground
                    : AppColors.lightInputBackground),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: badge != null
                ? AppColors.primary
                : (isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            if (badge != null)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- FILTER CHIP ---
  Widget _buildChip(
    String label,
    bool isDark, {
    bool isActive = false,
    bool hasDropdown = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : (isDark
                    ? AppColors.darkInputBackground
                    : AppColors.lightInputBackground),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : (isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isActive
                    ? AppColors.primary
                    : (isDark ? Colors.white : Colors.black87),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: isActive
                    ? AppColors.primary
                    : (isDark ? Colors.white70 : Colors.black54),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 1. SORT BY
  void _showSortBottomSheet(bool isDark) {
    final sortOptions = [
      {'label': 'Recommended', 'icon': Icons.recommend_outlined},
      {'label': 'Newest', 'icon': Icons.new_releases_outlined},
      {'label': 'Price: Low to High', 'icon': Icons.arrow_upward},
      {'label': 'Price: High to Low', 'icon': Icons.arrow_downward},
      {'label': 'Customer Rating', 'icon': Icons.star_outline},
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...sortOptions.map((o) {
              final l = o['label'] as String;
              final i = o['icon'] as IconData;
              final s = _selectedSort == l;
              return ListTile(
                leading: Icon(
                  i,
                  color: s
                      ? AppColors.primary
                      : (isDark ? Colors.white54 : Colors.black38),
                  size: 22,
                ),
                title: Text(
                  l,
                  style: TextStyle(
                    color: s
                        ? AppColors.primary
                        : (isDark ? Colors.white : Colors.black),
                    fontWeight: s ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: s
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 22,
                      )
                    : null,
                onTap: () {
                  setState(() => _selectedSort = l);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  // 2. FILTER (Price & Size)
  void _showFilterBottomSheet(bool isDark) {
    RangeValues range = const RangeValues(20, 150);
    List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
    List<String> sel = [];
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, ss) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkInputBorder
                        : AppColors.lightInputBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  TextButton(
                    onPressed: () => ss(() {
                      range = const RangeValues(0, 300);
                      sel.clear();
                    }),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${range.start.round()} - \$${range.end.round()}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RangeSlider(
                values: range,
                min: 0,
                max: 300,
                divisions: 30,
                activeColor: AppColors.primary,
                inactiveColor: isDark
                    ? AppColors.darkInputBorder
                    : AppColors.lightInputBorder,
                onChanged: (v) => ss(() => range = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$0',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                    ),
                  ),
                  Text(
                    '\$300',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Size',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: sizes.map((s) {
                  final a = sel.contains(s);
                  return GestureDetector(
                    onTap: () => ss(() {
                      a ? sel.remove(s) : sel.add(s);
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: a
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.darkInputBackground
                                  : AppColors.lightInputBackground),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: a
                              ? AppColors.primary
                              : (isDark
                                    ? AppColors.darkInputBorder
                                    : AppColors.lightInputBorder),
                        ),
                      ),
                      child: Text(
                        s,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: a
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.black87),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
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
        ),
      ),
    );
  }

  // 3. BRAND
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
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, ss) => Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkInputBorder
                        : AppColors.lightInputBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Brands',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    if (_selectedBrands.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          ss(() => _selectedBrands.clear());
                          setState(() {});
                        },
                        child: Text(
                          '${_selectedBrands.length} selected',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ...brands.map((b) {
                final a = _selectedBrands.contains(b);
                return CheckboxListTile(
                  title: Text(
                    b,
                    style: TextStyle(
                      color: a
                          ? AppColors.primary
                          : (isDark ? Colors.white : Colors.black),
                      fontWeight: a ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  value: a,
                  activeColor: AppColors.primary,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (v) {
                    ss(() {
                      v == true
                          ? _selectedBrands.add(b)
                          : _selectedBrands.remove(b);
                    });
                    setState(() {});
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // 4. DISCOUNT
  void _showDiscountBottomSheet(bool isDark) {
    final discounts = [
      {'label': '10% and above', 'icon': Icons.local_offer_outlined},
      {'label': '20% and above', 'icon': Icons.local_offer_outlined},
      {'label': '30% and above', 'icon': Icons.local_offer_outlined},
      {'label': '50% and above', 'icon': Icons.local_fire_department_outlined},
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Discount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...discounts.map((d) {
              final l = d['label'] as String;
              final i = d['icon'] as IconData;
              final s = _selectedDiscount == l;
              return ListTile(
                leading: Icon(
                  i,
                  color: s
                      ? AppColors.primary
                      : (isDark ? Colors.white54 : Colors.black38),
                  size: 22,
                ),
                title: Text(
                  l,
                  style: TextStyle(
                    color: s
                        ? AppColors.primary
                        : (isDark ? Colors.white : Colors.black),
                    fontWeight: s ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: s
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 22,
                      )
                    : null,
                onTap: () {
                  setState(() => _selectedDiscount = l);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
