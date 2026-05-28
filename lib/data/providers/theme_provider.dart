import 'package:flutter/material.dart';
import '../../core/services/storage_service.dart';
import '../../core/constants/app_constants.dart';

/// ThemeProvider - Manages app theme (light/dark mode)
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final StorageService _storage = StorageService();

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Initialize theme from storage
  ThemeProvider() {
    _loadTheme();
  }

  /// Load saved theme preference
  Future<void> _loadTheme() async {
    final savedTheme = _storage.getString(AppConstants.keyThemeMode);
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    await _saveTheme();
    notifyListeners();
  }

  /// Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveTheme();
    notifyListeners();
  }

  /// Save theme preference
  Future<void> _saveTheme() async {
    await _storage.setString(
      AppConstants.keyThemeMode,
      _themeMode.toString(),
    );
  }
}

/// Interview Tip:
/// "ThemeProvider manages theme with:
/// 1. Persistent theme preference
/// 2. System theme support
/// 3. Easy toggle functionality
/// 4. Clean state management"
