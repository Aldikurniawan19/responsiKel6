import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';

class TrendingCardWidget extends StatelessWidget {
  final Product product;
  final bool isDark;

  Widget _buildImage(String imageUrl) {
    final isLocal = imageUrl.startsWith('assets/');

    if (isLocal) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade100,
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey,
        ),
      ),
    );
  }

  const TrendingCardWidget({
    super.key,
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                _buildImage(product.imageUrl),

                if (product.rating != null && product.reviewCount != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating} | ${product.reviewCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          product.category,
          style: TextStyle(
            color: isDark ? AppColors.darkTextBody : AppColors.lightTextBody,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
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
        const SizedBox(height: 6),
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
    );
  }
}
