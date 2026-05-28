import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../models/ngo_model.dart';
import '../../core/services/storage_service.dart';
import '../../core/constants/app_constants.dart';

/// UserType - Enum for user types
enum UserType { user, ngo }

/// AuthProvider - Manages authentication state
/// 
/// Responsibilities:
/// - Handle login/logout
/// - Manage user session
/// - Store authentication state
/// - Provide user data to app
class AuthProvider with ChangeNotifier {
  // Current user type
  UserType _userType = UserType.user;
  
  // Authentication state
  bool _isAuthenticated = false;
  bool _isLoading = false;
  
  // User data
  UserModel? _currentUser;
  NGOModel? _currentNGO;
  
  // Error message
  String? _errorMessage;

  // Storage service instance
  final StorageService _storage = StorageService();

  // Getters
  UserType get userType => _userType;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  NGOModel? get currentNGO => _currentNGO;
  String? get errorMessage => _errorMessage;
  bool get isUserType => _userType == UserType.user;
  bool get isNGOType => _userType == UserType.ngo;

  // ============= INITIALIZATION =============

  /// Initialize auth state from storage
  /// Call this when app starts
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check if user was logged in
      final userTypeString = _storage.getString(AppConstants.keyUserType);
      final userData = _storage.getJson(AppConstants.keyUserData);

      if (userTypeString != null && userData != null) {
        // User was logged in, restore session
        _userType = userTypeString == 'user' ? UserType.user : UserType.ngo;
        
        if (_userType == UserType.user) {
          _currentUser = UserModel.fromJson(userData);
        } else {
          _currentNGO = NGOModel.fromJson(userData);
        }
        
        _isAuthenticated = true;
      }
    } catch (e) {
      print('Error initializing auth: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= USER TYPE SELECTION =============

  /// Set user type (User or NGO)
  void setUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }

  // ============= LOGIN =============

  /// Login with email and password
  /// In production, this would call an API
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        _errorMessage = 'Please fill all fields';
        return false;
      }

      if (!email.contains('@')) {
        _errorMessage = 'Invalid email format';
        return false;
      }

      if (password.length < 6) {
        _errorMessage = 'Password too short';
        return false;
      }

      // Create mock user/NGO based on type
      if (_userType == UserType.user) {
        _currentUser = UserModel(
          id: const Uuid().v4(),
          email: email,
          fullName: 'Demo User',
          phoneNumber: '+91 98765 43210',
          createdAt: DateTime.now(),
          favoriteNGOs: [],
          totalDonations: 5,
          totalAmountDonated: 5000.0,
        );

        // Save to storage
        await _storage.setString(AppConstants.keyUserType, 'user');
        await _storage.setJson(AppConstants.keyUserData, _currentUser!.toJson());
      } else {
        _currentNGO = NGOModel(
          id: const Uuid().v4(),
          email: email,
          organizationName: 'Demo NGO',
          description: 'A demo NGO for testing purposes',
          category: 'Education',
          phoneNumber: '+91 98765 43210',
          city: 'Mumbai',
          state: 'Maharashtra',
          createdAt: DateTime.now(),
          isVerified: true,
          rating: 4.5,
          totalDonations: 150,
          totalAmountReceived: 500000.0,
          activeCampaigns: 3,
          totalVolunteers: 25,
        );

        // Save to storage
        await _storage.setString(AppConstants.keyUserType, 'ngo');
        await _storage.setJson(AppConstants.keyUserData, _currentNGO!.toJson());
      }

      _isAuthenticated = true;
      return true;
    } catch (e) {
      _errorMessage = 'Login failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= SIGNUP =============

  /// Sign up new user
  Future<bool> signup({
    required String email,
    required String password,
    required String fullName,
    String? organizationName,
    String? phoneNumber,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock validation
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        _errorMessage = 'Please fill all required fields';
        return false;
      }

      // Create new user/NGO
      if (_userType == UserType.user) {
        _currentUser = UserModel(
          id: const Uuid().v4(),
          email: email,
          fullName: fullName,
          phoneNumber: phoneNumber,
          createdAt: DateTime.now(),
        );

        await _storage.setString(AppConstants.keyUserType, 'user');
        await _storage.setJson(AppConstants.keyUserData, _currentUser!.toJson());
      } else {
        _currentNGO = NGOModel(
          id: const Uuid().v4(),
          email: email,
          organizationName: organizationName ?? fullName,
          phoneNumber: phoneNumber,
          category: 'Education', // Default category
          createdAt: DateTime.now(),
        );

        await _storage.setString(AppConstants.keyUserType, 'ngo');
        await _storage.setJson(AppConstants.keyUserData, _currentNGO!.toJson());
      }

      _isAuthenticated = true;
      return true;
    } catch (e) {
      _errorMessage = 'Signup failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= LOGOUT =============

  /// Logout current user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear storage
      await _storage.remove(AppConstants.keyUserType);
      await _storage.remove(AppConstants.keyUserData);

      // Clear state
      _currentUser = null;
      _currentNGO = null;
      _isAuthenticated = false;
      _errorMessage = null;
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= UPDATE PROFILE =============

  /// Update user profile
  Future<bool> updateUserProfile(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = updatedUser;
      await _storage.setJson(AppConstants.keyUserData, updatedUser.toJson());
      
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update NGO profile
  Future<bool> updateNGOProfile(NGOModel updatedNGO) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _currentNGO = updatedNGO;
      await _storage.setJson(AppConstants.keyUserData, updatedNGO.toJson());
      
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= HELPERS =============

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Get display name
  String getDisplayName() {
    if (_userType == UserType.user && _currentUser != null) {
      return _currentUser!.fullName;
    } else if (_userType == UserType.ngo && _currentNGO != null) {
      return _currentNGO!.organizationName;
    }
    return 'Guest';
  }

  /// Get email
  String? getEmail() {
    if (_userType == UserType.user && _currentUser != null) {
      return _currentUser!.email;
    } else if (_userType == UserType.ngo && _currentNGO != null) {
      return _currentNGO!.email;
    }
    return null;
  }
}

/// Interview Explanation:
/// ----------------------
/// "AuthProvider uses Provider pattern for state management:
/// 
/// 1. **ChangeNotifier**: Reactive state updates
///    - notifyListeners() updates UI automatically
///    - Efficient - only rebuilds what's needed
/// 
/// 2. **Persistent Sessions**: Restores login state
///    - Saves to StorageService on login
///    - Loads on app start
///    - User stays logged in
/// 
/// 3. **Loading States**: Better UX
///    - Shows loading indicators
///    - Disables buttons during operations
///    - Prevents multiple submissions
/// 
/// 4. **Error Handling**: User-friendly errors
///    - Stores error messages
///    - Displays to user
///    - Can be cleared
/// 
/// 5. **Type Safety**: Separate User/NGO models
///    - Different data for different types
///    - Type-safe access
///    - Prevents errors
/// 
/// 6. **Scalable**: Easy to add features
///    - Can add social login
///    - Can integrate real API
///    - Can add more auth methods"
