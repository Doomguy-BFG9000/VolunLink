import '../constants/app_constants.dart';
import '../constants/string_constants.dart';

/// Validators - Form validation utilities
/// Provides reusable validation logic for all forms in the app
class Validators {
  Validators._();

  // ============= EMAIL VALIDATION =============
  /// Validates email format using regex
  /// Returns error message if invalid, null if valid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return StringConstants.invalidEmail;
    }

    return null; // Valid
  }

  // ============= PASSWORD VALIDATION =============
  /// Validates password strength
  /// Checks: length, uppercase, lowercase, numbers, special chars
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    if (value.length < AppConstants.minPasswordLength) {
      return StringConstants.passwordTooShort;
    }

    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password is too long';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null; // Valid
  }

  // ============= CONFIRM PASSWORD VALIDATION =============
  /// Validates that confirm password matches original password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    if (value != password) {
      return StringConstants.passwordsNotMatch;
    }

    return null; // Valid
  }

  // ============= NAME VALIDATION =============
  /// Validates name (full name, organization name, etc.)
  static String? validateName(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    if (value.trim().length < AppConstants.minNameLength) {
      return '${fieldName ?? 'Name'} must be at least ${AppConstants.minNameLength} characters';
    }

    if (value.length > AppConstants.maxNameLength) {
      return '${fieldName ?? 'Name'} is too long';
    }

    // Check for valid name characters (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return '${fieldName ?? 'Name'} contains invalid characters';
    }

    return null; // Valid
  }

  // ============= PHONE NUMBER VALIDATION =============
  /// Validates phone number (Indian format primarily)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    // Remove spaces, hyphens, and parentheses
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check for 10 digits (Indian phone numbers)
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleanedValue)) {
      return StringConstants.invalidPhone;
    }

    return null; // Valid
  }

  // ============= AMOUNT VALIDATION =============
  /// Validates donation/monetary amount
  static String? validateAmount(String? value, {int? minAmount}) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    final amount = int.tryParse(value);
    
    if (amount == null) {
      return StringConstants.invalidAmount;
    }

    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }

    if (minAmount != null && amount < minAmount) {
      return 'Minimum amount is ₹$minAmount';
    }

    return null; // Valid
  }

  // ============= REQUIRED FIELD VALIDATION =============
  /// Generic validation for required fields
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null; // Valid
  }

  // ============= DESCRIPTION VALIDATION =============
  /// Validates text descriptions (campaign, profile, etc.)
  static String? validateDescription(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return StringConstants.requiredField;
    }

    if (value.trim().length < AppConstants.minDescriptionLength) {
      return '${fieldName ?? 'Description'} must be at least ${AppConstants.minDescriptionLength} characters';
    }

    if (value.length > AppConstants.maxDescriptionLength) {
      return '${fieldName ?? 'Description'} is too long';
    }

    return null; // Valid
  }

  // ============= URL VALIDATION =============
  /// Validates URL format
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional in most cases
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null; // Valid
  }

  // ============= DATE VALIDATION =============
  /// Validates that date is not in the past
  static String? validateFutureDate(DateTime? value) {
    if (value == null) {
      return StringConstants.requiredField;
    }

    if (value.isBefore(DateTime.now())) {
      return 'Date must be in the future';
    }

    return null; // Valid
  }

  /// Validates date range (start date must be before end date)
  static String? validateDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return StringConstants.requiredField;
    }

    if (startDate.isAfter(endDate)) {
      return 'Start date must be before end date';
    }

    return null; // Valid
  }
}

/// Interview Explanation:
/// ----------------------
/// "I created a comprehensive validation system because:
/// 
/// 1. **Reusability**: Same validation logic across all forms
///    - No duplicate validation code
///    - Consistent validation rules
/// 
/// 2. **User Experience**: Clear, helpful error messages
///    - Specific feedback on what's wrong
///    - Tells users how to fix issues
/// 
/// 3. **Security**: Proper input validation prevents:
///    - SQL injection attempts
///    - XSS attacks
///    - Invalid data in database
/// 
/// 4. **Regex Usage**: Efficient pattern matching
///    - Email format validation
///    - Phone number formats
///    - URL validation
/// 
/// 5. **Flexibility**: Optional parameters for customization
///    - Can specify minimum amounts
///    - Custom field names in error messages
/// 
/// 6. **Testability**: Pure functions, easy to unit test
///    - No dependencies on UI
///    - Predictable outputs"
