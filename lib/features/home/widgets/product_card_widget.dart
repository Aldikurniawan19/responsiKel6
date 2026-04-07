import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../screens/product_detail_screen.dart';

// --- 1. UBAH MENJADI STATEFUL WIDGET ---
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
  // Variabel state lokal untuk melacak status wishlist kartu ini
  late bool _isWishlist;

  @override
  void initState() {
    super.initState();
    // Set status awal berdasarkan data produk dari database/mock data
    _isWishlist = widget.product.isWishlist;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.darkCardBackground
              : AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(4),
          boxShadow: widget.isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      widget.product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    if (widget.product.badgeText.isNotEmpty)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.product.isSale
                                ? AppColors.primary
                                : Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            widget.product.badgeText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // --- 2. TOMBOL WISHLIST YANG SUDAH BERFUNGSI ---
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          // Ubah state _isWishlist saat tombol diklik
                          setState(() {
                            _isWishlist = !_isWishlist;
                          });

                          // Munculkan notifikasi pop-up kecil
                          ScaffoldMessenger.of(
                            context,
                          ).clearSnackBars(); // Bersihkan snackbar sebelumnya agar tidak menumpuk
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isWishlist
                                    ? 'Added to Wishlist!'
                                    : 'Removed from Wishlist',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.primary,
                              duration: const Duration(
                                seconds: 1,
                              ), // Tampil sangat cepat
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            // Ubah ikon berdasarkan state _isWishlist
                            _isWishlist
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isWishlist ? Colors.red : Colors.green,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.category,
                      style: TextStyle(
                        color: widget.isDark
                            ? AppColors.darkTextBody
                            : AppColors.lightTextBody,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: widget.isDark ? Colors.white : Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const Spacer(),

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
                        const SizedBox(width: 8),
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
