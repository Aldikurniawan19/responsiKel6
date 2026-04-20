import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final List<Map<String, String>> _coupons = [
    {
      'discount': '20%',
      'category': 'Home Decor',
      'condition': 'On minimum purchase of Rs. 1,999',
    },
    {
      'discount': '50%',
      'category': 'Home Furnishing',
      'condition': 'On minimum purchase of Rs. 3,999',
    },
    {
      'discount': '25%',
      'category': 'Mobile Accessories',
      'condition': 'On minimum purchase of Rs. 999',
    },
  ];

  final List<String> _promoBanners = [
    'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?q=80&w=600',
    'https://images.unsplash.com/photo-1607082350899-7e105ca886e1?q=80&w=600',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Coupons',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._coupons.map((coupon) => _buildCouponCard(coupon, isDark)),

            const SizedBox(height: 30),

            Text(
              'Discount on your sale',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _promoBanners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(_promoBanners[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(Map<String, String> coupon, bool isDark) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  coupon['discount']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  'Off',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkTextBody : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: _buildDashedLine(isDark),
          ),

          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon['category']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.darkTextBody : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coupon['condition']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        12,
        (index) => Container(
          width: 1.5,
          height: 4,
          color: isDark ? AppColors.darkInputBorder : Colors.grey.shade300,
        ),
      ),
    );
  }
}
