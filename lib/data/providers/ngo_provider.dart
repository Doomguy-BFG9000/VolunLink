import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/ngo_model.dart';
import '../../core/services/cache_service.dart';

/// NGOProvider - Manages NGO data
/// In production, this would fetch from API
class NGOProvider with ChangeNotifier {
  List<NGOModel> _ngos = [];
  List<NGOModel> _filteredNGOs = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;

  // Getters
  List<NGOModel> get ngos => _filteredNGOs.isEmpty && _searchQuery.isEmpty && _selectedCategory == null
      ? _ngos
      : _filteredNGOs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;

  final CacheService _cacheService = CacheService();

  /// Initialize and load NGOs
  Future<void> init() async {
    await fetchNGOs();
  }

  /// Fetch NGOs (mock data)
  Future<void> fetchNGOs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Try to load from cache first
      final cachedNGOs = _cacheService.getCachedNGOList();
      if (cachedNGOs != null && cachedNGOs.isNotEmpty) {
        _ngos = cachedNGOs.map((json) => NGOModel.fromJson(json)).toList();
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Generate mock NGOs
      _ngos = _generateMockNGOs();

      // Cache the NGOs
      await _cacheService.cacheNGOList(
        _ngos.map((ngo) => ngo.toJson()).toList(),
      );

      _filteredNGOs = List.from(_ngos);
    } catch (e) {
      _errorMessage = 'Failed to load NGOs: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Generate mock NGO data
  List<NGOModel> _generateMockNGOs() {
    final uuid = const Uuid();
    return [
      NGOModel(
        id: uuid.v4(),
        email: 'contact@educateIndia.org',
        organizationName: 'Educate India',
        description: 'Providing quality education to underprivileged children across India. We believe every child deserves a chance to learn and grow.',
        category: 'Education',
        phoneNumber: '+91 98765 43210',
        website: 'www.educateindia.org',
        city: 'Mumbai',
        state: 'Maharashtra',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        isVerified: true,
        rating: 4.8,
        totalDonations: 1250,
        totalAmountReceived: 2500000,
        activeCampaigns: 5,
        totalVolunteers: 150,
      ),
      NGOModel(
        id: uuid.v4(),
        email: 'info@healthforall.org',
        organizationName: 'Health For All',
        description: 'Delivering healthcare services to rural communities. Free medical camps and health awareness programs.',
        category: 'Health',
        phoneNumber: '+91 98765 43211',
        website: 'www.healthforall.org',
        city: 'Delhi',
        state: 'Delhi',
        createdAt: DateTime.now().subtract(const Duration(days: 730)),
        isVerified: true,
        rating: 4.7,
        totalDonations: 980,
        totalAmountReceived: 1800000,
        activeCampaigns: 3,
        totalVolunteers: 85,
      ),
      NGOModel(
        id: uuid.v4(),
        email: 'hello@greenearth.org',
        organizationName: 'Green Earth Initiative',
        description: 'Fighting climate change through tree plantation and environmental awareness. Join us in making Earth greener!',
        category: 'Environment',
        phoneNumber: '+91 98765 43212',
        website: 'www.greenearth.org',
        city: 'Bangalore',
        state: 'Karnataka',
        createdAt: DateTime.now().subtract(const Duration(days: 500)),
        isVerified: true,
        rating: 4.9,
        totalDonations: 1500,
        totalAmountReceived: 3200000,
        activeCampaigns: 8,
        totalVolunteers: 200,
      ),
      NGOModel(
        id: uuid.v4(),
        email: 'contact@animalrescue.org',
        organizationName: 'Animal Rescue Foundation',
        description: 'Rescuing and rehabilitating abandoned and injured animals. Every life matters.',
        category: 'Animal Welfare',
        phoneNumber: '+91 98765 43213',
        website: 'www.animalrescue.org',
        city: 'Pune',
        state: 'Maharashtra',
        createdAt: DateTime.now().subtract(const Duration(days: 450)),
        isVerified: true,
        rating: 4.6,
        totalDonations: 750,
        totalAmountReceived: 1200000,
        activeCampaigns: 4,
        totalVolunteers: 60,
      ),
      NGOModel(
        id: uuid.v4(),
        email: 'info@hopefoundation.org',
        organizationName: 'Hope Foundation',
        description: 'Empowering women and children through skill development and education programs.',
        category: 'Social Services',
        phoneNumber: '+91 98765 43214',
        city: 'Chennai',
        state: 'Tamil Nadu',
        createdAt: DateTime.now().subtract(const Duration(days: 600)),
        isVerified: true,
        rating: 4.5,
        totalDonations: 650,
        totalAmountReceived: 950000,
        activeCampaigns: 3,
        totalVolunteers: 45,
      ),
      NGOModel(
        id: uuid.v4(),
        email: 'contact@disasterrelief.org',
        organizationName: 'Disaster Relief India',
        description: 'Providing emergency relief during natural disasters. Quick response, effective action.',
        category: 'Disaster Relief',
        phoneNumber: '+91 98765 43215',
        website: 'www.disasterrelief.org',
        city: 'Kolkata',
        state: 'West Bengal',
        createdAt: DateTime.now().subtract(const Duration(days: 300)),
        isVerified: true,
        rating: 4.7,
        totalDonations: 890,
        totalAmountReceived: 1600000,
        activeCampaigns: 2,
        totalVolunteers: 120,
      ),
    ];
  }

  /// Search NGOs
  void searchNGOs(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filter by category
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  /// Apply all filters
  void _applyFilters() {
    _filteredNGOs = _ngos.where((ngo) {
      final matchesSearch = _searchQuery.isEmpty ||
          ngo.organizationName.toLowerCase().contains(_searchQuery) ||
          (ngo.description?.toLowerCase().contains(_searchQuery) ?? false);

      final matchesCategory = _selectedCategory == null ||
          ngo.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  /// Clear filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _filteredNGOs = List.from(_ngos);
    notifyListeners();
  }

  /// Get NGO by ID
  NGOModel? getNGOById(String id) {
    try {
      return _ngos.firstWhere((ngo) => ngo.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get featured NGOs (top rated)
  List<NGOModel> getFeaturedNGOs() {
    final featured = List<NGOModel>.from(_ngos);
    featured.sort((a, b) => b.rating.compareTo(a.rating));
    return featured.take(5).toList();
  }

  /// Get NGOs by category
  List<NGOModel> getNGOsByCategory(String category) {
    return _ngos.where((ngo) => ngo.category == category).toList();
  }

  /// Toggle favorite
  Future<void> toggleFavorite(String ngoId) async {
    if (_cacheService.isFavorite(ngoId)) {
      await _cacheService.removeFromFavorites(ngoId);
    } else {
      await _cacheService.addToFavorites(ngoId);
    }
    notifyListeners();
  }

  /// Check if NGO is favorite
  bool isFavorite(String ngoId) {
    return _cacheService.isFavorite(ngoId);
  }

  /// Get favorite NGOs
  List<NGOModel> getFavoriteNGOs() {
    final favoriteIds = _cacheService.getFavoriteNGOs();
    return _ngos.where((ngo) => favoriteIds.contains(ngo.id)).toList();
  }
}

/// Interview Explanation:
/// "NGOProvider manages all NGO data with:
/// 
/// 1. Caching Strategy: Fast data access
///    - Checks cache first
///    - Falls back to API/mock data
///    - Reduces loading times
/// 
/// 2. Search & Filter: Dynamic updates
///    - Real-time search
///    - Category filtering
///    - Combined filters work together
/// 
/// 3. Favorites: User preferences
///    - Toggle favorite state
///    - Persists across sessions
///    - Fast lookup
/// 
/// 4. Helper Methods: Convenience
///    - Get by ID
///    - Get featured
///    - Get by category
/// 
/// 5. Mock Data: Realistic testing
///    - Variety of NGOs
///    - Different categories
///    - Realistic statistics
/// 
/// This provider is production-ready and can
/// easily be connected to a real API!"
