import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/features/ngo/screens/main_screen.dart';
import 'package:volun_link/features/onboarding/onboarding.screen.dart';
import 'package:volun_link/features/user/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/providers/auth_provider.dart';


/// SplashScreen - First screen shown when app launches
/// Shows logo with animation, checks auth status, navigates appropriately
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Initialize app and navigate to appropriate screen
  Future<void> _initializeApp() async {
    // Initialize auth provider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.init();

    // Check if first time opening app
    final isFirstTime = StorageService().getBool(AppConstants.keyIsFirstTime) ?? true;

    // Wait for minimum splash duration (for better UX)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navigate based on auth status
    if (isFirstTime) {
      // First time - show onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else if (authProvider.isAuthenticated) {
      // User is logged in - go to home
      if (authProvider.isUserType) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserMainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NGOMainScreen()),
        );
      }
    } else {
      // Not logged in - go to onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with animation
            _buildLogo(),
            
            const SizedBox(height: 24),
            
            // App name with animation
            _buildAppName(context),
            
            const SizedBox(height: 8),
            
            // Tagline with animation
            _buildTagline(context),
            
            const SizedBox(height: 60),
            
            // Loading indicator
            _buildLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  /// Build animated logo
  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.favorite,
        size: 60,
        color: AppColors.primary,
      ),
    )
        .animate()
        .scale(
          duration: 600.ms,
          curve: Curves.easeOutBack,
        )
        .then()
        .shimmer(
          duration: 1000.ms,
          color: Colors.white.withOpacity(0.3),
        );
  }

  /// Build animated app name
  Widget _buildAppName(BuildContext context) {
    return Text(
      AppConstants.appName,
      style: AppTextStyles.displayLarge(context, color: Colors.white),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: 300.ms,
        )
        .slideY(
          begin: 0.3,
          duration: 600.ms,
          delay: 300.ms,
          curve: Curves.easeOut,
        );
  }

  /// Build animated tagline
  Widget _buildTagline(BuildContext context) {
    return Text(
      AppConstants.appTagline,
      style: AppTextStyles.bodyLarge(context, color: Colors.white.withOpacity(0.9)),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: 600.ms,
        )
        .slideY(
          begin: 0.3,
          duration: 600.ms,
          delay: 600.ms,
          curve: Curves.easeOut,
        );
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 3,
      ),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: 900.ms,
        );
  }
}

/// Interview Explanation:
/// ----------------------
/// "The SplashScreen implements several best practices:
/// 
/// 1. **Smart Navigation**: Decides where to go based on:
///    - First time user → Onboarding
///    - Logged in user → Home screen
///    - Returning user → Onboarding/Login
/// 
/// 2. **Beautiful Animations**: Using flutter_animate
///    - Logo scales and shimmers
///    - Text fades and slides in
///    - Staggered timing for polish
///    - Professional feel
/// 
/// 3. **Loading State**: Shows progress
///    - Circular progress indicator
///    - User knows app is working
///    - Better perceived performance
/// 
/// 4. **Minimum Duration**: Ensures splash shows
///    - Even if loading is instant
///    - Users see branding
///    - Prevents jarring transition
/// 
/// 5. **Auth Check**: Restores session
///    - Checks if user was logged in
///    - Loads saved user data
///    - Seamless experience
/// 
/// 6. **Gradient Background**: Eye-catching
///    - Uses brand colors
///    - Professional look
///    - Sets tone for app
/// 
/// This creates a polished first impression that
/// recruiters will notice!"
