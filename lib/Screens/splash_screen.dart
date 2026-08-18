import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import for the temporary paw icon
import '../app_colours.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Fade into the Login Screen after 2.5 seconds
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the device screen height dynamically
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 1. Top Section: Hero Image filling ~75% (3/4) of the screen height
          // Using a Container to handle background coloring/cropping boundaries
          Container(
            height: screenHeight * 0.75,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12, // Subtle background tint if needed
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background image (Now using BoxFit.contain for safety)
                Padding(
                  // Minor padding so the image doesn't press against the corner curves
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Image.asset(
                    'Assets/Images/login_image.jpeg', 
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain, // Ensures the ENTIRE photo is shown
                  ),
                ),

                // Centered Temporary Logo / Placeholder Badge (Moved here to match new look)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryOrange, width: 1.5),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.paw, // Temporary valid paw icon
                        size: 50,
                        color: AppColors.primaryOrange,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'APRIL FARM',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Bottom Section: Loading spinner in the remaining 25% space
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}