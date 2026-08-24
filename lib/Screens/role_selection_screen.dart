import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colours.dart';
import '../providers/booking_provider.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final activeBookingsCount = bookingProvider.userBookings.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to April Farm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Active System Bookings: $activeBookingsCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.pushNamed(context, '/customer_home'),
                child: const Text(
                  'Customer Portal',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryOrange),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.pushNamed(context, '/admin_home'),
                child: const Text(
                  'Admin Portal',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
