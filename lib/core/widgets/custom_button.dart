import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';

/// CustomButton - Reusable button component
/// Provides consistent button styling throughout the app
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
    this.borderRadius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if button is disabled
    final isDisabled = onPressed == null || isLoading;

    if (isOutlined) {
      return _buildOutlinedButton(context, isDisabled);
    } else {
      return _buildElevatedButton(context, isDisabled);
    }
  }

  /// Build elevated (filled) button
  Widget _buildElevatedButton(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.white,
          disabledBackgroundColor: AppColors.lightTextTertiary,
          elevation: isDisabled ? 0 : 2,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  /// Build outlined button
  Widget _buildOutlinedButton(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: backgroundColor ?? AppColors.primary,
          disabledForegroundColor: AppColors.lightTextTertiary,
          side: BorderSide(
            color: isDisabled 
                ? AppColors.lightTextTertiary 
                : (backgroundColor ?? AppColors.primary),
            width: 2,
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  /// Build button content (text, icon, loading indicator)
  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined 
                ? (backgroundColor ?? AppColors.primary) 
                : (textColor ?? Colors.white),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTextStyles.button(
              context,
              color: isOutlined 
                  ? (backgroundColor ?? AppColors.primary) 
                  : (textColor ?? Colors.white),
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppTextStyles.button(
        context,
        color: isOutlined 
            ? (backgroundColor ?? AppColors.primary) 
            : (textColor ?? Colors.white),
      ),
    );
  }
}

/// Usage Examples:
/// 
/// 1. Basic Button:
/// CustomButton(
///   text: 'Login',
///   onPressed: () => _handleLogin(),
/// )
/// 
/// 2. Loading State:
/// CustomButton(
///   text: 'Logging in...',
///   isLoading: true,
///   onPressed: null, // Disabled while loading
/// )
/// 
/// 3. Outlined Button:
/// CustomButton(
///   text: 'Sign Up',
///   isOutlined: true,
///   onPressed: () => _navigateToSignup(),
/// )
/// 
/// 4. Button with Icon:
/// CustomButton(
///   text: 'Donate Now',
///   icon: Icons.favorite,
///   onPressed: () => _openDonationPage(),
/// )
/// 
/// 5. Full Width Button:
/// CustomButton(
///   text: 'Continue',
///   width: double.infinity,
///   onPressed: () => _continue(),
/// )
/// 
/// 6. Custom Colors:
/// CustomButton(
///   text: 'Delete',
///   backgroundColor: Colors.red,
///   onPressed: () => _deleteItem(),
/// )

/// Interview Explanation:
/// "I created CustomButton as a reusable component because:
/// 
/// 1. Consistency: All buttons look the same across the app
/// 2. Maintainability: Change button style in one place
/// 3. Features: Built-in loading state, icons, disabled state
/// 4. Flexibility: Can customize colors, sizes, styles
/// 5. DRY Principle: Don't repeat button code everywhere"
