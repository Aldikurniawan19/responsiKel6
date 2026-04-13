import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/order_model.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;
  final bool isDark;

  const OrderCardWidget({super.key, required this.order, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Menentukan warna berdasarkan status pesanan
    Color badgeColor;
    Color badgeTextColor;

    if (order.status == 'Completed') {
      badgeColor = const Color(0xFFE8F5E9); // Hijau sangat muda
      badgeTextColor = const Color(0xFF4CAF50); // Hijau
    } else if (order.status == 'Canceled') {
      badgeColor = const Color(0xFFFFEBEE); // Merah sangat muda
      badgeTextColor = const Color(0xFFE53935); // Merah
    } else {
      // On Delivery
      badgeColor = const Color(0xFFF3E5F5); // Ungu sangat muda
      badgeTextColor = const Color(0xFFAB47BC); // Ungu
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isDark
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
          // --- KOLOM KIRI (Detail Teks) ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID
                Text(
                  order.id,
                  style: const TextStyle(
                    color: Color(0xFF8E24AA),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ), // Warna ungu ID
                ),
                const SizedBox(height: 6),
                // Judul Produk
                Text(
                  order.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Baris Variant, Qty, dan Harga
                Row(
                  children: [
                    Text(
                      order.variant,
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextBody : Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${order.quantity}x',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      '\$${order.price.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Baris Status Badge dan Deskripsi
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        order.statusDescription,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextBody
                              : Colors.black54,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // --- KOLOM KANAN (Gambar Produk) ---
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              order.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
