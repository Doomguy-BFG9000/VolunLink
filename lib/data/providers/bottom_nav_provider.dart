import 'package:flutter/material.dart';

/// BottomNavProvider - Manages bottom navigation state
/// Tracks which tab is currently selected
class BottomNavProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Change selected tab
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Reset to home tab
  void resetToHome() {
    _currentIndex = 0;
    notifyListeners();
  }
}

/// Interview Tip:
/// "Simple provider for bottom navigation because:
/// 1. Keeps navigation state separate from UI
/// 2. Can access current tab from anywhere
/// 3. Easy to reset navigation
/// 4. Scalable for future features"
