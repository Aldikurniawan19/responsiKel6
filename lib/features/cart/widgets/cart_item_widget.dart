import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';

// Model khusus untuk item di keranjang
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final bool isDark;
  final VoidCallback onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.isDark,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: widget.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              widget.cartItem.product.imageUrl,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Detail Produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartItem.product.brand ??
                      widget.cartItem.product.category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.cartItem.product.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: widget.isDark
                        ? AppColors.darkTextBody
                        : AppColors.lightTextBody,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Harga
                    Row(
                      children: [
                        Text(
                          '\$${widget.cartItem.product.currentPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${widget.cartItem.product.oldPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isDark
                                ? AppColors.darkOldPriceText
                                : AppColors.lightOldPriceText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    // Tombol Quantity (+ / -)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.isDark
                              ? AppColors.darkInputBorder
                              : AppColors.lightInputBorder,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (widget.cartItem.quantity > 0) {
                                setState(() => widget.cartItem.quantity--);
                                widget.onQuantityChanged();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: widget.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.cartItem.quantity}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() => widget.cartItem.quantity++);
                              widget.onQuantityChanged();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: widget.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
