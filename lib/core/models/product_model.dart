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

  final List<String> thumbnailImages; // Daftar gambar thumbnail
  final List<String> sizes; // Daftar ukuran: ['S', 'M', 'L', 'XL']
  final List<int> colors; // Daftar warna (ARGB int): [0xFF000000, ...]
  final String description;

  Product({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.oldPrice,
    required this.currentPrice,
    required this.badgeText,
    required this.thumbnailImages,
    required this.sizes,
    required this.colors,
    required this.description,
    required this.isSale,
    required this.isWishlist,
    this.rating,
    this.reviewCount,
  });
}
