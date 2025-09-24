// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      type: $enumDecode(_$BadgeTypeEnumMap, json['type']),
      rarity: $enumDecode(_$BadgeRarityEnumMap, json['rarity']),
      requiredValue: (json['requiredValue'] as num).toInt(),
      requiredAction: json['requiredAction'] as String?,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
      isUnlocked: json['isUnlocked'] as bool,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'type': _$BadgeTypeEnumMap[instance.type]!,
      'rarity': _$BadgeRarityEnumMap[instance.rarity]!,
      'requiredValue': instance.requiredValue,
      'requiredAction': instance.requiredAction,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'isUnlocked': instance.isUnlocked,
    };

const _$BadgeTypeEnumMap = {
  BadgeType.purchase: 'purchase',
  BadgeType.sales: 'sales',
  BadgeType.social: 'social',
  BadgeType.milestone: 'milestone',
  BadgeType.special: 'special',
  BadgeType.seasonal: 'seasonal',
};

const _$BadgeRarityEnumMap = {
  BadgeRarity.common: 'common',
  BadgeRarity.uncommon: 'uncommon',
  BadgeRarity.rare: 'rare',
  BadgeRarity.epic: 'epic',
  BadgeRarity.legendary: 'legendary',
};

UserLevel _$UserLevelFromJson(Map<String, dynamic> json) => UserLevel(
      level: (json['level'] as num).toInt(),
      title: json['title'] as String,
      currentXP: (json['currentXP'] as num).toInt(),
      requiredXP: (json['requiredXP'] as num).toInt(),
      totalXP: (json['totalXP'] as num).toInt(),
      perks: (json['perks'] as List<dynamic>).map((e) => e as String).toList(),
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$UserLevelToJson(UserLevel instance) => <String, dynamic>{
      'level': instance.level,
      'title': instance.title,
      'currentXP': instance.currentXP,
      'requiredXP': instance.requiredXP,
      'totalXP': instance.totalXP,
      'perks': instance.perks,
      'iconUrl': instance.iconUrl,
    };

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      xpReward: (json['xpReward'] as num).toInt(),
      badgeId: json['badgeId'] as String?,
      type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      isNew: json['isNew'] as bool,
    );

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'xpReward': instance.xpReward,
      'badgeId': instance.badgeId,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'isNew': instance.isNew,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.badgeUnlock: 'badge_unlock',
  AchievementType.levelUp: 'level_up',
  AchievementType.milestone: 'milestone',
  AchievementType.specialEvent: 'special_event',
};

XPTransaction _$XPTransactionFromJson(Map<String, dynamic> json) =>
    XPTransaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      source: $enumDecode(_$XPSourceEnumMap, json['source']),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$XPTransactionToJson(XPTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'source': _$XPSourceEnumMap[instance.source]!,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$XPSourceEnumMap = {
  XPSource.purchase: 'purchase',
  XPSource.sale: 'sale',
  XPSource.review: 'review',
  XPSource.referral: 'referral',
  XPSource.dailyLogin: 'daily_login',
  XPSource.profileCompletion: 'profile_completion',
  XPSource.firstPurchase: 'first_purchase',
  XPSource.firstSale: 'first_sale',
  XPSource.bonus: 'bonus',
};

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$LeaderboardTypeEnumMap, json['type']),
      period: $enumDecode(_$LeaderboardPeriodEnumMap, json['period']),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$LeaderboardTypeEnumMap[instance.type]!,
      'period': _$LeaderboardPeriodEnumMap[instance.period]!,
      'entries': instance.entries,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$LeaderboardTypeEnumMap = {
  LeaderboardType.xp: 'xp',
  LeaderboardType.sales: 'sales',
  LeaderboardType.purchases: 'purchases',
  LeaderboardType.reviews: 'reviews',
};

const _$LeaderboardPeriodEnumMap = {
  LeaderboardPeriod.daily: 'daily',
  LeaderboardPeriod.weekly: 'weekly',
  LeaderboardPeriod.monthly: 'monthly',
  LeaderboardPeriod.allTime: 'all_time',
};

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    LeaderboardEntry(
      rank: (json['rank'] as num).toInt(),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatarUrl: json['userAvatarUrl'] as String?,
      score: (json['score'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      topBadges:
          (json['topBadges'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LeaderboardEntryToJson(LeaderboardEntry instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatarUrl': instance.userAvatarUrl,
      'score': instance.score,
      'level': instance.level,
      'topBadges': instance.topBadges,
    };
