import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class EditBookingAdminScreen extends StatefulWidget {
  final Map<String, String>? bookingData;

  const EditBookingAdminScreen({super.key, this.bookingData});

  @override
  State<EditBookingAdminScreen> createState() => _EditBookingAdminScreenState();
}

class _EditBookingAdminScreenState extends State<EditBookingAdminScreen> {
  late TextEditingController _riderController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _riderController = TextEditingController(
      text: widget.bookingData?['rider'] ?? 'Sarah Jenkins',
    );
    _status = widget.bookingData?['status'] ?? 'Confirmed';
  }

  @override
  void dispose() {
    _riderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Booking Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rider Name',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _riderController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Status',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _status,
                    dropdownColor: AppColors.cardSurface,
                    isExpanded: true,
                    style: const TextStyle(color: AppColors.textPrimary),
                    items: ['Confirmed', 'Pending', 'Cancelled'].map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _status = val);
                    },
                  ),
                ),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
