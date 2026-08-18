import 'package:flutter/material.dart';
import '../app_colours.dart';

class CalendaScreen extends StatefulWidget {
  const CalendaScreen({super.key});

  @override
  State<CalendaScreen> createState() => _CalendaScreenState();
}

enum SlotStatus { green, orange, red, grey }

class _CalendaScreenState extends State<CalendaScreen> {
  int _selectedDateIndex = 0;
  String _selectedService = 'Arena Hire';
  String? _selectedTimeSlot;

  // Equestrian Services from Project Document
  final List<String> _services = [
    'Private Lessons',
    'Group Lessons',
    'Arena Hire',
    'Clinics',
    'Young Stars',
  ];

  // 7-day rolling window
  final List<DateTime> _dates = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );

  // Time Slots configured with Document Color Codes:
  // Grey = Unavailable | Green = Available | Orange = Almost Fully Booked | Red = Fully Booked
  final Map<String, List<Map<String, dynamic>>> _timeSlots = {
    'Morning': [
      {'time': '08:00 AM', 'status': SlotStatus.green},
      {'time': '09:00 AM', 'status': SlotStatus.orange},
      {'time': '10:00 AM', 'status': SlotStatus.red},
      {'time': '11:00 AM', 'status': SlotStatus.grey},
    ],
    'Afternoon': [
      {'time': '01:00 PM', 'status': SlotStatus.green},
      {'time': '02:00 PM', 'status': SlotStatus.green},
      {'time': '03:00 PM', 'status': SlotStatus.orange},
      {'time': '04:00 PM', 'status': SlotStatus.red},
    ],
    'Evening': [
      {'time': '05:00 PM', 'status': SlotStatus.green},
      {'time': '06:00 PM', 'status': SlotStatus.grey},
      {'time': '07:00 PM', 'status': SlotStatus.red},
    ],
  };

  Color _getStatusColor(SlotStatus status) {
    switch (status) {
      case SlotStatus.green:
        return const Color(0xFF4CAF50); // Available
      case SlotStatus.orange:
        return const Color(0xFFFF9800); // Almost fully booked
      case SlotStatus.red:
        return const Color(0xFFE53935); // Fully booked
      case SlotStatus.grey:
        return const Color(0xFF757575); // Unavailable / Blocked
    }
  }

  String _getStatusLabel(SlotStatus status) {
  switch (status) {
    case SlotStatus.green:
      return 'Available';
    case SlotStatus.orange:
      return 'Few Slots Left';
    case SlotStatus.red:
      return 'Fully Booked';
    case SlotStatus.grey:
      return 'Unavailable';
    }
  }

  String _formatWeekday(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _formatMonth(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[date.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDate = _dates[_selectedDateIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Book Service',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. Service Category Selector ---
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Select Service',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 42,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        final service = _services[index];
                        final isSelected = service == _selectedService;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(service),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedService = service;
                                  _selectedTimeSlot = null;
                                });
                              }
                            },
                            selectedColor: AppColors.primaryOrange,
                            backgroundColor: AppColors.cardSurface,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 2. Horizontal Date Selector ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${_formatMonth(selectedDate)} ${selectedDate.year}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 85,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final date = _dates[index];
                        final isSelected = index == _selectedDateIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDateIndex = index;
                              _selectedTimeSlot = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 65,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryOrange
                                  : AppColors.cardSurface,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _formatWeekday(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 3. Color Legend ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem(const Color(0xFF4CAF50), 'Available'),
                        _buildLegendItem(const Color(0xFFFF9800), 'Filling'),
                        _buildLegendItem(const Color(0xFFE53935), 'Full'),
                        _buildLegendItem(const Color(0xFF757575), 'Blocked'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 4. Interactive Time Slots ---
                  ..._timeSlots.entries.map((entry) {
                    final sectionName = entry.key;
                    final slots = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sectionName,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: slots.map((slot) {
                              final String timeStr = slot['time'];
                              final SlotStatus status = slot['status'];
                              final Color statusColor = _getStatusColor(status);
                              final bool isSelectable =
                                  status == SlotStatus.green || status == SlotStatus.orange;
                              final bool isSelected = _selectedTimeSlot == timeStr;

                              return GestureDetector(
                                onTap: isSelectable
                                    ? () {
                                        setState(() {
                                          _selectedTimeSlot = timeStr;
                                        });
                                      }
                                    : null,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryOrange
                                        : AppColors.cardSurface,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryOrange
                                          : statusColor.withValues(alpha: 0.6),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.white : statusColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        timeStr,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : isSelectable
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary
                                                      .withValues(alpha: 0.5),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          decoration: !isSelectable
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // --- 5. Bottom Summary Action Bar ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedTimeSlot != null
                              ? 'Slot: $_selectedTimeSlot'
                              : 'Select a time slot',
                          style: TextStyle(
                            color: _selectedTimeSlot != null
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _selectedService,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _selectedTimeSlot != null
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Booked $_selectedService at $_selectedTimeSlot!',
                                ),
                                backgroundColor: AppColors.primaryOrange,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      disabledBackgroundColor:
                          AppColors.textSecondary.withValues(alpha: 0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Confirm Slot',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}