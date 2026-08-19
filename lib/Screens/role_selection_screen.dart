import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colours.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _customerNameController = TextEditingController();
  String _selectedService = 'Private Lesson';

  @override
  void dispose() {
    _customerNameController.dispose();
    super.dispose();
  }

  void _addManualBooking() {
    if (_customerNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a rider/customer name.')),
      );
      return;
    }

    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      serviceName: _selectedService,
      customerName: _customerNameController.text.trim(),
      date: DateTime.now(),
      status: 'Manual Block',
      isManualEntry: true,
    );

    Provider.of<BookingProvider>(context, listen: false).addCustomerBooking(newBooking);
    _customerNameController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manual booking added to schedule!'),
        backgroundColor: AppColors.primaryOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<BookingProvider>(context).userBookings;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stat Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${bookings.length}',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Total Bookings',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(height: 30, width: 1, color: Colors.grey.shade800),
                  const Column(
                    children: [
                      Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Diary Status',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Manual Entry Title
            const Text(
              'Add Manual Slot (Phone / Livery Block)',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Form
            TextField(
              controller: _customerNameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Customer or Rider Name',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.cardSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedService,
              dropdownColor: AppColors.cardSurface,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Private Lesson', child: Text('Private Lesson')),
                DropdownMenuItem(value: 'Group Lesson', child: Text('Group Lesson')),
                DropdownMenuItem(value: 'Arena Hire', child: Text('Arena Hire')),
                DropdownMenuItem(value: 'Clinic', child: Text('Clinic')),
                DropdownMenuItem(value: 'Young Star', child: Text('Young Star')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedService = val);
              },
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _addManualBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add to Master Schedule', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 28),

            // Master List Header
            const Text(
              'Master Schedule',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            bookings.isEmpty
                ? const Center(
                    child: Text(
                      'No active bookings in system',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final item = bookings[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            '${item.serviceName} (${item.customerName})',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${item.date.day}/${item.date.month}/${item.date.year} • ${item.status}',
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () {
                              Provider.of<BookingProvider>(context, listen: false)
                                  .cancelBooking(item.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}