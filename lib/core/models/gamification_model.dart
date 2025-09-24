import 'package:json_annotation/json_annotation.dart';

part 'gamification_model.g.dart';

@JsonSerializable()
class Badge {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final BadgeType type;
  final BadgeRarity rarity;
  final int requiredValue;
  final String? requiredAction;
  final DateTime? unlockedAt;
  final bool isUnlocked;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.type,
    required this.rarity,
    required this.requiredValue,
    this.requiredAction,
    this.unlockedAt,
    required this.isUnlocked,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  Badge copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    BadgeType? type,
    BadgeRarity? rarity,
    int? requiredValue,
    String? requiredAction,
    DateTime? unlockedAt,
    bool? isUnlocked,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      type: type ?? this.type,
      rarity: rarity ?? this.rarity,
      requiredValue: requiredValue ?? this.requiredValue,
      requiredAction: requiredAction ?? this.requiredAction,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

@JsonSerializable()
class UserLevel {
  final int level;
  final String title;
  final int currentXP;
  final int requiredXP;
  final int totalXP;
  final List<String> perks;
  final String? iconUrl;

  const UserLevel({
    required this.level,
    required this.title,
    required this.currentXP,
    required this.requiredXP,
    required this.totalXP,
    required this.perks,
    this.iconUrl,
  });

  factory UserLevel.fromJson(Map<String, dynamic> json) => _$UserLevelFromJson(json);
  Map<String, dynamic> toJson() => _$UserLevelToJson(this);

  double get progress => currentXP / requiredXP;
  
  int get xpToNextLevel => requiredXP - currentXP;
  
  bool get isMaxLevel => requiredXP == 0; // Max level has no next level requirement

  UserLevel copyWith({
    int? level,
    String? title,
    int? currentXP,
    int? requiredXP,
    int? totalXP,
    List<String>? perks,
    String? iconUrl,
  }) {
    return UserLevel(
      level: level ?? this.level,
      title: title ?? this.title,
      currentXP: currentXP ?? this.currentXP,
      requiredXP: requiredXP ?? this.requiredXP,
      totalXP: totalXP ?? this.totalXP,
      perks: perks ?? this.perks,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }
}

@JsonSerializable()
class Achievement {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final String? badgeId;
  final AchievementType type;
  final DateTime unlockedAt;
  final bool isNew;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    this.badgeId,
    required this.type,
    required this.unlockedAt,
    required this.isNew,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}

@JsonSerializable()
class XPTransaction {
  final String id;
  final int amount;
  final XPSource source;
  final String description;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  const XPTransaction({
    required this.id,
    required this.amount,
    required this.source,
    required this.description,
    required this.createdAt,
    this.metadata,
  });

  factory XPTransaction.fromJson(Map<String, dynamic> json) => _$XPTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$XPTransactionToJson(this);
}

@JsonSerializable()
class Leaderboard {
  final String id;
  final String name;
  final LeaderboardType type;
  final LeaderboardPeriod period;
  final List<LeaderboardEntry> entries;
  final DateTime updatedAt;

  const Leaderboard({
    required this.id,
    required this.name,
    required this.type,
    required this.period,
    required this.entries,
    required this.updatedAt,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}

@JsonSerializable()
class LeaderboardEntry {
  final int rank;
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final int score;
  final int level;
  final List<String> topBadges;

  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.userName,
    this.userAvatarUrl,
    required this.score,
    required this.level,
    required this.topBadges,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardEntryToJson(this);
}

enum BadgeType {
  @JsonValue('purchase')
  purchase,
  @JsonValue('sales')
  sales,
  @JsonValue('social')
  social,
  @JsonValue('milestone')
  milestone,
  @JsonValue('special')
  special,
  @JsonValue('seasonal')
  seasonal,
}

enum BadgeRarity {
  @JsonValue('common')
  common,
  @JsonValue('uncommon')
  uncommon,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary,
}

enum AchievementType {
  @JsonValue('badge_unlock')
  badgeUnlock,
  @JsonValue('level_up')
  levelUp,
  @JsonValue('milestone')
  milestone,
  @JsonValue('special_event')
  specialEvent,
}

enum XPSource {
  @JsonValue('purchase')
  purchase,
  @JsonValue('sale')
  sale,
  @JsonValue('review')
  review,
  @JsonValue('referral')
  referral,
  @JsonValue('daily_login')
  dailyLogin,
  @JsonValue('profile_completion')
  profileCompletion,
  @JsonValue('first_purchase')
  firstPurchase,
  @JsonValue('first_sale')
  firstSale,
  @JsonValue('bonus')
  bonus,
}

enum LeaderboardType {
  @JsonValue('xp')
  xp,
  @JsonValue('sales')
  sales,
  @JsonValue('purchases')
  purchases,
  @JsonValue('reviews')
  reviews,
}

enum LeaderboardPeriod {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('all_time')
  allTime,
}

// Predefined badges for the Ethiopian e-commerce platform
class PredefinedBadges {
  static const List<Badge> buyerBadges = [
    Badge(
      id: 'first_order',
      name: 'First Order',
      description: 'Completed your first order',
      iconUrl: 'assets/badges/first_order.png',
      type: BadgeType.milestone,
      rarity: BadgeRarity.common,
      requiredValue: 1,
      requiredAction: 'complete_order',
      isUnlocked: false,
    ),
    Badge(
      id: 'big_spender',
      name: 'Big Spender',
      description: 'Spent over 1000 ETB',
      iconUrl: 'assets/badges/big_spender.png',
      type: BadgeType.purchase,
      rarity: BadgeRarity.uncommon,
      requiredValue: 1000,
      requiredAction: 'total_spent',
      isUnlocked: false,
    ),
    Badge(
      id: 'repeat_buyer',
      name: 'Repeat Buyer',
      description: 'Completed 10 orders',
      iconUrl: 'assets/badges/repeat_buyer.png',
      type: BadgeType.milestone,
      rarity: BadgeRarity.rare,
      requiredValue: 10,
      requiredAction: 'total_orders',
      isUnlocked: false,
    ),
    Badge(
      id: 'reviewer',
      name: 'Helpful Reviewer',
      description: 'Left 5 product reviews',
      iconUrl: 'assets/badges/reviewer.png',
      type: BadgeType.social,
      rarity: BadgeRarity.uncommon,
      requiredValue: 5,
      requiredAction: 'reviews_count',
      isUnlocked: false,
    ),
  ];

  static const List<Badge> sellerBadges = [
    Badge(
      id: 'first_sale',
      name: 'First Sale',
      description: 'Made your first sale',
      iconUrl: 'assets/badges/first_sale.png',
      type: BadgeType.milestone,
      rarity: BadgeRarity.common,
      requiredValue: 1,
      requiredAction: 'total_sales',
      isUnlocked: false,
    ),
    Badge(
      id: 'trusted_seller',
      name: 'Trusted Seller',
      description: 'Maintained 4.5+ rating with 20+ reviews',
      iconUrl: 'assets/badges/trusted_seller.png',
      type: BadgeType.sales,
      rarity: BadgeRarity.epic,
      requiredValue: 20,
      requiredAction: 'high_rating_sales',
      isUnlocked: false,
    ),
    Badge(
      id: 'top_seller',
      name: 'Top Seller',
      description: 'Completed 100 sales',
      iconUrl: 'assets/badges/top_seller.png',
      type: BadgeType.sales,
      rarity: BadgeRarity.legendary,
      requiredValue: 100,
      requiredAction: 'total_sales',
      isUnlocked: false,
    ),
    Badge(
      id: 'consistent_seller',
      name: 'Consistent Seller',
      description: 'Made sales for 30 consecutive days',
      iconUrl: 'assets/badges/consistent_seller.png',
      type: BadgeType.special,
      rarity: BadgeRarity.rare,
      requiredValue: 30,
      requiredAction: 'consecutive_sales_days',
      isUnlocked: false,
    ),
  ];
}
