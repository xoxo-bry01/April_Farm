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
  // Step 3 Dialog: Routes Blocks to Activity & Manual Bookings to Schedule
  void _showAddBookingDialog(BuildContext context, {bool isBlock = false}) {
    final nameController = TextEditingController();
    String selectedService = 'Private Lesson';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: Text(
          isBlock ? 'Block Arena Slot' : 'Add Admin Booking',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: isBlock ? 'Reason (e.g. Maintenance)' : 'Rider / Customer Name',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (!isBlock)
              DropdownButtonFormField<String>(
                value: selectedService,
                dropdownColor: AppColors.cardSurface,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Private Lesson', child: Text('Private Lesson')),
                  DropdownMenuItem(value: 'Group Lesson', child: Text('Group Lesson')),
                  DropdownMenuItem(value: 'Arena Hire', child: Text('Arena Hire')),
                  DropdownMenuItem(value: 'Clinic', child: Text('Clinic')),
                ],
                onChanged: (val) {
                  if (val != null) selectedService = val;
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryOrange),
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                final provider = Provider.of<BookingProvider>(context, listen: false);

                if (isBlock) {
                  // Step 3: Adds to Admin Activity feed ONLY (Does NOT appear in My Bookings)
                  provider.addAdminBlock(nameController.text.trim());
                } else {
                  // Step 3: Adds a manual booking to customer list
                  provider.addCustomerBooking(
                    Booking(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      serviceName: selectedService,
                      customerName: nameController.text.trim(),
                      date: DateTime.now(),
                      status: 'Confirmed',
                      isManualEntry: true,
                    ),
                  );
                }

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isBlock ? 'Arena slot blocked!' : 'Booking added!'),
                    backgroundColor: AppColors.primaryOrange,
                  ),
                );
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final allBookings = bookingProvider.allBookings;
    final activities = bookingProvider.adminActivities;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // Action Cards Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                children: [
                  // 1. Today's Bookings Count Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9500), Color(0xFFFF5E00)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's Bookings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${allBookings.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Add Booking
                  _buildDashboardCard(
                    icon: Icons.add_box_outlined,
                    label: 'Add Booking',
                    onTap: () => _showAddBookingDialog(context, isBlock: false),
                  ),

                  // 3. Block Times
                  _buildDashboardCard(
                    icon: Icons.block,
                    label: 'Block Times',
                    backgroundColor: Colors.red.withValues(alpha: 0.2),
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
                    onTap: () => _showAddBookingDialog(context, isBlock: true),
                  ),

                  // 4. Manage Invoices
                  _buildDashboardCard(
                    icon: Icons.receipt_long_outlined,
                    label: 'Manage Invoices',
                    onTap: () {},
                  ),

                  // 5. Send Notifications
                  _buildDashboardCard(
                    icon: Icons.notifications_none_outlined,
                    label: 'Send Notifications',
                    onTap: () {},
                  ),

                  // 6. Create Offers
                  _buildDashboardCard(
                    icon: Icons.local_offer_outlined,
                    label: 'Create Offers',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Arena Diary Header Card
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Arena Diary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Activity Feed
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              activities.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'No recent activity.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: AppColors.primaryOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  activity,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    Color backgroundColor = AppColors.cardSurface,
    Color textColor = AppColors.textPrimary,
    Color iconColor = AppColors.primaryOrange,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}