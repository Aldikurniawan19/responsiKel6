class OrderModel {
  final String id;
  final String title;
  final String variant;
  final int quantity;
  final double price;
  final String status;
  final String statusDescription;
  final String imageUrl;

  OrderModel({
    required this.id,
    required this.title,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.status,
    required this.statusDescription,
    required this.imageUrl,
  });
}
