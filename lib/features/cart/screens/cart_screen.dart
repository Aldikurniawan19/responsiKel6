import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // --- STATE UNTUK KUPON ---
  final TextEditingController _couponController = TextEditingController();
  double _discountAmount = 0.0;
  bool _isCouponApplied = false;
  String _appliedCouponCode = '';

  // Data Mock Keranjang Belanja
  final List<CartItem> _cartItems = [
    CartItem(
      quantity: 1,
      product: Product(
        imageUrl:
            'assets/images/1.jpg',
        category: 'Tshirt',
        brand: 'Peter England Casual',
        title: 'Peter Longline Pure Cotten Tshirt',
        oldPrice: 200.10,
        currentPrice: 158.15,
        badgeText: '',
        isSale: false,
        isWishlist: false,
        thumbnailImages: [],
        rating: 4.5,
        reviewCount: 0,
        sizes: [],
        colors: [],
        description: '',
      ),
    ),
    CartItem(
      quantity: 1,
      product: Product(
        imageUrl:
            'assets/images/1.jpg',
        category: 'Tshirt',
        brand: 'Peter England Casual',
        title: 'Peter Longline Pure Cotten Tshirt',
        oldPrice: 200.10,
        currentPrice: 158.15,
        badgeText: '',
        isSale: false,
        isWishlist: false,
        thumbnailImages: [],
        rating: 4.5,
        reviewCount: 0,
        sizes: [],
        colors: [],
        description: '',
      ),
    ),
    CartItem(
      quantity: 1,
      product: Product(
        imageUrl:
            'assets/images/1.jpg',
        category: 'Tshirt',
        brand: 'Peter England Casual',
        title: 'Peter Longline Pure Cotten Tshirt',
        oldPrice: 200.10,
        currentPrice: 158.15,
        badgeText: '',
        isSale: false,
        isWishlist: false,
        thumbnailImages: [],
        rating: 4.5,
        reviewCount: 0,
        sizes: [],
        colors: [],
        description: '',
      ),
    ),
  ];

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  // --- LOGIKA PERHITUNGAN HARGA ---
  double get _subtotal {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.product.currentPrice * item.quantity),
    );
  }

  double get _tax => _subtotal * 0.005; // Pajak 0.5% (Sesuai gambar)
  double get _deliveryFee => _subtotal * 0.008; // Ongkir 0.8% (Sesuai gambar)

  double get _totalPrice {
    double total = _subtotal + _tax + _deliveryFee - _discountAmount;
    return total > 0 ? total : 0; // Memastikan total tidak minus
  }

  // --- FUNGSI CEK KUPON ---
  void _applyCoupon() {
    // Hilangkan keyboard saat tombol di-klik
    FocusScope.of(context).unfocus();

    final code = _couponController.text.trim().toUpperCase();

    if (code.isEmpty) return;

    setState(() {
      if (code == 'PROMO20') {
        _isCouponApplied = true;
        _appliedCouponCode = code;
        _discountAmount = _subtotal * 0.20; // Diskon 20%
        _showSnackBar('Coupon Applied! You got 20% off.', Colors.green);
      } else if (code == 'HEMAT50') {
        _isCouponApplied = true;
        _appliedCouponCode = code;
        _discountAmount = 50.0; // Potongan langsung $50
        _showSnackBar('Coupon Applied! You got \$50 off.', Colors.green);
      } else {
        _isCouponApplied = false;
        _discountAmount = 0.0;
        _showSnackBar('Invalid coupon code.', Colors.red);
      }
    });
  }

  void _removeCoupon() {
    setState(() {
      _isCouponApplied = false;
      _appliedCouponCode = '';
      _discountAmount = 0.0;
      _couponController.clear();
      _showSnackBar('Coupon removed.', Colors.grey);
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. DELIVERY HEADER ---
                  Container(
                    color: isDark
                        ? AppColors.darkCardBackground
                        : const Color(0xFFF0FDF4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage(
                            'assets/images/profil.png',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Delivery to Tushar',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Ram krishan, puram',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),

                  // --- 2. DAFTAR ITEM KERANJANG ---
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: _cartItems
                          .map(
                            (item) => CartItemWidget(
                              cartItem: item,
                              isDark: isDark,
                              onQuantityChanged: () {
                                setState(() {
                                  // Update nominal diskon jika kupon persen sedang aktif dan kuantitas barang berubah
                                  if (_isCouponApplied &&
                                      _appliedCouponCode == 'PROMO20') {
                                    _discountAmount = _subtotal * 0.20;
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  // --- 3. COUPON SECTION (Kini Berupa Form Input) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have a coupon code ? enter here',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextBody
                                : Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // TextField untuk Kupon
                        TextField(
                          controller: _couponController,
                          enabled:
                              !_isCouponApplied, // Kunci input jika kupon sudah terpasang
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Your Offer Code',
                            hintStyle: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextBody
                                  : Colors.black38,
                            ),
                            prefixIcon: const Icon(
                              Icons.content_cut,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            suffixIcon: _isCouponApplied
                                ? IconButton(
                                    // Tombol hapus kupon
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: _removeCoupon,
                                  )
                                : IconButton(
                                    // Tombol terapkan kupon
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: _applyCoupon,
                                  ),
                            filled: true,
                            fillColor: isDark
                                ? AppColors.darkInputBackground
                                : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: isDark
                                    ? AppColors.darkInputBorder
                                    : Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: isDark
                                    ? AppColors.darkInputBorder
                                    : Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- 4. PRICE DETAILS ---
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildPriceRow(
                          'Price :',
                          '\$${_subtotal.toStringAsFixed(2)}',
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildPriceRow(
                          'Tax :',
                          '\$${_tax.toStringAsFixed(2)}',
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildPriceRow(
                          'Delivery Fee :',
                          '\$${_deliveryFee.toStringAsFixed(2)}',
                          isDark,
                        ),

                        // Menampilkan baris diskon jika kupon aktif
                        if (_isCouponApplied) ...[
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount ($_appliedCouponCode) :',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '-\$${_discountAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 24),
                        const Divider(height: 1),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total :',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark
                                    ? AppColors.darkTextBody
                                    : Colors.black54,
                              ),
                            ),
                            Text(
                              '\$${_totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 5. BOTTOM CHECKOUT BAR ---
          Container(
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
                        '\$${_totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'View price details',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 54,
                    width: 140,
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
                        'Checkout',
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
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? AppColors.darkTextBody : Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
