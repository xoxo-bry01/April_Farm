import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app_colours.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';

class BookingScreen extends StatefulWidget {
  final String? initialCategory;
  const BookingScreen({super.key, this.initialCategory});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String currentView = 'landing';

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      currentView = widget.initialCategory!;
    }
  }

  final List<Map<String, String>> sessionOptions = const [
    {
      'title': 'Clinics',
      'description': 'Intensive training with guest experts.',
      'image': 'assets/images/clinics.jpg',
    },
    {
      'title': 'Private Lessons',
      'description': 'Personalized coaching with top instructors.',
      'image': 'assets/images/private_lessons.jpg',
    },
    {
      'title': 'Arena Hire',
      'description': 'Rent our facilities for independent riding.',
      'image': 'assets/images/arena_hire.jpg',
    },
  ];

  final List<Map<String, String>> eventOptions = const [
    {
      'title': 'Group Lessons',
      'description': 'Learn and grow with fellow riders.',
      'image': 'assets/images/group_lessons.jpg',
    },
    {
      'title': 'Youngstars',
      'description': 'Fun and safe intro to riding for kids.',
      'image': 'assets/images/youngstars.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          currentView == 'landing'
              ? 'Booking'
              : currentView == 'sessions'
              ? 'Sessions'
              : 'Events',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: currentView != 'landing'
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {
                  setState(() {
                    currentView = 'landing';
                  });
                },
              )
            : null,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: currentView == 'landing'
          ? _buildLandingView()
          : _buildServiceList(
              currentView == 'sessions' ? sessionOptions : eventOptions,
              isEvent: currentView == 'events',
            ),
    );
  }

  Widget _buildLandingView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What are you booking today?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose a category to browse available time slots.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          _buildCategoryCard(
            title: 'Sessions',
            subtitle: 'Clinics, Private Lessons & Arena Hire',
            icon: Icons.calendar_today_rounded,
            onTap: () {
              setState(() {
                currentView = 'sessions';
              });
            },
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            title: 'Events',
            subtitle: 'Group Lessons & Youngstars Events',
            icon: Icons.event_rounded,
            onTap: () {
              setState(() {
                currentView = 'events';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryOrange, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceList(
    List<Map<String, String>> items, {
    required bool isEvent,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['description']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () =>
                          _openBookingSheet(item['title']!, isEvent),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        isEvent ? 'Book Event' : 'Book Session',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item['image']!,
                  width: 120,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 110,
                      color: Colors.white.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.pets,
                        color: AppColors.textSecondary,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openBookingSheet(String title, bool isEvent) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardSurface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _BookingSheetContent(
          title: title,
          isEvent: isEvent,
          onConfirm: (selectedDate, slotId) {
            Navigator.pop(context); // Close bottom sheet immediately
            _confirmBooking(
              id: slotId,
              title: title,
              isEvent: isEvent,
              selectedDate: selectedDate,
            );
          },
        );
      },
    );
  }

  Future<void> _confirmBooking({
    required String? id,
    required String title,
    required bool isEvent,
    required DateTime selectedDate,
  }) async {
    try {
      final client = Supabase.instance.client;
      final authUser = client.auth.currentUser;

      if (authUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to make a booking.')),
        );
        return;
      }
      String userId = authUser.id;

      // 1. Ensure user exists in tblUser with ONLY UserID
      final userCheck = await client
          .from('tblUser')
          .select('UserID')
          .eq('UserID', userId)
          .maybeSingle();

      if (userCheck == null) {
        await client.from('tblUser').insert({'UserID': userId});
      }

      final dateStr = selectedDate.toIso8601String().split('T').first;

      // 2. Insert record into tblBooking
      final bookingData = <String, dynamic>{
        'UserID': userId,
        'NumberOfPeople': 1,
        'Status': 'Confirmed',
        'ConfirmedDate': dateStr,
      };

      if (id != null) {
        if (!isEvent) bookingData['SessionID'] = id;
        if (isEvent) bookingData['EventID'] = id;
      }

      await client.from('tblBooking').insert(bookingData);

      if (!mounted) return;

      // 3. Sync local provider for MyBookingsScreen
      Provider.of<BookingProvider>(context, listen: false).addCustomerBooking(
        Booking(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          serviceName: title,
          customerName: 'Bryanna',
          date: selectedDate,
          status: 'Confirmed',
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successfully created!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error booking: $e')));
    }
  }
}

// Interactive Date & Time Picker Sheet Widget
class _BookingSheetContent extends StatefulWidget {
  final String title;
  final bool isEvent;
  final Function(DateTime date, String? slotId) onConfirm;

  const _BookingSheetContent({
    required this.title,
    required this.isEvent,
    required this.onConfirm,
  });

  @override
  State<_BookingSheetContent> createState() => _BookingSheetContentState();
}

class _BookingSheetContentState extends State<_BookingSheetContent> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    final formattedTime = selectedTime.format(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Date & Time for ${widget.title}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Interactive Date Picker
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() => selectedDate = picked);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date: $formattedDate',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryOrange,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Interactive Time Picker
          InkWell(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );
              if (picked != null) {
                setState(() => selectedTime = picked);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time: $formattedTime',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    Icons.access_time,
                    color: AppColors.primaryOrange,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final fullDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                widget.onConfirm(fullDateTime, null);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
