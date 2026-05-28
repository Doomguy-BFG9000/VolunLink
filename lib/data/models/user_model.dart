/// UserModel - Represents a regular user (donor/volunteer)
class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime createdAt;
  final List<String> favoriteNGOs;
  final int totalDonations;
  final double totalAmountDonated;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.profileImage,
    required this.createdAt,
    this.favoriteNGOs = const [],
    this.totalDonations = 0,
    this.totalAmountDonated = 0.0,
  });

  // Convert UserModel to JSON (for storage/API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'favoriteNGOs': favoriteNGOs,
      'totalDonations': totalDonations,
      'totalAmountDonated': totalAmountDonated,
    };
  }

  // Create UserModel from JSON (from storage/API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      favoriteNGOs: List<String>.from(json['favoriteNGOs'] ?? []),
      totalDonations: json['totalDonations'] as int? ?? 0,
      totalAmountDonated: (json['totalAmountDonated'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Create a copy with updated fields (immutability)
  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? profileImage,
    DateTime? createdAt,
    List<String>? favoriteNGOs,
    int? totalDonations,
    double? totalAmountDonated,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      favoriteNGOs: favoriteNGOs ?? this.favoriteNGOs,
      totalDonations: totalDonations ?? this.totalDonations,
      totalAmountDonated: totalAmountDonated ?? this.totalAmountDonated,
    );
  }

  // Get user initials for avatar
  String getInitials() {
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return fullName[0].toUpperCase();
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, fullName: $fullName)';
  }
}

/// Interview Explanation:
/// ----------------------
/// "I created a data model class for users with:
/// 
/// 1. **Immutability**: All fields are final
///    - Prevents accidental data modification
///    - Safer concurrent operations
///    - Predictable state management
/// 
/// 2. **JSON Serialization**: toJson() and fromJson()
///    - Easy API integration
///    - Simple storage/retrieval
///    - Type-safe conversions
/// 
/// 3. **CopyWith Method**: Create modified copies
///    - Update fields without mutation
///    - Works well with state management
///    - Maintains data integrity
/// 
/// 4. **Helper Methods**: Utility functions
///    - getInitials() for avatar display
///    - toString() for debugging
/// 
/// 5. **Null Safety**: Proper nullable types
///    - Optional fields marked with ?
///    - Default values for lists
///    - Safe JSON parsing
/// 
/// This pattern follows best practices for:
/// - Clean Architecture
/// - State Management
/// - Type Safety
/// - Testability"
