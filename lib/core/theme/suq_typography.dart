import 'package:flutter/material.dart';

/// SUQ Design System Typography
/// Modern typography system with Inter and Poppins fonts
/// Optimized for both English and Amharic text
class SuqTypography {
  // Font Families
  static const String primaryFont = 'Inter'; // For body text and UI
  static const String headingFont = 'Poppins'; // For headings and emphasis
  static const String monospaceFont = 'JetBrains Mono'; // For codes and prices
  
  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  
  /// Build complete text theme for the app
  static TextTheme buildTextTheme(Color baseColor) {
    return TextTheme(
      // Display Styles (Poppins)
      displayLarge: TextStyle(
        fontFamily: headingFont,
        fontSize: 57,
        height: 64 / 57,
        fontWeight: bold,
        color: baseColor,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: headingFont,
        fontSize: 45,
        height: 52 / 45,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontFamily: headingFont,
        fontSize: 36,
        height: 44 / 36,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0,
      ),
      
      // Headline Styles (Poppins)
      headlineLarge: TextStyle(
        fontFamily: headingFont,
        fontSize: 32,
        height: 40 / 32,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        fontFamily: headingFont,
        fontSize: 28,
        height: 36 / 28,
        fontWeight: medium,
        color: baseColor,
        letterSpacing: 0,
      ),
      headlineSmall: TextStyle(
        fontFamily: headingFont,
        fontSize: 24,
        height: 32 / 24,
        fontWeight: medium,
        color: baseColor,
        letterSpacing: 0,
      ),
      
      // Title Styles (Inter)
      titleLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 22,
        height: 28 / 22,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: semiBold,
        color: baseColor,
        letterSpacing: 0.1,
      ),
      
      // Body Styles (Inter)
      bodyLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: regular,
        color: baseColor,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: regular,
        color: baseColor,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: regular,
        color: baseColor.withOpacity(0.7),
        letterSpacing: 0.4,
      ),
      
      // Label Styles (Inter)
      labelLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: medium,
        color: baseColor,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: medium,
        color: baseColor,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 11,
        height: 16 / 11,
        fontWeight: medium,
        color: baseColor.withOpacity(0.7),
        letterSpacing: 0.5,
      ),
    );
  }
  
  // Custom text styles for specific use cases
  
  /// Price text style (using monospace for better alignment)
  static TextStyle priceStyle({
    required Color color,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontFamily: monospaceFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0,
    );
  }
  
  /// Button text style
  static TextStyle buttonStyle({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.1,
    );
  }
  
  /// Caption style for small descriptive text
  static TextStyle captionStyle({
    required Color color,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color.withOpacity(0.6),
      letterSpacing: 0.4,
    );
  }
  
  /// Overline style for categories and tags
  static TextStyle overlineStyle({
    required Color color,
    double fontSize = 10,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 1.5,
    );
  }
}
