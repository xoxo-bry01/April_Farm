import 'package:flutter/material.dart';
import '../../../app_colours.dart';
import 'add_booking_screen.dart';
import 'booking_detail_admin_screen.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Pending', 'Confirmed', 'Cancelled'];

  final List<Map<String, String>> _bookings = [
    {
      'id': 'BK-1001',
      'rider': 'Sarah Jenkins',
      'arena': 'Indoor Arena 1',
      'date': '12/09/2026',
      'time': '09:00 AM - 10:00 AM',
      'status': 'Confirmed',
    },
    {
      'id': 'BK-1002',
      'rider': 'Emma Watson',
      'arena': 'Dressage Arena',
      'date': '12/09/2026',
      'time': '04:00 PM - 05:00 PM',
      'status': 'Pending',
    },
    {
      'id': 'BK-1003',
      'rider': 'David Miller',
      'arena': 'Outdoor Showjumping Arena',
      'date': '13/09/2026',
      'time': '11:00 AM - 12:30 PM',
      'status': 'Confirmed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookings = _selectedFilterIndex == 0
        ? _bookings
        : _bookings
            .where((b) => b['status'] == _filters[_selectedFilterIndex])
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Admin Bookings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primaryOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddBookingScreen()),
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
              // Filter Chips
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedFilterIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryOrange
                              : AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _filters[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Booking Items
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBookings.length,
                  itemBuilder: (context, index) {
                    final item = filteredBookings[index];
                    Color statusColor = item['status'] == 'Confirmed'
                        ? Colors.green
                        : item['status'] == 'Pending'
                            ? Colors.orange
                            : Colors.redAccent;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingDetailAdminScreen(bookingData: item),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['id']!,
                                  style: const TextStyle(
                                    color: AppColors.primaryOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['rider']!,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item['arena']} • ${item['date']}',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item['status']!,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
