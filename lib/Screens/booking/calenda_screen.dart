import 'package:flutter/material.dart';
import '../../app_colours.dart';

class BookingCalendarSheet extends StatefulWidget {
  final String sessionName;

  const BookingCalendarSheet({super.key, required this.sessionName});

  @override
  State<BookingCalendarSheet> createState() => _BookingCalendarSheetState();
}

class _BookingCalendarSheetState extends State<BookingCalendarSheet> {
  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '09:00 AM', 'isAvailable': true},
    {'time': '10:00 AM', 'isAvailable': false},
    {'time': '11:00 AM', 'isAvailable': true},
    {'time': '01:00 PM', 'isAvailable': true},
    {'time': '02:00 PM', 'isAvailable': false},
    {'time': '03:30 PM', 'isAvailable': true},
  ];

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Date Picker with explicit dark-theme text colors
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.primaryOrange,
                    onPrimary: Colors.white,
                    surface: AppColors.background,
                    onSurface: Colors.white,
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  onDateChanged: (newDate) {
                    setState(() {
                      selectedDate = newDate;
                      selectedTimeSlot = null;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Available Hours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
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
                        ? Colors.grey
                        : isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
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
                              'Booked ${widget.sessionName} for ${selectedDate.day}/${selectedDate.month} at $selectedTimeSlot!',
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