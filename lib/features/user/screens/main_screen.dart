import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/features/user/screens/donations/widgets/donations_screen.dart';
import 'package:volun_link/features/user/screens/profile/widgets/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/string_constants.dart';
import '../../../data/providers/bottom_nav_provider.dart';
import 'home/home_screen.dart';
import 'discover/discover_screen.dart';

/// UserMainScreen - Main navigation wrapper for users
/// Contains bottom navigation bar and screens
class UserMainScreen extends StatelessWidget {
  const UserMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: const _UserMainScreenContent(),
    );
  }
}

class _UserMainScreenContent extends StatelessWidget {
  const _UserMainScreenContent();

  // List of screens
  static final List<Widget> _screens = [
    const UserHomeScreen(),
    const DiscoverScreen(),
    const DonationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: IndexedStack(index: navProvider.currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavBar(context, navProvider),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavBar(
    BuildContext context,
    BottomNavProvider navProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: navProvider.setIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: StringConstants.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: StringConstants.discover,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: StringConstants.donations,
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

/// Interview Explanation:
/// "UserMainScreen uses IndexedStack for navigation:
/// 
/// 1. IndexedStack: Preserves screen state
///    - Screens don't rebuild when switching tabs
///    - Scroll positions maintained
///    - Better performance
///    - Better UX
/// 
/// 2. Separate Provider: Clean architecture
///    - Navigation state isolated
///    - Easy to test
///    - Can access from anywhere
/// 
/// 3. Icon States: Visual feedback
///    - Different icons for active/inactive
///    - Clear current selection
///    - Material Design pattern"
