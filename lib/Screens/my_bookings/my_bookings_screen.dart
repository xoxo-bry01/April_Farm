import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_colours.dart';
import '../../providers/booking_provider.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    // Uses filtered list so customer only sees their own bookings
    final bookings = bookingProvider.userBookings;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No bookings found.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (ctx, index) {
                final booking = bookings[index];
                return Card(
                  color: AppColors.cardSurface,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      booking.serviceName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Rider: ${booking.customerName}\nDate: ${booking.date.day}/${booking.date.month}/${booking.date.year}'
                      '${booking.specialNotes.isNotEmpty ? "\nNotes: ${booking.specialNotes}" : ""}',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.redAccent),
                      onPressed: () {
                        bookingProvider.cancelBooking(booking.id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
