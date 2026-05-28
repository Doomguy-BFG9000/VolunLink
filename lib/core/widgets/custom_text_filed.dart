import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volun_link/app/theme/app_colors.dart';

/// CustomTextField - Reusable text input component
/// Provides consistent text field styling with validation support
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20)
                : null,
            suffixIcon: _buildSuffixIcon(),
            filled: true,
            fillColor: widget.enabled
                ? (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkCard
                    : AppColors.lightSurface)
                : AppColors.lightTextTertiary.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.lightTextTertiary.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build suffix icon (password toggle or custom icon)
  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }
}

/// Usage Examples:
/// 
/// 1. Basic Text Field:
/// CustomTextField(
///   controller: _emailController,
///   label: 'Email',
///   hint: 'Enter your email',
///   prefixIcon: Icons.email,
/// )
/// 
/// 2. Password Field (with auto toggle):
/// CustomTextField(
///   controller: _passwordController,
///   label: 'Password',
///   hint: 'Enter your password',
///   obscureText: true,
///   prefixIcon: Icons.lock,
/// )
/// 
/// 3. With Validation:
/// CustomTextField(
///   controller: _emailController,
///   label: 'Email',
///   validator: Validators.validateEmail,
///   keyboardType: TextInputType.emailAddress,
/// )
/// 
/// 4. Multi-line (TextArea):
/// CustomTextField(
///   controller: _descriptionController,
///   label: 'Description',
///   hint: 'Tell us about your NGO',
///   maxLines: 5,
///   maxLength: 500,
/// )
/// 
/// 5. Phone Number with Formatting:
/// CustomTextField(
///   controller: _phoneController,
///   label: 'Phone',
///   keyboardType: TextInputType.phone,
///   inputFormatters: [
///     FilteringTextInputFormatter.digitsOnly,
///     LengthLimitingTextInputFormatter(10),
///   ],
/// )
/// 
/// 6. Read-only (for dates, selections):
/// CustomTextField(
///   controller: _dateController,
///   label: 'Date',
///   readOnly: true,
///   onTap: () => _pickDate(),
///   suffixIcon: Icon(Icons.calendar_today),
/// )

/// Interview Explanation:
/// "CustomTextField provides:
/// 
/// 1. Consistency: All text fields have same look/feel
/// 2. Built-in Features:
///    - Automatic password visibility toggle
///    - Label and hint text support
///    - Error message display
///    - Prefix/suffix icons
/// 3. Validation: Easy integration with validator functions
/// 4. Responsive: Adapts to light/dark theme
/// 5. Flexibility: Supports all TextFormField features"
