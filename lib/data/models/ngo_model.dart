/// NGOModel - Represents an NGO organization
class NGOModel {
  final String id;
  final String email;
  final String organizationName;
  final String? description;
  final String category;
  final String? logo;
  final String? coverImage;
  final String? phoneNumber;
  final String? website;
  final String? address;
  final String? city;
  final String? state;
  final DateTime createdAt;
  final bool isVerified;
  final double rating;
  final int totalDonations;
  final double totalAmountReceived;
  final int activeCampaigns;
  final int totalVolunteers;
  final List<String> gallery;

  NGOModel({
    required this.id,
    required this.email,
    required this.organizationName,
    this.description,
    required this.category,
    this.logo,
    this.coverImage,
    this.phoneNumber,
    this.website,
    this.address,
    this.city,
    this.state,
    required this.createdAt,
    this.isVerified = false,
    this.rating = 0.0,
    this.totalDonations = 0,
    this.totalAmountReceived = 0.0,
    this.activeCampaigns = 0,
    this.totalVolunteers = 0,
    this.gallery = const [],
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'organizationName': organizationName,
      'description': description,
      'category': category,
      'logo': logo,
      'coverImage': coverImage,
      'phoneNumber': phoneNumber,
      'website': website,
      'address': address,
      'city': city,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
      'rating': rating,
      'totalDonations': totalDonations,
      'totalAmountReceived': totalAmountReceived,
      'activeCampaigns': activeCampaigns,
      'totalVolunteers': totalVolunteers,
      'gallery': gallery,
    };
  }

  // Create from JSON
  factory NGOModel.fromJson(Map<String, dynamic> json) {
    return NGOModel(
      id: json['id'] as String,
      email: json['email'] as String,
      organizationName: json['organizationName'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      logo: json['logo'] as String?,
      coverImage: json['coverImage'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isVerified: json['isVerified'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalDonations: json['totalDonations'] as int? ?? 0,
      totalAmountReceived: (json['totalAmountReceived'] as num?)?.toDouble() ?? 0.0,
      activeCampaigns: json['activeCampaigns'] as int? ?? 0,
      totalVolunteers: json['totalVolunteers'] as int? ?? 0,
      gallery: List<String>.from(json['gallery'] ?? []),
    );
  }

  // CopyWith for immutability
  NGOModel copyWith({
    String? id,
    String? email,
    String? organizationName,
    String? description,
    String? category,
    String? logo,
    String? coverImage,
    String? phoneNumber,
    String? website,
    String? address,
    String? city,
    String? state,
    DateTime? createdAt,
    bool? isVerified,
    double? rating,
    int? totalDonations,
    double? totalAmountReceived,
    int? activeCampaigns,
    int? totalVolunteers,
    List<String>? gallery,
  }) {
    return NGOModel(
      id: id ?? this.id,
      email: email ?? this.email,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      category: category ?? this.category,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      totalDonations: totalDonations ?? this.totalDonations,
      totalAmountReceived: totalAmountReceived ?? this.totalAmountReceived,
      activeCampaigns: activeCampaigns ?? this.activeCampaigns,
      totalVolunteers: totalVolunteers ?? this.totalVolunteers,
      gallery: gallery ?? this.gallery,
    );
  }

  // Get organization initials for avatar
  String getInitials() {
    final words = organizationName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return organizationName.substring(0, 2).toUpperCase();
  }

  // Get location string
  String? getLocation() {
    if (city != null && state != null) {
      return '$city, $state';
    } else if (city != null) {
      return city;
    } else if (state != null) {
      return state;
    }
    return null;
  }

  // Get formatted rating (e.g., "4.5 ⭐")
  String getFormattedRating() {
    return '${rating.toStringAsFixed(1)} ⭐';
  }

  @override
  String toString() {
    return 'NGOModel(id: $id, name: $organizationName, category: $category)';
  }
}

/// Interview Explanation:
/// ----------------------
/// "NGOModel is more complex than UserModel because:
/// 
/// 1. **Rich Data Structure**: NGOs have more fields
///    - Contact info (phone, website, address)
///    - Statistics (donations, volunteers, campaigns)
///    - Media (logo, cover, gallery)
///    - Verification status
/// 
/// 2. **Helper Methods**: Convenient data formatting
///    - getLocation() combines city and state
///    - getFormattedRating() for display
///    - getInitials() for avatar fallback
/// 
/// 3. **Same Patterns as UserModel**:
///    - Immutability with final fields
///    - JSON serialization
///    - CopyWith method
///    - Null safety
/// 
/// 4. **Business Logic**: Built-in validation
///    - Rating defaults to 0.0
///    - Gallery defaults to empty list
///    - Safe nullable handling
/// 
/// This model will be used throughout the app for:
/// - Displaying NGO cards
/// - NGO detail pages
/// - Search and filtering
/// - Dashboard statistics"
