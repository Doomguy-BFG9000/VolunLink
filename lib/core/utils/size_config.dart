import 'package:flutter/material.dart';

/// SizeConfig - Responsive design utility
/// Makes the app look great on all screen sizes (phones, tablets, etc.)
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  /// Initialize SizeConfig - Call this in build method
  /// Example: SizeConfig.init(context);
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    // Default size is 10 based on 375px wide screen (iPhone 11 Pro)
    // This makes it easy to scale sizes proportionally
    defaultSize = orientation == Orientation.portrait
        ? screenWidth / 37.5
        : screenHeight / 37.5;
  }

  // ============= RESPONSIVE WIDTH =============
  
  /// Get proportional width
  /// Input: percentage of screen width (0-100)
  /// Example: getProportionateScreenWidth(20) = 20% of screen width
  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  /// Shorthand for getProportionateScreenWidth
  static double w(double inputWidth) {
    return getProportionateScreenWidth(inputWidth);
  }

  // ============= RESPONSIVE HEIGHT =============
  
  /// Get proportional height
  /// Input: percentage of screen height (0-100)
  /// Example: getProportionateScreenHeight(20) = 20% of screen height
  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  /// Shorthand for getProportionateScreenHeight
  static double h(double inputHeight) {
    return getProportionateScreenHeight(inputHeight);
  }

  // ============= RESPONSIVE FONT SIZE =============
  
  /// Get responsive font size
  /// Scales font based on screen width
  static double getResponsiveFontSize(double fontSize) {
    return fontSize * (screenWidth / 375.0);
  }

  /// Shorthand for getResponsiveFontSize
  static double sp(double fontSize) {
    return getResponsiveFontSize(fontSize);
  }

  // ============= DEVICE TYPE DETECTION =============
  
  /// Check if device is mobile (width < 600)
  static bool get isMobile => screenWidth < 600;

  /// Check if device is tablet (width between 600-1024)
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// Check if device is desktop (width >= 1024)
  static bool get isDesktop => screenWidth >= 1024;

  /// Check if device is in portrait mode
  static bool get isPortrait => orientation == Orientation.portrait;

  /// Check if device is in landscape mode
  static bool get isLandscape => orientation == Orientation.landscape;

  // ============= SAFE AREA =============
  
  /// Get top safe area padding (for notch, status bar)
  static double get safeAreaTop => _mediaQueryData.padding.top;

  /// Get bottom safe area padding (for gesture bar)
  static double get safeAreaBottom => _mediaQueryData.padding.bottom;

  /// Get total safe area height
  static double get safeAreaHeight =>
      screenHeight - safeAreaTop - safeAreaBottom;

  // ============= RESPONSIVE PADDING =============
  
  /// Get horizontal padding based on device type
  static double get horizontalPadding {
    if (isDesktop) return 32.0;
    if (isTablet) return 24.0;
    return 16.0;
  }

  /// Get vertical padding based on device type
  static double get verticalPadding {
    if (isDesktop) return 32.0;
    if (isTablet) return 24.0;
    return 16.0;
  }

  // ============= GRID COLUMNS =============
  
  /// Get number of grid columns based on device type
  /// Useful for GridView.count or Wrap
  static int get gridColumns {
    if (isDesktop) return 4;
    if (isTablet) return 3;
    return 2;
  }

  // ============= MAXIMUM WIDTH FOR CONTENT =============
  
  /// Get maximum content width (for centered layouts on large screens)
  static double get maxContentWidth {
    if (isDesktop) return 1200.0;
    if (isTablet) return 800.0;
    return screenWidth;
  }

  // ============= CARD HEIGHT =============
  
  /// Get responsive card height
  static double getCardHeight({bool isSmall = false}) {
    if (isSmall) {
      if (isDesktop) return 150.0;
      if (isTablet) return 120.0;
      return 100.0;
    } else {
      if (isDesktop) return 250.0;
      if (isTablet) return 200.0;
      return 180.0;
    }
  }

  // ============= IMAGE SIZE =============
  
  /// Get responsive image size for avatars, logos, etc.
  static double getImageSize({String size = 'medium'}) {
    switch (size) {
      case 'small':
        return isDesktop ? 48.0 : isTablet ? 40.0 : 32.0;
      case 'medium':
        return isDesktop ? 80.0 : isTablet ? 64.0 : 48.0;
      case 'large':
        return isDesktop ? 120.0 : isTablet ? 100.0 : 80.0;
      default:
        return 48.0;
    }
  }

  // ============= BUTTON HEIGHT =============
  
  /// Get responsive button height
  static double get buttonHeight {
    if (isDesktop) return 56.0;
    if (isTablet) return 52.0;
    return 48.0;
  }

  // ============= TEXT FIELD HEIGHT =============
  
  /// Get responsive text field height
  static double get textFieldHeight {
    if (isDesktop) return 56.0;
    if (isTablet) return 52.0;
    return 48.0;
  }
}

/// Interview Explanation:
/// ----------------------
/// "I implemented SizeConfig for responsive design because:
/// 
/// 1. **Device Compatibility**: Works on all screen sizes
///    - Phones (small to large)
///    - Tablets (7-inch to 12-inch)
///    - Desktop (when Flutter Web is deployed)
/// 
/// 2. **Proportional Scaling**: Sizes scale with screen
///    - Uses base dimensions (iPhone 11 Pro: 375x812)
///    - Calculates proportions for current device
///    - Everything scales proportionally
/// 
/// 3. **Easy to Use**: Simple API with shorthand methods
///    - SizeConfig.w(20) for width
///    - SizeConfig.h(20) for height
///    - SizeConfig.sp(16) for font size
/// 
/// 4. **Device-Specific Logic**: Different layouts per device
///    - Grid columns: 2 (mobile), 3 (tablet), 4 (desktop)
///    - Padding: Larger on bigger screens
///    - Card sizes: Adaptive
/// 
/// 5. **Safe Area Handling**: Respects device notches
///    - Status bar height
///    - Bottom gesture bar
///    - Ensures content not hidden
/// 
/// 6. **Performance**: Calculated once, cached values
///    - No repeated calculations
///    - Fast access to dimensions
/// 
/// Usage Example:
/// Container(
///   width: SizeConfig.w(200),  // 200px on base device
///   height: SizeConfig.h(100), // 100px on base device
///   padding: EdgeInsets.all(SizeConfig.horizontalPadding),
/// )"
