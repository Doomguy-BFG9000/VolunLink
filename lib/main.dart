import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volun_link/app/app.dart/app.dart';
import 'package:provider/provider.dart';
import 'core/services/storage_service.dart';
import 'core/services/cache_service.dart';
import 'data/providers/auth_provider.dart';
import 'data/providers/ngo_provider.dart';
import 'data/providers/theme_provider.dart';

/// Main entry point of the application
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (portrait only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  await _initializeServices();

  // Run the app
  runApp(const MyApp());
}

/// Initialize all services before app starts
Future<void> _initializeServices() async {
  try {
    // Initialize StorageService (SharedPreferences)
    await StorageService().init();
    print('✅ StorageService initialized');

    // Initialize CacheService (Hive)
    await CacheService().init();
    print('✅ CacheService initialized');
  } catch (e) {
    print('❌ Error initializing services: $e');
  }
}

/// Main App Widget with Providers
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Theme Provider
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        
        // Auth Provider
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        
        // NGO Provider
        ChangeNotifierProvider(
          create: (_) => NGOProvider(),
        ),
      ],
      child: const NGOScoutApp(),
    );
  }
}

