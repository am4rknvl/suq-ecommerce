class AppConfig {
  static const String appName = 'Ethiopian SUQ';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.ethiopiansuq.com'; // Replace with actual Go backend URL
  static const String apiVersion = 'v1';
  static const String fullApiUrl = '$baseUrl/api/$apiVersion';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String localeKey = 'locale';
  static const String onboardingKey = 'onboarding_completed';
  static const String cartKey = 'cart_items';
  static const String userRoleKey = 'user_role';
  
  // Gamification
  static const int xpPerPurchase = 10;
  static const int xpPerSale = 15;
  static const int xpPerReview = 5;
  static const int xpPerReferral = 25;
  
  // Level thresholds
  static const Map<int, String> levelTitles = {
    0: 'Newcomer',
    100: 'Explorer',
    250: 'Regular',
    500: 'Enthusiast',
    1000: 'Expert',
    2000: 'Master',
    5000: 'Legend',
  };
  
  // Payment Methods
  static const List<String> supportedPaymentMethods = [
    'telebirr',
    'cbe_birr',
    'cash_on_delivery',
  ];
  
  // App Limits (for low-bandwidth optimization)
  static const int maxImageSize = 2 * 1024 * 1024; // 2MB
  static const int cacheExpiryHours = 24;
  static const int maxCachedProducts = 100;
  
  // Ethiopian specific
  static const String defaultCurrency = 'ETB';
  static const String defaultCountryCode = '+251';
  
  // Social Login (if implemented)
  static const String googleClientId = 'your-google-client-id';
  static const String facebookAppId = 'your-facebook-app-id';
}
