import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'app_colours.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the 'Debug' banner in the top corner
      title: 'April Farm',
      
      // Global App Theme Configuration
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primaryOrange,
        
        // Sets the default dark color scheme for the entire app
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryOrange,
          surface: AppColors.cardSurface,
          
        ),
        
        // Customizes app bar styling across all screens
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // The entry screen when the app opens
      home: const SplashScreen(),
    );
  }
}