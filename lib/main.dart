import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <--- THIS is the missing import!
import 'providers/booking_provider.dart';
import 'Screens/splash_screen.dart';
import 'app_colours.dart';

void main() {
  runApp(
    // Wrap MyApp with ChangeNotifierProvider at the root level
    ChangeNotifierProvider(
      create: (context) => BookingProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'April Farm',
      
      // Everything you and ChatGPT built stays EXACTLY as it is!
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primaryOrange,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryOrange,
          surface: AppColors.cardSurface,
        ),
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
      
      // Your entry screen remains untouched
      home: const SplashScreen(),
    );
  }
}