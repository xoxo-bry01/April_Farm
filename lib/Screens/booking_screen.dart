import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late String _selectedService;

  final List<String> _services = [
    'Private Lesson',
    'Group Lesson',
    'Arena Hire',
    'Clinics',
    'Youngstar Booking',
  ];

  @override
  void initState() {
    super.initState();
    // Default to passed category if valid, otherwise first service
    if (widget.initialCategory != null &&
        _services.contains(widget.initialCategory)) {
      _selectedService = widget.initialCategory!;
    } else {
      _selectedService = _services.first;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );

    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      serviceName: _selectedService,
      customerName: 'Bryanna Sonebong',
      date: _selectedDate,
      status: 'Paid',
      specialNotes: _notesController.text.trim(),
    );

    bookingProvider.addCustomerBooking(newBooking);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking successfully created!'),
        backgroundColor: Colors.green,
      ),
    );

    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Book a Session',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Service',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedService,
                  dropdownColor: AppColors.cardSurface,
                  isExpanded: true,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                  ),
                  items: _services.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedService = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Special Notes & Instructions',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'e.g., Horse care notes, arena requirements...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.cardSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ), // Fixed padding syntax
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submitBooking,
                child: const Text(
                  'Confirm Booking',
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
  }
}
