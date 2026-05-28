/// AppConstants - Centralized constants for the entire app
/// This prevents magic numbers and strings throughout the codebase
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ============= APP INFO =============
  static const String appName = 'NGO Scout';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Connecting Hearts, Changing Lives';

  // ============= STORAGE KEYS =============
  /// Keys used for SharedPreferences/Hive storage
  static const String keyIsFirstTime = 'is_first_time';
  static const String keyUserToken = 'user_token';
  static const String keyUserId = 'user_id';
  static const String keyUserType = 'user_type';
  static const String keyUserData = 'user_data';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyRememberMe = 'remember_me';
  static const String keyCachedNGOs = 'cached_ngos';
  static const String keyCachedCategories = 'cached_categories';
  static const String keyLastSyncTime = 'last_sync_time';

  // ============= API ENDPOINTS (for future backend) =============
  static const String baseUrl = 'https://api.ngoscout.com/v1';
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';
  static const String ngosEndpoint = '/ngos';
  static const String donationsEndpoint = '/donations';
  static const String campaignsEndpoint = '/campaigns';

  // ============= PAGINATION =============
  static const int itemsPerPage = 10;
  static const int maxLoadMoreItems = 50;

  // ============= ANIMATION DURATIONS =============
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);

  // ============= LAYOUT CONSTANTS =============
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 16.0;
  static const double cardElevation = 2.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 40.0;

  // ============= NGO CATEGORIES =============
  static const List<String> ngoCategories = [
    'Education',
    'Health',
    'Environment',
    'Animal Welfare',
    'Social Services',
    'Disaster Relief',
    'Arts & Culture',
    'Human Rights',
  ];

  // ============= DONATION AMOUNTS (Suggested) =============
  static const List<int> suggestedDonations = [
    100,
    500,
    1000,
    2000,
    5000,
  ];

  // ============= VALIDATION CONSTANTS =============
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 500;

  // ============= FILE UPLOAD =============
  static const int maxImageSizeMB = 5;
  static const int maxImageSizeBytes = maxImageSizeMB * 1024 * 1024;
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];

  // ============= CACHE EXPIRY =============
  static const Duration cacheExpiry = Duration(hours: 24);
  static const Duration shortCacheExpiry = Duration(hours: 1);

  // ============= ERROR MESSAGES =============
  static const String networkError = 'No internet connection. Please check your network.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'Something went wrong. Please try again.';
  static const String sessionExpired = 'Your session has expired. Please login again.';

  // ============= SUCCESS MESSAGES =============
  static const String loginSuccess = 'Welcome back!';
  static const String signupSuccess = 'Account created successfully!';
  static const String donationSuccess = 'Thank you for your donation!';
  static const String profileUpdated = 'Profile updated successfully!';

  // ============= PLACEHOLDER IMAGES =============
  static const String placeholderAvatar = 'assets/images/placeholder_avatar.png';
  static const String placeholderNGO = 'assets/images/placeholder_ngo.png';
  static const String placeholderImage = 'assets/images/placeholder.png';
}

/// Interview Explanation:
/// ----------------------
/// "I use AppConstants class to:
/// 
/// 1. **Avoid Magic Numbers/Strings**: All hardcoded values in one place
///    - Easy to find and update
///    - No scattered hardcoded values
/// 
/// 2. **Type Safety**: Compile-time checking
///    - IDE autocomplete helps find constants
///    - Refactoring is safer
/// 
/// 3. **Maintainability**: Change once, affects everywhere
///    - Update API URL in one place
///    - Adjust timings globally
/// 
/// 4. **Documentation**: Constants serve as documentation
///    - New developers understand app configuration
///    - Clear naming explains purpose
/// 
/// 5. **Configuration Management**: Easy to switch environments
///    - Development vs Production
///    - Can be extended for flavors (dev, staging, prod)"
