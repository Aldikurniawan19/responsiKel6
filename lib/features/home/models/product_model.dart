class Product {
  final String imageUrl;
  final String category;
  final String title;
  final double oldPrice;
  final double currentPrice;
  final String badgeText;
  final bool isSale;
  final bool isWishlist;
  final double? rating;
  final int? reviewCount;

  Product({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.oldPrice,
    required this.currentPrice,
    required this.badgeText,
    required this.isSale,
    required this.isWishlist,
    this.rating,
    this.reviewCount,
  });
}
