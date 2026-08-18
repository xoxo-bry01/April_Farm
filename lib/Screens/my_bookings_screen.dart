import 'package:flutter/material.dart';
import '../app_colours.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for upcoming & past bookings
  final List<Map<String, String>> _upcomingBookings = [
    {
      'service': 'Arena Hire',
      'date': 'Wed, 19 Aug 2026',
      'time': '10:00 AM - 10:50 AM',
      'arena': 'Outdoor Arena',
      'status': 'Confirmed',
      'payment': 'Paid',
    },
    {
      'service': 'Private Lesson',
      'date': 'Fri, 21 Aug 2026',
      'time': '02:00 PM - 02:50 PM',
      'arena': 'Indoor Arena',
      'status': 'Confirmed',
      'payment': 'Invoice Pending',
    },
  ];

  final List<Map<String, String>> _pastBookings = [
    {
      'service': 'Group Lesson',
      'date': 'Mon, 10 Aug 2026',
      'time': '09:00 AM - 09:50 AM',
      'arena': 'Dressage Ring',
      'status': 'Completed',
      'payment': 'Paid',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryOrange,
          labelColor: AppColors.primaryOrange,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(_upcomingBookings, isUpcoming: true),
          _buildBookingList(_pastBookings, isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildBookingList(List<Map<String, String>> bookings, {required bool isUpcoming}) {
    if (bookings.isEmpty) {
      return const Center(
        child: Text(
          'No bookings found',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        final isPaid = booking['payment'] == 'Paid';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    booking['service']!,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      booking['payment']!,
                      style: TextStyle(
                        color: isPaid ? Colors.green : Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: AppColors.primaryOrange),
                  const SizedBox(width: 8),
                  Text(
                    booking['date']!,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppColors.primaryOrange),
                  const SizedBox(width: 8),
                  Text(
                    booking['time']!,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.place, size: 16, color: AppColors.primaryOrange),
                  const SizedBox(width: 8),
                  Text(
                    booking['arena']!,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
              if (isUpcoming) ...[
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cancellation request sent to owner.'),
                        backgroundColor: AppColors.primaryOrange,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel Booking',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}