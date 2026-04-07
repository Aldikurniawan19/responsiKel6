import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
// --- IMPORT MODEL GLOBAL BARU ---
import '../../../core/models/product_model.dart';
// --- IMPORT HALAMAN DETAIL ---
import '../screens/product_detail_screen.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final bool isDark;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // --- GESTURE DETECTOR UNTUK KLIK KE DETAIL PRODUK ---
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCardBackground
              : AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(4),
          boxShadow: isDark
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
            // --- 1. AREA GAMBAR & LENCANA ---
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
                      product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // Lencana Sale/Diskon (Hanya muncul jika teksnya ada)
                    if (product.badgeText.isNotEmpty)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.isSale
                                ? AppColors.primary
                                : Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            product.badgeText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Tombol Wishlist
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isWishlist
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isWishlist ? Colors.red : Colors.green,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- 2. AREA DETAIL TEKS ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.category,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkTextBody
                            : AppColors.lightTextBody,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const Spacer(),

                    // Harga
                    Row(
                      children: [
                        Text(
                          '\$${product.currentPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${product.oldPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isDark
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
