import 'package:intl/intl.dart';

/// DateFormatter - Utility class for date/time formatting
/// Provides consistent date formatting throughout the app
class DateFormatter {
  DateFormatter._();

  // ============= COMMON DATE FORMATS =============
  
  /// Format: 15 Jan 2024
  static String formatShortDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format: January 15, 2024
  static String formatLongDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Format: 15/01/2024
  static String formatNumericDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format: 2024-01-15 (ISO format, good for backend)
  static String formatISODate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // ============= TIME FORMATS =============
  
  /// Format: 3:30 PM
  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Format: 15:30 (24-hour format)
  static String formatTime24(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  // ============= COMBINED DATE & TIME FORMATS =============
  
  /// Format: 15 Jan 2024, 3:30 PM
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, h:mm a').format(date);
  }

  /// Format: January 15, 2024 at 3:30 PM
  static String formatLongDateTime(DateTime date) {
    return DateFormat('MMMM dd, yyyy \'at\' h:mm a').format(date);
  }

  // ============= RELATIVE TIME (TimeAgo) =============
  
  /// Returns relative time: "Just now", "5 minutes ago", "2 hours ago", etc.
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // Just now (less than 1 minute)
    if (difference.inSeconds < 60) {
      return 'Just now';
    }

    // Minutes ago (less than 1 hour)
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    }

    // Hours ago (less than 1 day)
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }

    // Days ago (less than 7 days)
    if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }

    // Weeks ago (less than 30 days)
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }

    // Months ago (less than 365 days)
    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }

    // Years ago
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  }

  // ============= SMART DATE FORMATTING =============
  
  /// Shows relative time for recent dates, full date for older ones
  /// Example: "2 hours ago" or "15 Jan 2024"
  static String formatSmart(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // If less than 24 hours, show relative time
    if (difference.inHours < 24) {
      return formatRelativeTime(date);
    }

    // If less than 7 days, show "Monday" or "Tuesday"
    if (difference.inDays < 7) {
      return DateFormat('EEEE').format(date); // Day name
    }

    // Otherwise show short date
    return formatShortDate(date);
  }

  // ============= DATE RANGE FORMATTING =============
  
  /// Format date range: "15 Jan - 20 Jan 2024"
  static String formatDateRange(DateTime startDate, DateTime endDate) {
    // Same year
    if (startDate.year == endDate.year) {
      // Same month
      if (startDate.month == endDate.month) {
        return '${DateFormat('dd').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}';
      }
      // Different months, same year
      return '${DateFormat('dd MMM').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}';
    }
    // Different years
    return '${formatShortDate(startDate)} - ${formatShortDate(endDate)}';
  }

  // ============= REMAINING TIME =============
  
  /// Calculate remaining time: "5 days left", "2 hours left", etc.
  static String formatRemainingTime(DateTime endDate) {
    final now = DateTime.now();
    final difference = endDate.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    // Less than 1 hour
    if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} left';
    }

    // Less than 1 day
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} left';
    }

    // Days left
    final days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} left';
  }

  // ============= DAY NAME =============
  
  /// Get day name: "Monday", "Tuesday", etc.
  static String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  /// Get short day name: "Mon", "Tue", etc.
  static String getShortDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  // ============= MONTH NAME =============
  
  /// Get month name: "January", "February", etc.
  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  /// Get short month name: "Jan", "Feb", etc.
  static String getShortMonthName(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  // ============= PARSING =============
  
  /// Parse ISO date string to DateTime
  static DateTime? parseISODate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parse custom format date string
  static DateTime? parseCustomDate(String dateString, String format) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // ============= DATE COMPARISON =============
  
  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
           date.month == yesterday.month &&
           date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
           date.month == tomorrow.month &&
           date.day == tomorrow.day;
  }
}

/// Interview Explanation:
/// ----------------------
/// "The DateFormatter utility provides:
/// 
/// 1. **Consistency**: All dates displayed uniformly
///    - Same format throughout the app
///    - Professional appearance
/// 
/// 2. **Internationalization Ready**: Uses intl package
///    - Easy to add localization
///    - Supports multiple date formats
/// 
/// 3. **User-Friendly Relative Times**: 
///    - '2 hours ago' is more readable than timestamps
///    - Smart formatting based on time difference
/// 
/// 4. **Flexible Formatting Options**:
///    - Short dates for lists
///    - Long dates for details
///    - Relative times for recent activity
/// 
/// 5. **Helper Methods**: 
///    - Date comparisons (isToday, isYesterday)
///    - Date parsing utilities
///    - Date range formatting
/// 
/// 6. **Performance**: Static methods, no object creation
///    - Efficient memory usage
///    - Fast execution"
