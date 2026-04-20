import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../screens/product_detail_screen.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  final bool isDark;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.isDark,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late bool _isWishlist;

  Widget _buildImage(String imageUrl) {
    final isLocal = imageUrl.startsWith('assets/');

    if (isLocal) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imagePlaceholder(),
      );
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: widget.isDark ? Colors.grey.shade800 : Colors.grey.shade100,
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }

  @override
  void initState() {
    super.initState();
    _isWishlist = widget.product.isWishlist;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          LoadingPageRoute(page: ProductDetailScreen(product: widget.product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.darkCardBackground
              : AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: widget.isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: _buildImage(widget.product.imageUrl),
                  ),

                  if (widget.product.badgeText.isNotEmpty)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.product.isSale
                              ? AppColors.primary
                              : Colors.black87,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          widget.product.badgeText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isWishlist = !_isWishlist;
                        });
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isWishlist
                                  ? 'Added to Wishlist!'
                                  : 'Removed from Wishlist',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: AppColors.primary,
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        _isWishlist ? Icons.favorite : Icons.favorite_border,
                        color: _isWishlist
                            ? Colors.redAccent
                            : AppColors.primary,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori
                    Text(
                      widget.product.category,
                      style: TextStyle(
                        color: widget.isDark
                            ? AppColors.darkTextBody
                            : AppColors.lightTextBody,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Judul
                    Expanded(
                      child: Text(
                        widget.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.isDark ? Colors.white : Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          '\$${widget.product.currentPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '\$${widget.product.oldPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: widget.isDark
                                ? AppColors.darkOldPriceText
                                : AppColors.lightOldPriceText,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
