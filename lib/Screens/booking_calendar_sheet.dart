import 'package:flutter/material.dart';
import '../app_colours.dart';

class BookingCalendarSheet extends StatefulWidget {
  final String sessionName;

  const BookingCalendarSheet({super.key, required this.sessionName});

  @override
  State<BookingCalendarSheet> createState() => _BookingCalendarSheetState();
}

class _BookingCalendarSheetState extends State<BookingCalendarSheet> {
  DateTime focusedMonth = DateTime(2026, 8, 1);
  DateTime selectedDate = DateTime(2026, 8, 19);
  String? selectedTimeSlot;

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '09:00 AM', 'isAvailable': true},
    {'time': '10:00 AM', 'isAvailable': false},
    {'time': '11:00 AM', 'isAvailable': true},
    {'time': '01:00 PM', 'isAvailable': true},
    {'time': '02:00 PM', 'isAvailable': false},
    {'time': '03:30 PM', 'isAvailable': true},
  ];

  final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  
  final List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateUtils.getDaysInMonth(focusedMonth.year, focusedMonth.month);
    final int firstWeekdayOfMonth = DateTime(focusedMonth.year, focusedMonth.month, 1).weekday % 7;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              widget.sessionName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // High-Contrast Custom Calendar Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                children: [
                  // Month Header + Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${monthNames[focusedMonth.month - 1]} ${focusedMonth.year}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                focusedMonth = DateTime(focusedMonth.year, focusedMonth.month - 1, 1);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + 1, 1);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Days of the Week Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weekDays
                        .map(
                          (day) => SizedBox(
                            width: 32,
                            child: Text(
                              day,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),

                  // Calendar Days Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daysInMonth + firstWeekdayOfMonth,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index < firstWeekdayOfMonth) {
                        return const SizedBox.shrink();
                      }
                      final dayNumber = index - firstWeekdayOfMonth + 1;
                      final bool isSelected = selectedDate.day == dayNumber &&
                          selectedDate.month == focusedMonth.month &&
                          selectedDate.year == focusedMonth.year;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = DateTime(focusedMonth.year, focusedMonth.month, dayNumber);
                            selectedTimeSlot = null;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$dayNumber',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Available Hours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // Time Slots Grid
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                final bool isAvailable = slot['isAvailable'];
                final bool isSelected = selectedTimeSlot == slot['time'];

                return ChoiceChip(
                  label: Text(slot['time']),
                  selected: isSelected,
                  onSelected: isAvailable
                      ? (selected) {
                          setState(() {
                            selectedTimeSlot = selected ? slot['time'] : null;
                          });
                        }
                      : null,
                  selectedColor: AppColors.primaryOrange,
                  disabledColor: Colors.white.withValues(alpha: 0.05),
                  backgroundColor: AppColors.background,
                  labelStyle: TextStyle(
                    color: !isAvailable
                        ? Colors.white24
                        : isSelected
                            ? Colors.white
                            : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTimeSlot != null
                    ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Booked ${widget.sessionName} for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at $selectedTimeSlot!',
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Confirm Slot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selectedTimeSlot != null ? Colors.white : Colors.white38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}