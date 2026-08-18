import 'package:flutter/material.dart';
import '../app_colours.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _manualBookingKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedService = 'Arena Hire';
  String _selectedTime = '10:00 AM';
  bool _isSlotBlocked = false;

  final List<String> _services = [
    'Private Lessons',
    'Group Lessons',
    'Arena Hire',
    'Clinics',
    'Young Stars',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveManualBooking() {
    if (_manualBookingKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Manual booking added for ${_clientNameController.text} ($_selectedService at $_selectedTime)',
          ),
          backgroundColor: AppColors.primaryOrange,
        ),
      );
      _clientNameController.clear();
      _notesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Owner Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section 1: Block / Unblock Arena Slot ---
            const Text(
              'Manage Arena Hours',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Toggle availability or block times for maintenance',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Block Selected Slot',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Switch(
                        value: _isSlotBlocked,
                        activeColor: Colors.redAccent,
                        onChanged: (value) {
                          setState(() {
                            _isSlotBlocked = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    _isSlotBlocked
                        ? 'This slot is currently BLOCKED (Grey on customer calendar)'
                        : 'This slot is ACTIVE and open for customer bookings',
                    style: TextStyle(
                      color: _isSlotBlocked ? Colors.redAccent : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Section 2: Manual Booking Entry ---
            const Text(
              'Add Manual Booking',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Record phone calls, Pony Club, or BS bookings',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _manualBookingKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Client / Event Name
                    TextFormField(
                      controller: _clientNameController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a name or group title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Rider or Group Name',
                        labelStyle: const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.person_outline, color: AppColors.primaryOrange),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Service Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      dropdownColor: AppColors.cardSurface,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Service Type',
                        labelStyle: const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.category_outlined, color: AppColors.primaryOrange),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: _services.map((service) {
                        return DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedService = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),

                    // Notes / Contact Info
                    TextFormField(
                      controller: _notesController,
                      maxLines: 2,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Notes (Phone number, special requirements)',
                        labelStyle: const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.note_alt_outlined, color: AppColors.primaryOrange),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _saveManualBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Booking to Diary',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}