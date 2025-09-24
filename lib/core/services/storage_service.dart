import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class StorageService {
  static late Box _box;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    // Initialize Hive boxes
    _box = await Hive.openBox('app_data');
    
    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic methods for Hive storage
  static Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  static T? get<T>(String key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  static Future<void> delete(String key) async {
    await _box.delete(key);
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  // Authentication related storage
  static Future<void> saveAuthToken(String token) async {
    await _prefs.setString(AppConfig.authTokenKey, token);
  }

  static String? getAuthToken() {
    return _prefs.getString(AppConfig.authTokenKey);
  }

  static Future<void> clearAuthToken() async {
    await _prefs.remove(AppConfig.authTokenKey);
  }

  static bool get isLoggedIn => getAuthToken() != null;

  // User data storage
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await put(AppConfig.userDataKey, userData);
  }

  static Map<String, dynamic>? getUserData() {
    return get<Map<String, dynamic>>(AppConfig.userDataKey);
  }

  static Future<void> clearUserData() async {
    await delete(AppConfig.userDataKey);
  }

  // Cart storage
  static Future<void> saveCartItems(List<Map<String, dynamic>> cartItems) async {
    await put(AppConfig.cartKey, cartItems);
  }

  static List<Map<String, dynamic>> getCartItems() {
    final items = get<List>(AppConfig.cartKey, defaultValue: []);
    return items?.cast<Map<String, dynamic>>() ?? [];
  }

  static Future<void> clearCart() async {
    await delete(AppConfig.cartKey);
  }

  // User role storage
  static Future<void> saveUserRole(String role) async {
    await _prefs.setString(AppConfig.userRoleKey, role);
  }

  static String getUserRole() {
    return _prefs.getString(AppConfig.userRoleKey) ?? 'buyer';
  }

  // Onboarding status
  static Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(AppConfig.onboardingKey, true);
  }

  static bool isOnboardingCompleted() {
    return _prefs.getBool(AppConfig.onboardingKey) ?? false;
  }

  // Cache management for offline support
  static Future<void> cacheProducts(List<Map<String, dynamic>> products) async {
    await put('cached_products', products);
    await put('cache_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static List<Map<String, dynamic>>? getCachedProducts() {
    final cacheTimestamp = get<int>('cache_timestamp');
    if (cacheTimestamp != null) {
      final cacheAge = DateTime.now().millisecondsSinceEpoch - cacheTimestamp;
      final maxAge = AppConfig.cacheExpiryHours * 60 * 60 * 1000; // Convert to milliseconds
      
      if (cacheAge < maxAge) {
        final products = get<List>('cached_products');
        return products?.cast<Map<String, dynamic>>();
      }
    }
    return null;
  }

  // Gamification data storage
  static Future<void> saveUserXP(int xp) async {
    await put('user_xp', xp);
  }

  static int getUserXP() {
    return get<int>('user_xp', defaultValue: 0) ?? 0;
  }

  static Future<void> saveBadges(List<String> badges) async {
    await put('user_badges', badges);
  }

  static List<String> getUserBadges() {
    final badges = get<List>('user_badges', defaultValue: []);
    return badges?.cast<String>() ?? [];
  }

  static Future<void> addBadge(String badgeId) async {
    final currentBadges = getUserBadges();
    if (!currentBadges.contains(badgeId)) {
      currentBadges.add(badgeId);
      await saveBadges(currentBadges);
    }
  }

  // Settings storage
  static Future<void> saveSetting(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else {
      await _prefs.setString(key, jsonEncode(value));
    }
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    if (T == String) {
      return _prefs.getString(key) as T? ?? defaultValue;
    } else if (T == bool) {
      return _prefs.getBool(key) as T? ?? defaultValue;
    } else if (T == int) {
      return _prefs.getInt(key) as T? ?? defaultValue;
    } else if (T == double) {
      return _prefs.getDouble(key) as T? ?? defaultValue;
    } else {
      final stringValue = _prefs.getString(key);
      if (stringValue != null) {
        try {
          return jsonDecode(stringValue) as T;
        } catch (e) {
          return defaultValue;
        }
      }
      return defaultValue;
    }
  }
}
