import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/string_constants.dart';
import '../../../data/providers/bottom_nav_provider.dart';
import '../../../data/providers/auth_provider.dart';

/// NGOMainScreen - Main navigation for NGO users
class NGOMainScreen extends StatelessWidget {
  const NGOMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: const _NGOMainScreenContent(),
    );
  }
}

class _NGOMainScreenContent extends StatelessWidget {
  const _NGOMainScreenContent();

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomNavProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final ngo = authProvider.currentNGO;

    // Screens for NGO
    final screens = [
      _NGODashboardScreen(ngo: ngo),
      _NGOCampaignsScreen(),
      _NGOVolunteersScreen(),
      _NGOProfileScreen(ngo: ngo),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: navProvider.setIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: StringConstants.dashboard,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            activeIcon: Icon(Icons.campaign),
            label: StringConstants.campaigns,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: StringConstants.volunteers,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: StringConstants.profile,
          ),
        ],
      ),
    );
  }
}

/// NGO Dashboard Screen (Simplified)
class _NGODashboardScreen extends StatelessWidget {
  final dynamic ngo;
  const _NGODashboardScreen({required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${ngo?.organizationName ?? "NGO"}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _StatCard(title: 'Donations', value: '${ngo?.totalDonations ?? 0}', color: AppColors.secondary)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Campaigns', value: '${ngo?.activeCampaigns ?? 0}', color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatCard(title: 'Volunteers', value: '${ngo?.totalVolunteers ?? 0}', color: AppColors.success)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(title: 'Total Received', value: '₹${_formatAmount(ngo?.totalAmountReceived ?? 0)}', color: AppColors.info)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) return '${(amount / 100000).toStringAsFixed(1)}L';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(0);
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// Placeholder screens
class _NGOCampaignsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campaigns')),
      body: const Center(child: Text('Campaigns Screen - Coming Soon')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _NGOVolunteersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Volunteers')),
      body: const Center(child: Text('Volunteers Screen - Coming Soon')),
    );
  }
}

class _NGOProfileScreen extends StatelessWidget {
  final dynamic ngo;
  const _NGOProfileScreen({required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Text(ngo?.getInitials() ?? 'N', style: const TextStyle(color: Colors.white, fontSize: 32)),
            ),
            const SizedBox(height: 16),
            Text(ngo?.organizationName ?? 'NGO', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(ngo?.email ?? '', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
