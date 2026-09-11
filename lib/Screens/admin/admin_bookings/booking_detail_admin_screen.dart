import 'package:flutter/material.dart';
import '../../../app_colours.dart';
import 'cancel_booking_admin_screen.dart';
import 'edit_booking_admin_screen.dart';

class BookingDetailAdminScreen extends StatelessWidget {
  final Map<String, String>? bookingData;

  const BookingDetailAdminScreen({super.key, this.bookingData});

  @override
  Widget build(BuildContext context) {
    final String rider = bookingData?['rider'] ?? 'Sarah Jenkins';
    final String bookingId = bookingData?['id'] ?? 'BK-1001';
    final String arena = bookingData?['arena'] ?? 'Indoor Arena 1';
    final String date = bookingData?['date'] ?? '12/09/2026';
    final String time = bookingData?['time'] ?? '09:00 AM - 10:00 AM';
    final String status = bookingData?['status'] ?? 'Confirmed';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          bookingId,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primaryOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditBookingAdminScreen(bookingData: bookingData),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Rider Name', rider),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow('Facility', arena),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow('Date', date),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow('Time Slot', time),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow('Status', status, isHighlight: true),
                  ],
                ),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CancelBookingAdminScreen(bookingId: bookingId),
                      ),
                    );
                  },
                  child: const Text(
                    'Cancel Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlight
                ? AppColors.primaryOrange
                : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
