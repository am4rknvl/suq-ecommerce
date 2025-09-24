import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String? phoneNumber;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Gamification fields
  final int xp;
  final int level;
  final List<String> badges;
  final UserStats stats;
  
  // Seller specific fields (nullable for buyers)
  final SellerProfile? sellerProfile;

  const User({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.xp,
    required this.level,
    required this.badges,
    required this.stats,
    this.sellerProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get fullName => '$firstName $lastName';
  
  String get displayName => fullName.trim().isEmpty ? email : fullName;
  
  bool get isSeller => role == UserRole.seller || role == UserRole.both;
  
  bool get isBuyer => role == UserRole.buyer || role == UserRole.both;

  User copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? xp,
    int? level,
    List<String>? badges,
    UserStats? stats,
    SellerProfile? sellerProfile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      badges: badges ?? this.badges,
      stats: stats ?? this.stats,
      sellerProfile: sellerProfile ?? this.sellerProfile,
    );
  }
}

@JsonSerializable()
class UserStats {
  final int totalOrders;
  final int totalSales;
  final double totalSpent;
  final double totalEarned;
  final double averageRating;
  final int reviewsCount;
  final int referralsCount;

  const UserStats({
    required this.totalOrders,
    required this.totalSales,
    required this.totalSpent,
    required this.totalEarned,
    required this.averageRating,
    required this.reviewsCount,
    required this.referralsCount,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatsToJson(this);

  factory UserStats.empty() => const UserStats(
    totalOrders: 0,
    totalSales: 0,
    totalSpent: 0.0,
    totalEarned: 0.0,
    averageRating: 0.0,
    reviewsCount: 0,
    referralsCount: 0,
  );
}

@JsonSerializable()
class SellerProfile {
  final String shopName;
  final String? shopDescription;
  final String? shopLogoUrl;
  final List<String> categories;
  final Address? address;
  final bool isVerified;
  final DateTime? verifiedAt;
  final SellerStats stats;

  const SellerProfile({
    required this.shopName,
    this.shopDescription,
    this.shopLogoUrl,
    required this.categories,
    this.address,
    required this.isVerified,
    this.verifiedAt,
    required this.stats,
  });

  factory SellerProfile.fromJson(Map<String, dynamic> json) => _$SellerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SellerProfileToJson(this);
}

@JsonSerializable()
class SellerStats {
  final int totalProducts;
  final int activeProducts;
  final int totalOrders;
  final int completedOrders;
  final double totalRevenue;
  final double averageRating;
  final int reviewsCount;
  final DateTime? lastSale;

  const SellerStats({
    required this.totalProducts,
    required this.activeProducts,
    required this.totalOrders,
    required this.completedOrders,
    required this.totalRevenue,
    required this.averageRating,
    required this.reviewsCount,
    this.lastSale,
  });

  factory SellerStats.fromJson(Map<String, dynamic> json) => _$SellerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$SellerStatsToJson(this);

  factory SellerStats.empty() => const SellerStats(
    totalProducts: 0,
    activeProducts: 0,
    totalOrders: 0,
    completedOrders: 0,
    totalRevenue: 0.0,
    averageRating: 0.0,
    reviewsCount: 0,
  );
}

@JsonSerializable()
class Address {
  final String street;
  final String city;
  final String region;
  final String? postalCode;
  final String country;
  final double? latitude;
  final double? longitude;

  const Address({
    required this.street,
    required this.city,
    required this.region,
    this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String get fullAddress => '$street, $city, $region, $country';
}

enum UserRole {
  @JsonValue('buyer')
  buyer,
  @JsonValue('seller')
  seller,
  @JsonValue('both')
  both,
}
