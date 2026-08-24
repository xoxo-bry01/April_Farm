import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app_colours.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';

class AdminScreen extends StatefulWidget {
  final VoidCallback? onNavigateToDiary;

  const AdminScreen({super.key, this.onNavigateToDiary});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _supabase = Supabase.instance.client;

  // Full Feature Booking Dialog (Date, Time, Duration, Horse Name, Payment, Notes)
  void _showAddBookingDialog(BuildContext context, {bool isBlock = false}) {
    final nameController = TextEditingController();
    final horseController = TextEditingController();
    final notesController = TextEditingController();

    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedService = 'Private Lesson';
    String duration = '45 min';
    String paymentStatus = 'Paid';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              top: 24,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isBlock
                            ? 'Block Arena Slot'
                            : 'Create Complete Booking',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Rider Name Field
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: isBlock ? 'Reason' : 'Rider / Customer Name',
                      labelStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (!isBlock) ...[
                    // Horse Name Field
                    TextField(
                      controller: horseController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Horse Name (e.g. Dusty)',
                        labelStyle: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date & Time Pickers
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2025),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null) {
                                setModalState(() => selectedDate = picked);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: AppColors.primaryOrange,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (picked != null) {
                                setModalState(() => selectedTime = picked);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: AppColors.primaryOrange,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedTime.format(context),
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Service Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedService,
                      dropdownColor: AppColors.cardSurface,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Service Category',
                        labelStyle: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Private Lesson',
                          child: Text('Private Lesson'),
                        ),
                        DropdownMenuItem(
                          value: 'Group Lesson',
                          child: Text('Group Lesson'),
                        ),
                        DropdownMenuItem(
                          value: 'Arena Hire',
                          child: Text('Arena Hire'),
                        ),
                        DropdownMenuItem(
                          value: 'Clinic / Bodywork',
                          child: Text('Clinic / Bodywork'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null)
                          setModalState(() => selectedService = val);
                      },
                    ),
                    const SizedBox(height: 12),

                    // Duration & Payment Status
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: duration,
                            dropdownColor: AppColors.cardSurface,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Duration',
                              labelStyle: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ['30 min', '45 min', '60 min', '90 min']
                                .map(
                                  (d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(d),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val != null)
                                setModalState(() => duration = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: paymentStatus,
                            dropdownColor: AppColors.cardSurface,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Payment Status',
                              labelStyle: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ['Paid', 'Pending', 'Pay on Arrival']
                                .map(
                                  (p) => DropdownMenuItem(
                                    value: p,
                                    child: Text(p),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => paymentStatus = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Notes Area
                    TextField(
                      controller: notesController,
                      maxLines: 2,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Special Notes / Requirements',
                        labelStyle: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (nameController.text.trim().isNotEmpty) {
                          final provider = Provider.of<BookingProvider>(
                            context,
                            listen: false,
                          );

                          final formattedTime = selectedTime.format(context);
                          final fullService = isBlock
                              ? 'BLOCKED'
                              : '$selectedService ($formattedTime, $duration)';
                          final horse = horseController.text.trim();

                          provider.addCustomerBooking(
                            Booking(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              serviceName: fullService,
                              customerName: horse.isEmpty
                                  ? nameController.text.trim()
                                  : '${nameController.text.trim()} ($horse)',
                              date: selectedDate,
                              status: paymentStatus,
                              isManualEntry: true,
                            ),
                          );

                          Navigator.pop(ctx);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isBlock ? 'Slot Blocked!' : 'Booking Saved!',
                              ),
                              backgroundColor: AppColors.primaryOrange,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Save Booking Details',
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
          );
        },
      ),
    );
  }

  void _showInvoicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text(
          'Recent Invoices',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.receipt, color: AppColors.primaryOrange),
                title: Text(
                  'INV-2026-001',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  'Arena Hire - Paid',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                trailing: Text(
                  '£35.00',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.receipt, color: AppColors.primaryOrange),
                title: Text(
                  'INV-2026-002',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  'Private Lesson - Pending',
                  style: TextStyle(color: Colors.amber),
                ),
                trailing: Text(
                  '£50.00',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    final titleController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text(
          'Broadcast Announcement',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Title (e.g. Arena Maintenance)',
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
            TextField(
              controller: messageController,
              maxLines: 3,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Message details...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
            ),
            onPressed: () {
              if (messageController.text.trim().isNotEmpty) {
                Provider.of<BookingProvider>(
                  context,
                  listen: false,
                ).addAdminActivity(
                  'Announcement Sent: ${titleController.text}',
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification sent to all users!'),
                    backgroundColor: AppColors.primaryOrange,
                  ),
                );
              }
            },
            child: const Text(
              'Send Broadcast',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showOffersDialog(BuildContext context) {
    final codeController = TextEditingController();
    final discountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text(
          'Create Promo Code',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Promo Code (e.g. SUMMER10)',
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
            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Discount % (e.g. 10)',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
            ),
            onPressed: () {
              if (codeController.text.trim().isNotEmpty) {
                Provider.of<BookingProvider>(
                  context,
                  listen: false,
                ).addAdminActivity(
                  'Created Promo Code: ${codeController.text.toUpperCase()}',
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Offer ${codeController.text.toUpperCase()} created!',
                    ),
                    backgroundColor: AppColors.primaryOrange,
                  ),
                );
              }
            },
            child: const Text(
              'Create Offer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final activities = bookingProvider.adminActivities;

    // Filter today's count directly from provider to keep dashboard and diary in sync
    final today = DateTime.now();
    final todayCount = bookingProvider.allBookings.where((b) {
      return b.date.year == today.year &&
          b.date.month == today.month &&
          b.date.day == today.day;
    }).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primaryOrange),
            onPressed: () async {
              await _supabase.auth.signOut();
            },
          ),
        ],
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                children: [
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
                          '$todayCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildDashboardCard(
                    icon: Icons.add_box_outlined,
                    label: 'Add Booking',
                    onTap: () => _showAddBookingDialog(context, isBlock: false),
                  ),
                  _buildDashboardCard(
                    icon: Icons.block,
                    label: 'Block Times',
                    backgroundColor: Colors.red.withOpacity(0.2),
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
                    onTap: () => _showAddBookingDialog(context, isBlock: true),
                  ),
                  _buildDashboardCard(
                    icon: Icons.receipt_long_outlined,
                    label: 'Manage Invoices',
                    onTap: () => _showInvoicesDialog(context),
                  ),
                  _buildDashboardCard(
                    icon: Icons.notifications_none_outlined,
                    label: 'Send Notifications',
                    onTap: () => _showNotificationDialog(context),
                  ),
                  _buildDashboardCard(
                    icon: Icons.local_offer_outlined,
                    label: 'Create Offers',
                    onTap: () => _showOffersDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: widget.onNavigateToDiary ?? () {},
                child: Container(
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
              ),
              const SizedBox(height: 24),
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
