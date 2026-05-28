import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/core/widgets/empty_state.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/providers/ngo_provider.dart';
import 'ngo_detail_screen.dart';

/// DiscoverScreen - Search and browse NGOs
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ngoProvider = Provider.of<NGOProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.discover), elevation: 0),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(ngoProvider),

          // Filter chips
          _buildFilterChips(ngoProvider),

          // NGO list
          Expanded(
            child:
                ngoProvider.ngos.isEmpty
                    ? EmptyStateWidget(
                      icon: Icons.search_off,
                      title: StringConstants.noNGOsFound,
                      message: StringConstants.tryDifferentFilters,
                      buttonText: StringConstants.clearFilters,
                      onButtonPressed: () {
                        _searchController.clear();
                        ngoProvider.clearFilters();
                      },
                    )
                    : RefreshIndicator(
                      onRefresh: () => ngoProvider.fetchNGOs(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: ngoProvider.ngos.length,
                        itemBuilder: (context, index) {
                          final ngo = ngoProvider.ngos[index];
                          return _buildNGOCard(ngo, ngoProvider);
                        },
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar(NGOProvider ngoProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => ngoProvider.searchNGOs(value),
        decoration: InputDecoration(
          hintText: StringConstants.searchNGOs,
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ngoProvider.searchNGOs('');
                    },
                  )
                  : null,
          filled: true,
          fillColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkCard
                  : AppColors.lightBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  /// Build filter chips
  Widget _buildFilterChips(NGOProvider ngoProvider) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // All filter chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('All'),
              selected: ngoProvider.selectedCategory == null,
              onSelected: (_) => ngoProvider.filterByCategory(null),
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.primary,
            ),
          ),
          // Category chips
          ...AppConstants.ngoCategories.map((category) {
            final count = ngoProvider.getNGOsByCategory(category).length;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text('$category ($count)'),
                selected: ngoProvider.selectedCategory == category,
                onSelected: (_) {
                  if (ngoProvider.selectedCategory == category) {
                    ngoProvider.filterByCategory(null);
                  } else {
                    ngoProvider.filterByCategory(category);
                  }
                },
                selectedColor: AppColors.getCategoryColor(
                  category,
                ).withOpacity(0.2),
                checkmarkColor: AppColors.getCategoryColor(category),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  /// Build NGO card
  Widget _buildNGOCard(ngo, NGOProvider ngoProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NGODetailScreen(ngo: ngo)),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // NGO avatar
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.getCategoryColor(ngo.category),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        ngo.getInitials(),
                        style: AppTextStyles.headlineMedium(
                          context,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // NGO info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ngo.organizationName,
                                style: AppTextStyles.titleLarge(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (ngo.isVerified)
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.verified,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppTextStyles.getSecondaryTextColor(
                                context,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                ngo.getLocation() ?? 'India',
                                style: AppTextStyles.bodySmall(
                                  context,
                                  color: AppTextStyles.getSecondaryTextColor(
                                    context,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              ngo.rating.toStringAsFixed(1),
                              style: AppTextStyles.bodySmall(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Favorite button
                  IconButton(
                    icon: Icon(
                      ngoProvider.isFavorite(ngo.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          ngoProvider.isFavorite(ngo.id)
                              ? AppColors.secondary
                              : null,
                    ),
                    onPressed: () {
                      ngoProvider.toggleFavorite(ngo.id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                ngo.description ?? '',
                style: AppTextStyles.bodyMedium(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Footer
              Row(
                children: [
                  // Category
                  Chip(
                    label: Text(ngo.category),
                    backgroundColor: AppColors.getCategoryColor(
                      ngo.category,
                    ).withOpacity(0.2),
                    labelStyle: AppTextStyles.labelSmall(
                      context,
                      color: AppColors.getCategoryColor(ngo.category),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  const Spacer(),
                  // Stats
                  _buildStatItem(Icons.favorite, '${ngo.totalDonations}'),
                  const SizedBox(width: 16),
                  _buildStatItem(Icons.people, '${ngo.totalVolunteers}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build stat item
  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTextStyles.getSecondaryTextColor(context),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.bodySmall(
            context,
            color: AppTextStyles.getSecondaryTextColor(context),
          ),
        ),
      ],
    );
  }
}

/// Interview Explanation:
/// "DiscoverScreen provides powerful search with:
/// 
/// 1. Real-time Search: Instant results
///    - Updates as user types
///    - No search button needed
///    - Fast and responsive
/// 
/// 2. Category Filters: Easy browsing
///    - Horizontal scrolling chips
///    - Shows count per category
///    - Visual feedback when selected
/// 
/// 3. Combined Filters: Smart filtering
///    - Search + category work together
///    - Can clear individually
///    - Maintains state
/// 
/// 4. Empty State: Helpful guidance
///    - Shows when no results
///    - Suggests clearing filters
///    - Better than blank screen
/// 
/// 5. Pull-to-Refresh: Data freshness
///    - Standard gesture
///    - Updates NGO list
///    - Good UX pattern"
