import 'package:flutter/material.dart';

/// AppColors - Centralized color management for the app
/// This ensures consistency across the app and makes theme changes easy
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============= PRIMARY COLORS =============
  /// Main brand color - used for primary actions, buttons, etc.
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4D46CC);

  // ============= SECONDARY COLORS =============
  /// Accent color - used for highlights and secondary actions
  static const Color secondary = Color(0xFFFF6584);
  static const Color secondaryLight = Color(0xFFFF99AE);
  static const Color secondaryDark = Color(0xFFCC4D6A);

  // ============= SUCCESS/ERROR/WARNING COLORS =============
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // ============= LIGHT THEME COLORS =============
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);

  // Text colors for light theme
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextTertiary = Color(0xFFBDBDBD);

  // Border and divider colors for light theme
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightDivider = Color(0xFFEEEEEE);

  // ============= DARK THEME COLORS =============
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);

  // Text colors for dark theme
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF808080);

  // Border and divider colors for dark theme
  static const Color darkBorder = Color(0xFF3A3A3A);
  static const Color darkDivider = Color(0xFF2A2A2A);

  // ============= GRADIENT COLORS =============
  /// Beautiful gradients for cards and backgrounds
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

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============= CATEGORY COLORS =============
  /// Colors for different NGO categories
  static const Color categoryEducation = Color(0xFF4A90E2);
  static const Color categoryHealth = Color(0xFFE24A7A);
  static const Color categoryEnvironment = Color(0xFF4AE290);
  static const Color categoryAnimals = Color(0xFFE2A74A);
  static const Color categorySocial = Color(0xFF9B4AE2);
  static const Color categoryDisaster = Color(0xFFE24A4A);

  // ============= HELPER METHODS =============
  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get category color by category name
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'education':
        return categoryEducation;
      case 'health':
        return categoryHealth;
      case 'environment':
        return categoryEnvironment;
      case 'animals':
        return categoryAnimals;
      case 'social':
        return categorySocial;
      case 'disaster':
        return categoryDisaster;
      default:
        return primary;
    }
  }
}

/// Interview Tip: Explain this structure
/// -----------------------------------
/// "I've centralized all colors in AppColors class for:
/// 1. Consistency - All screens use the same color palette
/// 2. Maintainability - Change colors in one place
/// 3. Theme support - Easy to switch between light/dark themes
/// 4. Scalability - Add new colors without breaking existing code
/// 5. Type safety - No magic strings or hardcoded values"
