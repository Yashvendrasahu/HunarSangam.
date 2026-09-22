// lib/models/product_model.dart

class ProductModel {
  final String id;
  final String artisanId;
  final String title;
  final String description;
  final double price;
  final String? originalPrice;
  final String category;
  final List<String> imageUrls;
  final int minOrderQuantity;
  final int stockQuantity;
  final String dimensions;
  final String leadTime;
  final bool isFeatured;
  final bool isPublished;
  final double rating;
  final int reviewsCount;

  // Convenience getters for UI compatibility
  String get name => title;
  int get stock => stockQuantity;
  String get primaryImageUrl => imageUrls.isNotEmpty ? imageUrls.first : 'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80';
  String get craftType => category;

  const ProductModel({
    required this.id,
    this.artisanId = 'art_1',
    required this.title,
    this.description = '',
    required this.price,
    this.originalPrice,
    required this.category,
    this.imageUrls = const ['https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80'],
    this.minOrderQuantity = 10,
    this.stockQuantity = 50,
    this.dimensions = '12" x 8" x 6"',
    this.leadTime = '7-10 days',
    this.isFeatured = false,
    this.isPublished = true,
    this.rating = 4.8,
    this.reviewsCount = 18,
  });

  ProductModel copyWith({
    String? id,
    String? artisanId,
    String? title,
    String? description,
    double? price,
    String? originalPrice,
    String? category,
    List<String>? imageUrls,
    int? minOrderQuantity,
    int? stockQuantity,
    String? dimensions,
    String? leadTime,
    bool? isFeatured,
    bool? isPublished,
    double? rating,
    int? reviewsCount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      artisanId: artisanId ?? this.artisanId,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      category: category ?? this.category,
      imageUrls: imageUrls ?? this.imageUrls,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      dimensions: dimensions ?? this.dimensions,
      leadTime: leadTime ?? this.leadTime,
      isFeatured: isFeatured ?? this.isFeatured,
      isPublished: isPublished ?? this.isPublished,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
    );
  }
}
