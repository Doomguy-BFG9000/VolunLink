import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_theme.dart';
import 'package:volun_link/core/constants/app_constants.dart';
import 'package:volun_link/data/providers/theme_provider.dart';
import 'package:volun_link/features/splash/screens/splash_screen.dart';
import 'package:provider/provider.dart';

/// NGOScoutApp - Main application widget
class NGOScoutApp extends StatelessWidget {
  const NGOScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          // App Info
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // Theme Configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          // Initial Route
          home: const SplashScreen(),

          // Builder for MediaQuery initialization
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(
                  1.0,
                ), // Prevent text scaling
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

/// Interview Tip:
/// "NGOScoutApp configures:
/// 1. Theme switching (light/dark)
/// 2. Text scaling prevention for consistent UI
/// 3. Clean navigation from splash screen
/// 4. Production-ready setup"
