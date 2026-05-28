import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTextStyles - Centralized text styling for the app
/// Uses Google Fonts for beautiful typography
class AppTextStyles {
  // Private constructor
  AppTextStyles._();

  // Base font family
  static String get _fontFamily => 'Poppins';

  // ============= DISPLAY STYLES (Large Headers) =============
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: color ?? _getTextColor(context),
      height: 1.2,
    );
  }

  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color ?? _getTextColor(context),
      height: 1.2,
    );
  }

  static TextStyle displaySmall(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color ?? _getTextColor(context),
      height: 1.3,
    );
  }

  // ============= HEADLINE STYLES (Section Headers) =============
  static TextStyle headlineLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color ?? _getTextColor(context),
      height: 1.3,
    );
  }

  static TextStyle headlineMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color ?? _getTextColor(context),
      height: 1.3,
    );
  }

  static TextStyle headlineSmall(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? _getTextColor(context),
      height: 1.4,
    );
  }

  // ============= TITLE STYLES (Card Headers, Titles) =============
  static TextStyle titleLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      height: 1.4,
    );
  }

  static TextStyle titleMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      height: 1.4,
    );
  }

  static TextStyle titleSmall(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      height: 1.4,
    );
  }

  // ============= BODY STYLES (Regular Text) =============
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: color ?? _getTextColor(context),
      height: 1.5,
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: color ?? _getTextColor(context),
      height: 1.5,
    );
  }

  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: color ?? _getTextColor(context),
      height: 1.5,
    );
  }

  // ============= LABEL STYLES (Buttons, Tags) =============
  static TextStyle labelLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelSmall(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color ?? _getTextColor(context),
      letterSpacing: 0.5,
    );
  }

  // ============= HELPER METHODS =============
  
  /// Get appropriate text color based on theme
  static Color _getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
  }

  /// Get secondary text color based on theme
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
  }

  /// Get tertiary text color based on theme
  static Color getTertiaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextTertiary
        : AppColors.lightTextTertiary;
  }

  // ============= CUSTOM STYLES =============
  
  /// Button text style
  static TextStyle button(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.white,
      letterSpacing: 0.5,
    );
  }

  /// Caption/hint text style
  static TextStyle caption(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: color ?? getSecondaryTextColor(context),
      height: 1.4,
    );
  }

  /// Link text style
  static TextStyle link(BuildContext context, {Color? color}) {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.primary,
      decoration: TextDecoration.underline,
    );
  }
}

/// Interview Explanation:
/// ----------------------
/// "I've created a comprehensive text style system using Google Fonts:
/// 
/// 1. **Semantic Naming**: Display, Headline, Title, Body, Label
///    - Makes it clear where each style should be used
///    - Following Material Design 3 guidelines
/// 
/// 2. **Theme Awareness**: Automatically adapts to light/dark mode
///    - Uses BuildContext to check current theme
///    - Returns appropriate colors for each theme
/// 
/// 3. **Consistency**: All text in the app uses these styles
///    - No hardcoded font sizes or weights
///    - Easy to maintain and update
/// 
/// 4. **Flexibility**: Can override color when needed
///    - Optional color parameter for special cases
///    - Default colors work for 90% of cases
/// 
/// 5. **Performance**: Google Fonts are cached automatically
///    - No repeated font loading
///    - Smooth text rendering"
