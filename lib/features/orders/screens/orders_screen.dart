import 'package:flutter/material.dart';
import 'package:hotdie/core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../models/order_model.dart';
import '../widgets/order_card_widget.dart';
import '../../search/screens/search_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Data Mock Order (Disamakan persis dengan gambar)
  final List<OrderModel> _allOrders = [
    OrderModel(
      id: '#12451245',
      title: 'Brown Women Shirts by Coklat Cloth',
      variant: 'GREY Variant',
      quantity: 1,
      price: 47.6,
      status: 'Completed',
      statusDescription: 'Order Received by [Louis Simatupang]',
      imageUrl: 'assets/images/1.jpg',
    ),
    OrderModel(
      id: '#12451245',
      title: 'Women Sleep Suits by Femall Clothings',
      variant: 'GREY Variant',
      quantity: 2,
      price: 47.6,
      status: 'Canceled',
      statusDescription: 'Reach on payment due date',
      imageUrl: 'assets/images/2.jpg',
    ),
    OrderModel(
      id: '#12451245',
      title: 'Red Candy Handy Bag with Random Accessories',
      variant: 'GREY Variant',
      quantity: 1,
      price: 50.6,
      status: 'On Delivery',
      statusDescription: 'On the way by Courir [H. Stefanus]',
      imageUrl: 'assets/images/3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 4, // Jumlah Tab
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : const Color(0xFFF8F9FA),
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
            'Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  LoadingPageRoute(page: const SearchScreen()),
                );
              },
            ),
          ],
          // --- KONFIGURASI TAB BAR ---
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: isDark
                ? AppColors.darkTextBody
                : Colors.black54,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'On Delivery'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        // --- ISI DARI SETIAP TAB ---
        body: TabBarView(
          children: [
            _buildOrderList(_allOrders, isDark), // Tab "All"
            _buildOrderList(
              _allOrders.where((o) => o.status == 'On Delivery').toList(),
              isDark,
            ),
            _buildOrderList(
              _allOrders.where((o) => o.status == 'Completed').toList(),
              isDark,
            ),
            _buildOrderList(
              _allOrders.where((o) => o.status == 'Canceled').toList(),
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membangun list pesanan
  Widget _buildOrderList(List<OrderModel> orders, bool isDark) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders found.',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCardWidget(order: orders[index], isDark: isDark);
      },
    );
  }
}
