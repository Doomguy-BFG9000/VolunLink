import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/core/constants/string_constants.dart';
import 'package:volun_link/data/providers/auth_provider.dart';
import 'package:volun_link/data/providers/theme_provider.dart';
import 'package:volun_link/features/shared/screens/role_selection_screen.dart';
import 'package:provider/provider.dart';

/// ProfileScreen - User profile and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.myProfile), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile header
            _buildProfileHeader(context, user),
            const SizedBox(height: 24),

            // Profile options
            _buildMenuItem(
              context,
              icon: Icons.edit,
              title: StringConstants.editProfile,
              onTap: () {
                // TODO: Navigate to edit profile
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.favorite,
              title: 'My Favorites',
              onTap: () {
                // TODO: Navigate to favorites
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.settings,
              title: StringConstants.settings,
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return _buildMenuItem(
                  context,
                  icon: Icons.dark_mode,
                  title: StringConstants.darkMode,
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.help,
              title: StringConstants.helpCenter,
              onTap: () {
                // TODO: Navigate to help
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.info,
              title: StringConstants.aboutUs,
              onTap: () {
                // TODO: Show about
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.logout,
              title: StringConstants.logout,
              onTap: () => _handleLogout(context, authProvider),
              iconColor: AppColors.error,
              textColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  /// Build profile header
  Widget _buildProfileHeader(BuildContext context, user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Text(
              user?.getInitials() ?? 'U',
              style: AppTextStyles.displaySmall(
                context,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            user?.fullName ?? 'User',
            style: AppTextStyles.headlineMedium(context, color: Colors.white),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            user?.email ?? '',
            style: AppTextStyles.bodyMedium(context, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// Build menu item
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
    Color? textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? AppColors.primary),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge(context, color: textColor),
        ),
        trailing:
            trailing ??
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTextStyles.getSecondaryTextColor(context),
            ),
        onTap: onTap,
      ),
    );
  }

  /// Handle logout
  Future<void> _handleLogout(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(StringConstants.logout),
            content: Text(StringConstants.confirmLogout),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(StringConstants.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  StringConstants.logout,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      await authProvider.logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        (route) => false,
      );
    }
  }
}
