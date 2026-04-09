// lib/features/home/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
// Import Google Fonts DIHAPUS untuk menghilangkan warning unused_import
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/size_selector_widget.dart';
import '../widgets/color_selector_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentThumbnailIndex = 0;
  bool _isWishlist = false;

  @override
  void initState() {
    super.initState();
    _isWishlist = widget.product.isWishlist;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product Detail',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isWishlist
                  ? Colors.red
                  : (isDark ? Colors.white : Colors.black),
            ),
            onPressed: () {
              setState(() {
                _isWishlist = !_isWishlist;
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama (Cek apakah list kosong untuk mencegah error)
            if (widget.product.thumbnailImages.isNotEmpty)
              Image.asset(
                widget.product.thumbnailImages[_currentThumbnailIndex],
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            // Thumbnail Slider
            if (widget.product.thumbnailImages.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.product.thumbnailImages.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentThumbnailIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: AssetImage(
                              widget.product.thumbnailImages[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: _currentThumbnailIndex == index
                              ? Border.all(color: AppColors.primary, width: 2)
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),

            // Area Detail Teks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.category,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          // --- PERBAIKAN NULL SAFETY RATING ---
                          Text(
                            widget.product.rating?.toString() ?? '0.0',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          // --- PERBAIKAN NULL SAFETY REVIEW COUNT ---
                          Text(
                            '(${((widget.product.reviewCount ?? 0) / 1000).toStringAsFixed(1)}k review)',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextBody
                                  : AppColors.lightTextBody,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Divider(
                    color: isDark
                        ? AppColors.darkInputBorder
                        : AppColors.lightInputBorder,
                    height: 1,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Size:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  SizeSelectorWidget(
                    sizes: widget.product.sizes,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Color:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ColorSelectorWidget(
                    colorARGBs: widget.product.colors,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.darkInputBorder
                  : AppColors.lightInputBorder,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.product.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add Cart',
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
}
