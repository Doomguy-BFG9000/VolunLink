import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// StorageService - Handles local data persistence
/// Uses SharedPreferences for simple key-value storage
/// 
/// This is used for:
/// - User preferences (theme, language)
/// - Authentication tokens
/// - User session data
/// - App settings
class StorageService {
  // Singleton pattern - only one instance throughout app
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // SharedPreferences instance
  late SharedPreferences _prefs;

  /// Initialize SharedPreferences
  /// Call this in main.dart before runApp()
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============= STRING OPERATIONS =============

  /// Save string value
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      print('Error saving string: $e');
      return false;
    }
  }

  /// Get string value
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      print('Error getting string: $e');
      return null;
    }
  }

  // ============= INTEGER OPERATIONS =============

  /// Save integer value
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      print('Error saving int: $e');
      return false;
    }
  }

  /// Get integer value
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      print('Error getting int: $e');
      return null;
    }
  }

  // ============= BOOLEAN OPERATIONS =============

  /// Save boolean value
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      print('Error saving bool: $e');
      return false;
    }
  }

  /// Get boolean value
  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      print('Error getting bool: $e');
      return null;
    }
  }

  // ============= DOUBLE OPERATIONS =============

  /// Save double value
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      print('Error saving double: $e');
      return false;
    }
  }

  /// Get double value
  double? getDouble(String key) {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      print('Error getting double: $e');
      return null;
    }
  }

  // ============= LIST OPERATIONS =============

  /// Save list of strings
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      print('Error saving string list: $e');
      return false;
    }
  }

  /// Get list of strings
  List<String>? getStringList(String key) {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      print('Error getting string list: $e');
      return null;
    }
  }

  // ============= JSON OPERATIONS =============

  /// Save JSON object (converts to string)
  /// Useful for storing complex objects
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = json.encode(value);
      return await setString(key, jsonString);
    } catch (e) {
      print('Error saving JSON: $e');
      return false;
    }
  }

  /// Get JSON object (parses from string)
  Map<String, dynamic>? getJson(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString == null) return null;
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error getting JSON: $e');
      return null;
    }
  }

  // ============= DELETE OPERATIONS =============

  /// Remove specific key
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      print('Error removing key: $e');
      return false;
    }
  }

  /// Clear all data
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      print('Error clearing storage: $e');
      return false;
    }
  }

  // ============= CHECK OPERATIONS =============

  /// Check if key exists
  bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      print('Error checking key: $e');
      return false;
    }
  }

  /// Get all keys
  Set<String> getAllKeys() {
    try {
      return _prefs.getKeys();
    } catch (e) {
      print('Error getting all keys: $e');
      return {};
    }
  }

  // ============= UTILITY METHODS =============

  /// Reload preferences from disk
  Future<void> reload() async {
    try {
      await _prefs.reload();
    } catch (e) {
      print('Error reloading preferences: $e');
    }
  }

  /// Get storage size (approximate)
  int getStorageSize() {
    try {
      int totalSize = 0;
      for (String key in _prefs.getKeys()) {
        final value = _prefs.get(key);
        if (value != null) {
          totalSize += value.toString().length;
        }
      }
      return totalSize;
    } catch (e) {
      print('Error calculating storage size: $e');
      return 0;
    }
  }
}

/// Interview Explanation:
/// ----------------------
/// "StorageService is a crucial part of the app architecture:
/// 
/// 1. **Singleton Pattern**: Only one instance exists
///    - Prevents multiple SharedPreferences instances
///    - Consistent data access throughout app
///    - Memory efficient
/// 
/// 2. **Data Persistence**: Stores data locally on device
///    - User preferences (theme, language)
///    - Authentication tokens (for staying logged in)
///    - Cache data (for offline access)
///    - App settings
/// 
/// 3. **Type-Safe Methods**: Specific methods for each data type
///    - String, Int, Bool, Double, List
///    - JSON support for complex objects
///    - Reduces errors from wrong data types
/// 
/// 4. **Error Handling**: Try-catch blocks everywhere
///    - App won't crash if storage fails
///    - Logs errors for debugging
///    - Returns safe default values
/// 
/// 5. **Flexibility**: Supports various data types
///    - Simple values (strings, numbers, booleans)
///    - Complex objects (JSON serialization)
///    - Lists of strings
/// 
/// 6. **Easy to Use**: Simple API
///    - await StorageService().setString('key', 'value');
///    - final value = StorageService().getString('key');
/// 
/// 7. **Utility Methods**:
///    - Check if key exists
///    - Get all keys
///    - Calculate storage size
///    - Clear all data (useful for logout)
/// 
/// Usage in App:
/// - Save auth token: await StorageService().setString('token', token);
/// - Check first time: final isFirst = StorageService().getBool('is_first') ?? true;
/// - Save user data: await StorageService().setJson('user', userMap);
/// - Logout: await StorageService().clear();"
