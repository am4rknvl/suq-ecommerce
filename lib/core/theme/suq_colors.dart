import 'package:flutter/material.dart';

/// SUQ Design System Colors
/// Modern, culturally-relevant color palette for African marketplace
class SuqColors {
  // Primary Colors - Ethiopian sunset inspired
  static const Color primary = Color(0xFFE67E22); // Warm Orange
  static const Color primaryDark = Color(0xFFD35400); // Deeper orange for hover
  static const Color primaryLight =
      Color(0xFFF39C12); // Lighter orange for backgrounds

  // Secondary Colors - Ethiopian green (prosperity)
  static const Color secondary = Color(0xFF27AE60); // Ethiopian green
  static const Color secondaryDark = Color(0xFF229954);
  static const Color secondaryLight = Color(0xFF58D68D);

  // Accent & Support Colors
  static const Color accent = Color(0xFF8E44AD); // Royal purple - premium feel
  static const Color success = Color(0xFF27AE60); // Green
  static const Color warning = Color(0xFFF39C12); // Amber
  static const Color error = Color(0xFFE74C3C); // Red
  static const Color info = Color(0xFF3498DB); // Blue

  // Light Mode Neutrals
  static const Color backgroundLight = Color(0xFFFEFEFE); // Pure white
  static const Color surfaceLight = Color(0xFFF8F9FA); // Light gray
  static const Color surfaceVariantLight = Color(0xFFE9ECEF);
  static const Color onSurfaceLight = Color(0xFF212529); // Dark gray
  static const Color onSurfaceVariantLight = Color(0xFF6C757D); // Medium gray
  static const Color outlineLight = Color(0xFFDEE2E6);

  // Dark Mode Colors
  static const Color primaryDarkMode =
      Color(0xFFFF8C42); // Brighter orange for dark
  static const Color primaryDarkModeDark = Color(0xFFE67E22);
  static const Color primaryDarkModeLight = Color(0xFFFFB366);

  static const Color secondaryDarkMode = Color(0xFF2ECC71); // Brighter green
  static const Color secondaryDarkModeDark = Color(0xFF27AE60);
  static const Color secondaryDarkModeLight = Color(0xFF58D68D);

  // Dark Mode Neutrals
  static const Color backgroundDark = Color(0xFF121212); // True dark
  static const Color surfaceDark = Color(0xFF1E1E1E); // Elevated dark
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);
  static const Color onSurfaceDark = Color(0xFFFFFFFF); // White text
  static const Color onSurfaceVariantDark = Color(0xFFB0B0B0); // Light gray
  static const Color outlineDark = Color(0xFF404040);

  // Special Colors
  static const Color gold = Color(0xFFFFD700); // For ratings
  static const Color transparent = Colors.transparent;

  // Badge Colors
  static const Color badgeNew = success;
  static const Color badgeSale = error;
  static const Color badgeOutOfStock = Color(0xFF9E9E9E);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.3);

  static var mediumGrey;

  /// Get color scheme for light mode
  static ColorScheme get lightColorScheme => ColorScheme.light(
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryLight,
        onPrimaryContainer: onSurfaceLight,
        secondary: secondary,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLight,
        onSecondaryContainer: onSurfaceLight,
        tertiary: accent,
        onTertiary: Colors.white,
        error: error,
        onError: Colors.white,
        surface: surfaceLight,
        onSurface: onSurfaceLight,
        surfaceContainerHighest: surfaceVariantLight,
        onSurfaceVariant: onSurfaceVariantLight,
        outline: outlineLight,
        shadow: shadowLight,
      );

  /// Get color scheme for dark mode
  static ColorScheme get darkColorScheme => ColorScheme.dark(
        primary: primaryDarkMode,
        onPrimary: Colors.black,
        primaryContainer: primaryDarkModeDark,
        onPrimaryContainer: onSurfaceDark,
        secondary: secondaryDarkMode,
        onSecondary: Colors.black,
        secondaryContainer: secondaryDarkModeDark,
        onSecondaryContainer: onSurfaceDark,
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        surfaceContainerHighest: surfaceVariantDark,
        onSurfaceVariant: onSurfaceVariantDark,
        shadow: shadowDark,
      );
}
