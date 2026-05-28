import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'custom_button.dart';

/// EmptyStateWidget - Shows when no data is available
/// Better UX than showing blank screen
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? customIllustration;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.customIllustration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon or Custom Illustration
            if (customIllustration != null)
              customIllustration!
            else
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: AppTextStyles.headlineMedium(context),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: AppTextStyles.bodyMedium(
                context,
                color: AppTextStyles.getSecondaryTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Optional Action Button
            if (buttonText != null && onButtonPressed != null)
              CustomButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}

/// ErrorStateWidget - Shows when an error occurs
class ErrorStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    this.title = 'Oops! Something went wrong',
    this.message = 'We encountered an error. Please try again.',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: AppColors.error,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              title,
              style: AppTextStyles.headlineMedium(context),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              message,
              style: AppTextStyles.bodyMedium(
                context,
                color: AppTextStyles.getSecondaryTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            if (onRetry != null)
              CustomButton(
                text: 'Try Again',
                onPressed: onRetry,
                icon: Icons.refresh,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}

/// NoInternetWidget - Shows when no internet connection
class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off,
                size: 60,
                color: AppColors.warning,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'No Internet Connection',
              style: AppTextStyles.headlineMedium(context),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              'Please check your internet connection and try again.',
              style: AppTextStyles.bodyMedium(
                context,
                color: AppTextStyles.getSecondaryTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            if (onRetry != null)
              CustomButton(
                text: 'Retry',
                onPressed: onRetry,
                icon: Icons.refresh,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}

/// Usage Examples:
/// 
/// 1. No NGOs Found:
/// EmptyStateWidget(
///   icon: Icons.search_off,
///   title: 'No NGOs Found',
///   message: 'Try adjusting your filters or search term',
///   buttonText: 'Clear Filters',
///   onButtonPressed: () => _clearFilters(),
/// )
/// 
/// 2. No Donations Yet:
/// EmptyStateWidget(
///   icon: Icons.favorite_border,
///   title: 'No Donations Yet',
///   message: 'Start making a difference today!',
///   buttonText: 'Explore NGOs',
///   onButtonPressed: () => _navigateToDiscover(),
/// )
/// 
/// 3. Error State:
/// ErrorStateWidget(
///   onRetry: () => _fetchData(),
/// )
/// 
/// 4. No Internet:
/// NoInternetWidget(
///   onRetry: () => _retryConnection(),
/// )

/// Interview Tip:
/// "Empty states improve UX by:
/// 1. Explaining why screen is empty
/// 2. Guiding users on what to do next
/// 3. Being more engaging than blank screens
/// 4. Showing app is working, just no data yet"
