import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app_colours.dart';

class BookingScreen extends StatefulWidget {
  final String? initialCategory; // Can pass 'sessions' or 'events' directly

  const BookingScreen({super.key, this.initialCategory});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // 'landing' = Shows "What are you booking today?"
  // 'sessions' = Shows Session options
  // 'events' = Shows Event options
  String currentView = 'landing';

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      currentView = widget.initialCategory!;
    }
  }

  // Data mapping directly aligned with Supabase categories
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

  // First View: "What are you booking today?" landing screen
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

          // Option 1: Sessions Row
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

          // Option 2: Events Row
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

  // Category Selection Card
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

  // Detailed List View (Clinics, Private Lessons, etc.)
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

  // Popup Modal Bottom Sheet
  void _openBookingSheet(String title, bool isEvent) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date & Time for $title',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: isEvent
                      ? fetchAvailableEvents()
                      : fetchAvailableSessions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No available slots found.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      );
                    }

                    final slots = snapshot.data!;
                    return ListView.builder(
                      itemCount: slots.length,
                      itemBuilder: (context, i) {
                        final slot = slots[i];
                        return ListTile(
                          title: Text(
                            '${slot['Date'] ?? 'Date TBD'} (${slot['StarTime'] ?? slot['StartTime'] ?? ''})',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => _confirmBooking(
                              id: isEvent ? slot['EventID'] : slot['SessionID'],
                              isEvent: isEvent,
                            ),
                            child: const Text('Confirm'),
                          ),
                        );
                      },
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

  // Fetch sessions from tblSession
  Future<List<Map<String, dynamic>>> fetchAvailableSessions() async {
    final response = await Supabase.instance.client
        .from('tblSession')
        .select('*');
    return List<Map<String, dynamic>>.from(response);
  }

  // Fetch events from tblEvent
  Future<List<Map<String, dynamic>>> fetchAvailableEvents() async {
    final response = await Supabase.instance.client
        .from('tblEvent')
        .select('*');
    return List<Map<String, dynamic>>.from(response);
  }

  // Insert reservation directly into tblBooking
  Future<void> _confirmBooking({
    required String id,
    required bool isEvent,
  }) async {
    try {
      await Supabase.instance.client.from('tblBooking').insert({
        if (!isEvent) 'SessionID': id,
        if (isEvent) 'EventID': id,
        'NumberOfPeople': 1,
        'Status': 'Confirmed',
      });

      if (!mounted) return;
      Navigator.pop(context); // Close bottom sheet
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
