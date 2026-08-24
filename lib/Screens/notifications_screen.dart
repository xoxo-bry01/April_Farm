import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colours.dart';
import '../providers/booking_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final notifications = bookingProvider.notifications;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No new notifications.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (ctx, index) {
                return Card(
                  color: AppColors.cardSurface,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications_active,
                      color: AppColors.primaryOrange,
                    ),
                    title: Text(
                      notifications[index],
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
