import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/core/widgets/empty_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../data/providers/auth_provider.dart';
import '../../../../data/providers/ngo_provider.dart';
import '../discover/ngo_detail_screen.dart';

/// UserHomeScreen - Main dashboard for users
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize NGO data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NGOProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final ngoProvider = Provider.of<NGOProvider>(context);

    return Scaffold(
      body: SafeArea(
        child:
            ngoProvider.isLoading
                ? const LoadingWidget(message: 'Loading NGOs...')
                : ngoProvider.errorMessage != null
                ? ErrorStateWidget(
                  message: ngoProvider.errorMessage!,
                  onRetry: () => ngoProvider.fetchNGOs(),
                )
                : RefreshIndicator(
                  onRefresh: () => ngoProvider.fetchNGOs(),
                  child: CustomScrollView(
                    slivers: [
                      // App bar with greeting
                      _buildAppBar(authProvider),

                      // Statistics cards
                      _buildStatsSection(authProvider),

                      // Categories
                      _buildCategoriesSection(context, ngoProvider),

                      // Featured NGOs
                      _buildFeaturedSection(context, ngoProvider),

                      // Bottom padding
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    ],
                  ),
                ),
      ),
    );
  }

  /// Build app bar with greeting
  Widget _buildAppBar(AuthProvider authProvider) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                  '${_getGreeting()}, ${authProvider.currentUser?.fullName.split(' ')[0] ?? 'User'}!',
                  style: AppTextStyles.displaySmall(context),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideX(begin: -0.2, duration: 600.ms),
            const SizedBox(height: 8),
            Text(
                  'Discover NGOs making a difference',
                  style: AppTextStyles.bodyLarge(
                    context,
                    color: AppTextStyles.getSecondaryTextColor(context),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideX(begin: -0.2, duration: 600.ms, delay: 200.ms),
          ],
        ),
      ),
    );
  }

  /// Get greeting based on time
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  /// Build statistics section
  Widget _buildStatsSection(AuthProvider authProvider) {
    final user = authProvider.currentUser;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.favorite,
                    label: 'Donations',
                    value: '${user?.totalDonations ?? 0}',
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.currency_rupee,
                    label: 'Total Given',
                    value: '₹${_formatAmount(user?.totalAmountDonated ?? 0)}',
                    color: AppColors.success,
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.2, duration: 600.ms, delay: 400.ms),
      ),
    );
  }

  /// Build single stat card
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineMedium(context, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall(
              context,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  /// Format amount (e.g., 5000 -> 5K)
  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }

  /// Build categories section
  Widget _buildCategoriesSection(
    BuildContext context,
    NGOProvider ngoProvider,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text(
              StringConstants.categories,
              style: AppTextStyles.headlineMedium(context),
            ),
          ),
          SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: AppConstants.ngoCategories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(
                      AppConstants.ngoCategories[index],
                      _getCategoryIcon(AppConstants.ngoCategories[index]),
                      AppColors.getCategoryColor(
                        AppConstants.ngoCategories[index],
                      ),
                      ngoProvider,
                    );
                  },
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .slideX(begin: 0.2, duration: 600.ms, delay: 600.ms),
        ],
      ),
    );
  }

  /// Build category card
  Widget _buildCategoryCard(
    String category,
    IconData icon,
    Color color,
    NGOProvider ngoProvider,
  ) {
    final count = ngoProvider.getNGOsByCategory(category).length;

    return GestureDetector(
      onTap: () {
        ngoProvider.filterByCategory(category);
        // Switch to discover tab
        DefaultTabController.of(context)?.animateTo(1);
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              category.split(' ')[0],
              style: AppTextStyles.bodySmall(context, color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text('$count NGOs', style: AppTextStyles.caption(context)),
          ],
        ),
      ),
    );
  }

  /// Get category icon
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'education':
        return Icons.school;
      case 'health':
        return Icons.favorite;
      case 'environment':
        return Icons.eco;
      case 'animal welfare':
        return Icons.pets;
      case 'social services':
        return Icons.people;
      case 'disaster relief':
        return Icons.warning;
      case 'arts & culture':
        return Icons.palette;
      case 'human rights':
        return Icons.balance;
      default:
        return Icons.category;
    }
  }

  /// Build featured NGOs section
  Widget _buildFeaturedSection(BuildContext context, NGOProvider ngoProvider) {
    final featuredNGOs = ngoProvider.getFeaturedNGOs();

    if (featuredNGOs.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.featuredNGOs,
                  style: AppTextStyles.headlineMedium(context),
                ),
                TextButton(
                  onPressed: () {
                    // Switch to discover tab
                    DefaultTabController.of(context)?.animateTo(1);
                  },
                  child: Text(StringConstants.viewAll),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featuredNGOs.length,
            itemBuilder: (context, index) {
              return _buildNGOCard(featuredNGOs[index], ngoProvider)
                  .animate()
                  .fadeIn(
                    duration: 600.ms,
                    delay: Duration(milliseconds: 800 + (index * 100)),
                  )
                  .slideX(
                    begin: 0.2,
                    duration: 600.ms,
                    delay: Duration(milliseconds: 800 + (index * 100)),
                  );
            },
          ),
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
                  // NGO logo/avatar
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
                              const Icon(
                                Icons.verified,
                                color: AppColors.primary,
                                size: 20,
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
                            Text(
                              ngo.getLocation() ?? 'India',
                              style: AppTextStyles.bodySmall(
                                context,
                                color: AppTextStyles.getSecondaryTextColor(
                                  context,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.star, size: 14, color: Colors.amber),
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
              // Category chip
              Chip(
                label: Text(ngo.category),
                backgroundColor: AppColors.getCategoryColor(
                  ngo.category,
                ).withOpacity(0.2),
                labelStyle: AppTextStyles.labelSmall(
                  context,
                  color: AppColors.getCategoryColor(ngo.category),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Interview Tip:
/// "Home screen demonstrates:
/// 1. Personalized greeting based on time
/// 2. User statistics in beautiful cards
/// 3. Category browsing with counts
/// 4. Featured NGOs (top-rated)
/// 5. Pull-to-refresh functionality
/// 6. Smooth animations with staggered delays
/// 7. Efficient with CustomScrollView"
