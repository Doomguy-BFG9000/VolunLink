import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/string_constants.dart';
import '../../../data/providers/auth_provider.dart';
import 'login_screen.dart';

/// RoleSelectionScreen - User chooses between User or NGO role
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                StringConstants.selectRole,
                style: AppTextStyles.displayMedium(context),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.3, duration: 600.ms),

              const SizedBox(height: 48),

              // User card
              _buildRoleCard(
                context,
                icon: Icons.person,
                title: StringConstants.iAmUser,
                description: StringConstants.userDescription,
                gradient: AppColors.primaryGradient,
                onTap: () => _selectRole(context, UserType.user),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideX(begin: -0.3, duration: 600.ms, delay: 200.ms),

              const SizedBox(height: 24),

              // NGO card
              _buildRoleCard(
                context,
                icon: Icons.business,
                title: StringConstants.iAmNGO,
                description: StringConstants.ngoDescription,
                gradient: AppColors.secondaryGradient,
                onTap: () => _selectRole(context, UserType.ngo),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideX(begin: 0.3, duration: 600.ms, delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  /// Build role selection card
  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 20),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMedium(
                      context,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: AppTextStyles.bodyMedium(
                      context,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Handle role selection
  void _selectRole(BuildContext context, UserType userType) {
    // Set user type in provider
    Provider.of<AuthProvider>(context, listen: false).setUserType(userType);

    // Navigate to login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}

/// Interview Tip:
/// "Role selection provides clear choices with:
/// 1. Visual distinction (different gradients)
/// 2. Clear descriptions of each role
/// 3. Smooth animations for polish
/// 4. Easy tap targets
/// 5. Sets user type before login"
