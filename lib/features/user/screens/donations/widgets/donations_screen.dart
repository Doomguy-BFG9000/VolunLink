import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/core/constants/string_constants.dart';
import 'package:volun_link/core/widgets/empty_state.dart';
import 'package:volun_link/data/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// DonationsScreen - User's donation history and stats
class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.myDonations), elevation: 0),
      body: Column(
        children: [
          // Stats summary
          _buildStatsCard(context, user),

          // Donation history
          Expanded(
            child:
                user?.totalDonations == 0
                    ? EmptyStateWidget(
                      icon: Icons.favorite_border,
                      title: StringConstants.noDonationsYet,
                      message: StringConstants.startDonating,
                      buttonText: 'Explore NGOs',
                      onButtonPressed: () {
                        // Navigate to discover tab
                        DefaultTabController.of(context)?.animateTo(1);
                      },
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 5, // Mock data
                      itemBuilder: (context, index) {
                        return _buildDonationCard(context, index);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  /// Build stats card
  Widget _buildStatsCard(BuildContext context, user) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total Donated',
            style: AppTextStyles.bodyLarge(context, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${user?.totalAmountDonated.toStringAsFixed(0) ?? "0"}',
            style: AppTextStyles.displayMedium(context, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                'Donations',
                '${user?.totalDonations ?? 0}',
                Icons.favorite,
              ),
              _buildStatItem(context, 'NGOs Supported', '3', Icons.business),
            ],
          ),
        ],
      ),
    );
  }

  /// Build stat item
  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleLarge(context, color: Colors.white),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall(context, color: Colors.white70),
        ),
      ],
    );
  }

  /// Build donation card
  Widget _buildDonationCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.favorite, color: AppColors.success),
        ),
        title: Text(
          'Donation to NGO ${index + 1}',
          style: AppTextStyles.titleMedium(context),
        ),
        subtitle: Text(
          '${DateTime.now().subtract(Duration(days: index * 7)).toString().split(' ')[0]}',
          style: AppTextStyles.bodySmall(
            context,
            color: AppTextStyles.getSecondaryTextColor(context),
          ),
        ),
        trailing: Text(
          '₹${(1000 * (index + 1))}',
          style: AppTextStyles.titleMedium(context, color: AppColors.success),
        ),
      ),
    );
  }
}
