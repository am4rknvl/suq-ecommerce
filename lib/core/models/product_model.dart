import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String currency;
  final List<String> imageUrls;
  final String category;
  final List<String> tags;
  final ProductStatus status;
  final int stockQuantity;
  final int? minOrderQuantity;
  final int? maxOrderQuantity;
  final String sellerId;
  final String sellerName;
  final String? sellerShopName;
  final double? weight;
  final ProductDimensions? dimensions;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Rating and reviews
  final double averageRating;
  final int reviewsCount;
  final List<ProductReview>? reviews;
  

  final String? sellerCity;
  final String? sellerRegion;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.currency,
    required this.imageUrls,
    required this.category,
    required this.tags,
    required this.status,
    required this.stockQuantity,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    required this.sellerId,
    required this.sellerName,
    this.sellerShopName,
    this.weight,
    this.dimensions,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    required this.reviewsCount,
    this.reviews,
    this.sellerCity,
    this.sellerRegion,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  bool get isOnSale => originalPrice != null && originalPrice! > price;
  
  double get discountPercentage {
    if (!isOnSale) return 0.0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }
  
  bool get isInStock => stockQuantity > 0;
  
  bool get isLowStock => stockQuantity <= 5 && stockQuantity > 0;
  
  String get mainImageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';
  
  String get displaySellerName => sellerShopName ?? sellerName;
  
  String get formattedPrice => '$currency ${price.toStringAsFixed(2)}';
  
  String? get formattedOriginalPrice => 
      originalPrice != null ? '$currency ${originalPrice!.toStringAsFixed(2)}' : null;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? currency,
    List<String>? imageUrls,
    String? category,
    List<String>? tags,
    ProductStatus? status,
    int? stockQuantity,
    int? minOrderQuantity,
    int? maxOrderQuantity,
    String? sellerId,
    String? sellerName,
    String? sellerShopName,
    double? weight,
    ProductDimensions? dimensions,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? averageRating,
    int? reviewsCount,
    List<ProductReview>? reviews,
    String? sellerCity,
    String? sellerRegion,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      currency: currency ?? this.currency,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
      maxOrderQuantity: maxOrderQuantity ?? this.maxOrderQuantity,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerShopName: sellerShopName ?? this.sellerShopName,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      averageRating: averageRating ?? this.averageRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      reviews: reviews ?? this.reviews,
      sellerCity: sellerCity ?? this.sellerCity,
      sellerRegion: sellerRegion ?? this.sellerRegion,
    );
  }
}

@JsonSerializable()
class ProductDimensions {
  final double length;
  final double width;
  final double height;
  final String unit; // cm, inch, etc.

  const ProductDimensions({
    required this.length,
    required this.width,
    required this.height,
    required this.unit,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) => 
      _$ProductDimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDimensionsToJson(this);

  String get formatted => '${length}x${width}x$height $unit';
}

@JsonSerializable()
class ProductReview {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final double rating;
  final String? comment;
  final List<String>? imageUrls;
  final DateTime createdAt;
  final bool isVerifiedPurchase;

  const ProductReview({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatarUrl,
    required this.rating,
    this.comment,
    this.imageUrls,
    required this.createdAt,
    required this.isVerifiedPurchase,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) => 
      _$ProductReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}

@JsonSerializable()
class CartItem {
  final String productId;
  final Product product;
  final int quantity;
  final DateTime addedAt;
  final String? selectedVariant; // For future use (size, color, etc.)

  const CartItem({
    required this.productId,
    required this.product,
    required this.quantity,
    required this.addedAt,
    this.selectedVariant,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  double get totalPrice => product.price * quantity;
  
  String get formattedTotalPrice => 
      '${product.currency} ${totalPrice.toStringAsFixed(2)}';

  CartItem copyWith({
    String? productId,
    Product? product,
    int? quantity,
    DateTime? addedAt,
    String? selectedVariant,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      selectedVariant: selectedVariant ?? this.selectedVariant,
    );
  }
}

enum ProductStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('out_of_stock')
  outOfStock,
  @JsonValue('discontinued')
  discontinued,
}
