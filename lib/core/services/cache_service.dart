import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

/// CacheService - High-performance local caching using Hive
/// 
/// Why Hive over SharedPreferences?
/// - Much faster (NoSQL database)
/// - Can store large amounts of data
/// - Better for complex objects
/// - Type-safe storage
/// 
/// Used for:
/// - Caching API responses (NGO list, categories, etc.)
/// - Storing large datasets
/// - Offline data access
/// - Recent searches
class CacheService {
  // Singleton pattern
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  // Box names (like tables in database)
  static const String _ngoBox = 'ngo_cache';
  static const String _userBox = 'user_cache';
  static const String _generalBox = 'general_cache';

  // Boxes (like database tables)
  late Box<dynamic> _ngoBoxInstance;
  late Box<dynamic> _userBoxInstance;
  late Box<dynamic> _generalBoxInstance;

  /// Initialize Hive
  /// Call this in main.dart before runApp()
  Future<void> init() async {
    try {
      // Initialize Hive with Flutter
      await Hive.initFlutter();

      // Open boxes (create if doesn't exist)
      _ngoBoxInstance = await Hive.openBox(_ngoBox);
      _userBoxInstance = await Hive.openBox(_userBox);
      _generalBoxInstance = await Hive.openBox(_generalBox);

      print('✅ Hive cache initialized successfully');
    } catch (e) {
      print('❌ Error initializing Hive: $e');
    }
  }

  // ============= NGO CACHE OPERATIONS =============

  /// Cache NGO list
  Future<void> cacheNGOList(List<Map<String, dynamic>> ngos) async {
    try {
      await _ngoBoxInstance.put('ngo_list', json.encode(ngos));
      await _ngoBoxInstance.put('ngo_list_timestamp', DateTime.now().millisecondsSinceEpoch);
      print('✅ NGO list cached successfully');
    } catch (e) {
      print('❌ Error caching NGO list: $e');
    }
  }

  /// Get cached NGO list
  List<Map<String, dynamic>>? getCachedNGOList() {
    try {
      final cachedData = _ngoBoxInstance.get('ngo_list');
      if (cachedData == null) return null;

      // Check if cache is expired (24 hours)
      final timestamp = _ngoBoxInstance.get('ngo_list_timestamp') as int?;
      if (timestamp != null) {
        final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
        if (cacheAge > 24 * 60 * 60 * 1000) {
          // Cache expired
          print('⚠️ NGO cache expired');
          return null;
        }
      }

      final decoded = json.decode(cachedData) as List;
      return decoded.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      print('❌ Error getting cached NGO list: $e');
      return null;
    }
  }

  /// Cache single NGO details
  Future<void> cacheNGODetails(String ngoId, Map<String, dynamic> ngoData) async {
    try {
      await _ngoBoxInstance.put('ngo_$ngoId', json.encode(ngoData));
      await _ngoBoxInstance.put('ngo_${ngoId}_timestamp', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('❌ Error caching NGO details: $e');
    }
  }

  /// Get cached NGO details
  Map<String, dynamic>? getCachedNGODetails(String ngoId) {
    try {
      final cachedData = _ngoBoxInstance.get('ngo_$ngoId');
      if (cachedData == null) return null;

      // Check cache expiry
      final timestamp = _ngoBoxInstance.get('ngo_${ngoId}_timestamp') as int?;
      if (timestamp != null) {
        final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
        if (cacheAge > 24 * 60 * 60 * 1000) return null;
      }

      return json.decode(cachedData) as Map<String, dynamic>;
    } catch (e) {
      print('❌ Error getting cached NGO details: $e');
      return null;
    }
  }

  // ============= CATEGORY CACHE =============

  /// Cache categories
  Future<void> cacheCategories(List<String> categories) async {
    try {
      await _generalBoxInstance.put('categories', categories);
    } catch (e) {
      print('❌ Error caching categories: $e');
    }
  }

  /// Get cached categories
  List<String>? getCachedCategories() {
    try {
      final cached = _generalBoxInstance.get('categories');
      return cached != null ? List<String>.from(cached) : null;
    } catch (e) {
      print('❌ Error getting cached categories: $e');
      return null;
    }
  }

  // ============= SEARCH HISTORY =============

  /// Save search query
  Future<void> saveSearchQuery(String query) async {
    try {
      List<String> searches = getSearchHistory();
      
      // Remove if already exists
      searches.remove(query);
      
      // Add to beginning
      searches.insert(0, query);
      
      // Keep only last 10 searches
      if (searches.length > 10) {
        searches = searches.sublist(0, 10);
      }

      await _generalBoxInstance.put('search_history', searches);
    } catch (e) {
      print('❌ Error saving search query: $e');
    }
  }

  /// Get search history
  List<String> getSearchHistory() {
    try {
      final cached = _generalBoxInstance.get('search_history');
      return cached != null ? List<String>.from(cached) : [];
    } catch (e) {
      print('❌ Error getting search history: $e');
      return [];
    }
  }

  /// Clear search history
  Future<void> clearSearchHistory() async {
    try {
      await _generalBoxInstance.delete('search_history');
    } catch (e) {
      print('❌ Error clearing search history: $e');
    }
  }

  // ============= FAVORITE NGOs =============

  /// Add NGO to favorites
  Future<void> addToFavorites(String ngoId) async {
    try {
      List<String> favorites = getFavoriteNGOs();
      if (!favorites.contains(ngoId)) {
        favorites.add(ngoId);
        await _userBoxInstance.put('favorites', favorites);
      }
    } catch (e) {
      print('❌ Error adding to favorites: $e');
    }
  }

  /// Remove NGO from favorites
  Future<void> removeFromFavorites(String ngoId) async {
    try {
      List<String> favorites = getFavoriteNGOs();
      favorites.remove(ngoId);
      await _userBoxInstance.put('favorites', favorites);
    } catch (e) {
      print('❌ Error removing from favorites: $e');
    }
  }

  /// Get favorite NGOs
  List<String> getFavoriteNGOs() {
    try {
      final cached = _userBoxInstance.get('favorites');
      return cached != null ? List<String>.from(cached) : [];
    } catch (e) {
      print('❌ Error getting favorites: $e');
      return [];
    }
  }

  /// Check if NGO is favorite
  bool isFavorite(String ngoId) {
    return getFavoriteNGOs().contains(ngoId);
  }

  // ============= GENERIC OPERATIONS =============

  /// Save any data
  Future<void> save(String key, dynamic value) async {
    try {
      await _generalBoxInstance.put(key, value);
    } catch (e) {
      print('❌ Error saving data: $e');
    }
  }

  /// Get any data
  dynamic get(String key) {
    try {
      return _generalBoxInstance.get(key);
    } catch (e) {
      print('❌ Error getting data: $e');
      return null;
    }
  }

  /// Delete specific key
  Future<void> delete(String key) async {
    try {
      await _generalBoxInstance.delete(key);
    } catch (e) {
      print('❌ Error deleting data: $e');
    }
  }

  // ============= CLEAR OPERATIONS =============

  /// Clear all NGO cache
  Future<void> clearNGOCache() async {
    try {
      await _ngoBoxInstance.clear();
      print('✅ NGO cache cleared');
    } catch (e) {
      print('❌ Error clearing NGO cache: $e');
    }
  }

  /// Clear all user cache
  Future<void> clearUserCache() async {
    try {
      await _userBoxInstance.clear();
      print('✅ User cache cleared');
    } catch (e) {
      print('❌ Error clearing user cache: $e');
    }
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    try {
      await _ngoBoxInstance.clear();
      await _userBoxInstance.clear();
      await _generalBoxInstance.clear();
      print('✅ All cache cleared');
    } catch (e) {
      print('❌ Error clearing all cache: $e');
    }
  }

  // ============= UTILITY METHODS =============

  /// Get cache size
  int getCacheSize() {
    try {
      return _ngoBoxInstance.length + 
             _userBoxInstance.length + 
             _generalBoxInstance.length;
    } catch (e) {
      print('❌ Error getting cache size: $e');
      return 0;
    }
  }

  /// Check if cache exists for key
  bool hasCache(String key) {
    try {
      return _generalBoxInstance.containsKey(key);
    } catch (e) {
      return false;
    }
  }
}

/// Interview Explanation:
/// ----------------------
/// "CacheService uses Hive for high-performance caching:
/// 
/// 1. **Why Hive?**
///    - 10x faster than SharedPreferences
///    - NoSQL database written in pure Dart
///    - Can store large amounts of data efficiently
///    - Type-safe and strongly typed
///    - Works on all platforms (mobile, web, desktop)
/// 
/// 2. **Multiple Boxes**: Organized like database tables
///    - ngo_box: NGO-related data
///    - user_box: User preferences, favorites
///    - general_box: Miscellaneous data
///    - Better organization and performance
/// 
/// 3. **Cache Expiry**: Smart cache management
///    - Stores timestamp with each cache entry
///    - Checks age before returning cached data
///    - Auto-invalidates old data (24 hours)
///    - Prevents showing stale data
/// 
/// 4. **Offline Support**: App works without internet
///    - Cached NGO list loads instantly
///    - Cached details available offline
///    - Better user experience
///    - Reduces API calls
/// 
/// 5. **Search History**: User convenience
///    - Stores recent searches
///    - Quick access to previous queries
///    - Limited to 10 items (performance)
///    - Can be cleared by user
/// 
/// 6. **Favorites**: Bookmark functionality
///    - Add/remove favorites
///    - Check if NGO is favorited
///    - Persists across app restarts
///    - Fast lookup with List
/// 
/// 7. **Error Handling**: Robust error management
///    - Try-catch on all operations
///    - Logs errors for debugging
///    - Returns safe defaults
///    - App never crashes from cache errors
/// 
/// Performance Benefits:
/// - Instant data loading (no network delay)
/// - Reduced API calls (saves bandwidth)
/// - Works offline completely
/// - Smooth user experience
/// 
/// Usage Example:
/// // Cache NGO list after API fetch
/// await CacheService().cacheNGOList(ngoList);
/// 
/// // Try to load from cache first
/// final cached = CacheService().getCachedNGOList();
/// if (cached != null) {
///   // Use cached data
/// } else {
///   // Fetch from API
/// }"
