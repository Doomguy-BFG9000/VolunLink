import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/features/shared/screens/role_selection_screen.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/widgets/custom_button.dart';

/// OnboardingScreen - Shows tutorial slides to new users
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding content
  final List<OnboardingContent> _pages = [
    OnboardingContent(
      icon: Icons.search,
      title: StringConstants.onboarding1Title,
      description: StringConstants.onboarding1Description,
      color: AppColors.categoryEducation,
    ),
    OnboardingContent(
      icon: Icons.favorite,
      title: StringConstants.onboarding2Title,
      description: StringConstants.onboarding2Description,
      color: AppColors.secondary,
    ),
    OnboardingContent(
      icon: Icons.analytics,
      title: StringConstants.onboarding3Title,
      description: StringConstants.onboarding3Description,
      color: AppColors.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Navigate to next page or finish onboarding
  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  /// Skip onboarding
  void _onSkip() {
    _finishOnboarding();
  }

  /// Finish onboarding and navigate to role selection
  Future<void> _finishOnboarding() async {
    // Mark onboarding as completed
    await StorageService().setBool(AppConstants.keyIsFirstTime, false);

    if (!mounted) return;

    // Navigate to role selection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            _buildSkipButton(),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Bottom section (dots + button)
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  /// Build skip button
  Widget _buildSkipButton() {
    if (_currentPage == _pages.length - 1) {
      return const SizedBox(height: 16);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: _onSkip,
          child: Text(
            StringConstants.skip,
            style: AppTextStyles.labelLarge(context, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  /// Build single onboarding page
  Widget _buildPage(OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: content.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              content.icon,
              size: 100,
              color: content.color,
            ),
          )
              .animate()
              .scale(
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .then()
              .shimmer(
                duration: 1500.ms,
                color: Colors.white.withOpacity(0.2),
              ),

          const SizedBox(height: 48),

          // Title
          Text(
            content.title,
            style: AppTextStyles.displayMedium(context),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 300.ms)
              .slideY(begin: 0.3, duration: 600.ms, delay: 300.ms),

          const SizedBox(height: 16),

          // Description
          Text(
            content.description,
            style: AppTextStyles.bodyLarge(
              context,
              color: AppTextStyles.getSecondaryTextColor(context),
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 500.ms)
              .slideY(begin: 0.3, duration: 600.ms, delay: 500.ms),
        ],
      ),
    );
  }

  /// Build bottom section (dots + button)
  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Page indicators (dots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => _buildDot(index),
            ),
          ),

          const SizedBox(height: 32),

          // Next/Get Started button
          CustomButton(
            text: _currentPage == _pages.length - 1
                ? StringConstants.getStarted
                : StringConstants.next,
            onPressed: _onNext,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  /// Build page indicator dot
  Widget _buildDot(int index) {
    final isActive = index == _currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.lightTextTertiary,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

/// OnboardingContent - Data class for onboarding pages
class OnboardingContent {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

/// Interview Explanation:
/// ----------------------
/// "OnboardingScreen teaches users about the app with:
/// 
/// 1. **PageView**: Swipeable pages
///    - Users can swipe between screens
///    - Smooth animations
///    - Familiar UX pattern
/// 
/// 2. **Page Indicators**: Visual feedback
///    - Dots show current page
///    - Active dot is larger
///    - Animated transitions
/// 
/// 3. **Skip Option**: User control
///    - Can skip if returning user
///    - Respects user's time
///    - Hidden on last page
/// 
/// 4. **Beautiful Animations**: Engaging UX
///    - Icons scale and shimmer
///    - Text fades and slides
///    - Staggered timing
///    - Professional polish
/// 
/// 5. **Persistent State**: Never shows again
///    - Saves completion to storage
///    - Only shows for new users
///    - Smooth returning experience
/// 
/// 6. **Clear Content**: Educational
///    - Explains key features
///    - Simple language
///    - Visual + text
///    - Easy to understand
/// 
/// This creates a great first impression and
/// helps users understand the app!"
