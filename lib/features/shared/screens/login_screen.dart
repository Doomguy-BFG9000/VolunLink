import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';
import 'package:volun_link/app/theme/app_text_styles.dart';
import 'package:volun_link/core/widgets/custom_text_filed.dart';
import 'package:volun_link/features/ngo/screens/main_screen.dart';
import 'package:volun_link/features/user/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/providers/auth_provider.dart';
import 'signup_screen.dart';

/// LoginScreen - User authentication screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Remember me checkbox
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle login
  Future<void> _handleLogin() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get auth provider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Attempt login
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      // Login successful - navigate to home
      if (authProvider.isUserType) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const UserMainScreen()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const NGOMainScreen()),
          (route) => false,
        );
      }
    } else {
      // Login failed - show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Login failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Header
                _buildHeader(context, authProvider),

                const SizedBox(height: 48),

                // Email field
                CustomTextField(
                  controller: _emailController,
                  label: StringConstants.email,
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  enabled: !authProvider.isLoading,
                ),

                const SizedBox(height: 20),

                // Password field
                CustomTextField(
                  controller: _passwordController,
                  label: StringConstants.password,
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outlined,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringConstants.requiredField;
                    }
                    return null;
                  },
                  enabled: !authProvider.isLoading,
                ),

                const SizedBox(height: 16),

                // Remember me & Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Remember me checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: authProvider.isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                          activeColor: AppColors.primary,
                        ),
                        Text(
                          StringConstants.rememberMe,
                          style: AppTextStyles.bodyMedium(context),
                        ),
                      ],
                    ),

                    // Forgot password
                    TextButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () {
                              // TODO: Navigate to forgot password screen
                            },
                      child: Text(
                        StringConstants.forgotPassword,
                        style: AppTextStyles.labelMedium(
                          context,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Login button
                CustomButton(
                  text: StringConstants.login,
                  onPressed: authProvider.isLoading ? null : _handleLogin,
                  isLoading: authProvider.isLoading,
                ),

                const SizedBox(height: 24),

                // Divider with "or"
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringConstants.orContinueWith,
                        style: AppTextStyles.bodySmall(
                          context,
                          color: AppTextStyles.getSecondaryTextColor(context),
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Social login buttons
                _buildSocialButtons(authProvider),

                const SizedBox(height: 32),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.dontHaveAccount,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    TextButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },
                      child: Text(
                        StringConstants.signupHere,
                        style: AppTextStyles.labelLarge(
                          context,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build header section
  Widget _buildHeader(BuildContext context, AuthProvider authProvider) {
    return Column(
      children: [
        // Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            authProvider.isUserType ? Icons.person : Icons.business,
            size: 40,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 24),

        // Title
        Text(
          StringConstants.welcomeBack,
          style: AppTextStyles.displayMedium(context),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          authProvider.isUserType
              ? 'Login to continue as User'
              : 'Login to continue as NGO',
          style: AppTextStyles.bodyLarge(
            context,
            color: AppTextStyles.getSecondaryTextColor(context),
          ),
        ),
      ],
    );
  }

  /// Build social login buttons
  Widget _buildSocialButtons(AuthProvider authProvider) {
    return Row(
      children: [
        // Google button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: authProvider.isLoading
                ? null
                : () {
                    // TODO: Implement Google login
                  },
            icon: const Icon(Icons.g_mobiledata, size: 24),
            label: Text(StringConstants.google),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Facebook button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: authProvider.isLoading
                ? null
                : () {
                    // TODO: Implement Facebook login
                  },
            icon: const Icon(Icons.facebook, size: 24),
            label: Text(StringConstants.facebook),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}

/// Interview Explanation:
/// ----------------------
/// "LoginScreen implements production-ready patterns:
/// 
/// 1. **Form Validation**: Using GlobalKey<FormState>
///    - Validates before submission
///    - Shows field-specific errors
///    - Prevents invalid data
/// 
/// 2. **Loading States**: Disables UI during login
///    - Prevents multiple submissions
///    - Shows loading indicator
///    - Better UX
/// 
/// 3. **Error Handling**: Shows user-friendly errors
///    - SnackBar for errors
///    - Clear error messages
///    - Can retry easily
/// 
/// 4. **Remember Me**: User convenience
///    - Stays logged in
///    - Checkbox state
///    - Can implement with secure storage
/// 
/// 5. **Social Login Placeholders**: Future-ready
///    - Google and Facebook buttons
///    - Easy to implement later
///    - Industry standard
/// 
/// 6. **Navigation**: Proper route management
///    - pushAndRemoveUntil clears stack
///    - Can't go back to login
///    - Different routes for User/NGO
/// 
/// 7. **Responsive Design**: Works on all screens
///    - ScrollView for small screens
///    - Proper spacing
///    - Touch-friendly targets"
