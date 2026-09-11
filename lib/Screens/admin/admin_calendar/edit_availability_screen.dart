import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class EditAvailabilityScreen extends StatefulWidget {
  final String? slotTime;
  final String? arenaName;

  const EditAvailabilityScreen({super.key, this.slotTime, this.arenaName});

  @override
  State<EditAvailabilityScreen> createState() => _EditAvailabilityScreenState();
}

class _EditAvailabilityScreenState extends State<EditAvailabilityScreen> {
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _priceController;
  late TextEditingController _capacityController;
  late String _selectedArena;

  final List<String> _arenas = [
    'Indoor Arena 1',
    'Outdoor Showjumping Arena',
    'Dressage Arena',
  ];

  @override
  void initState() {
    super.initState();
    _startTimeController = TextEditingController(
      text: _extractStartTime(widget.slotTime),
    );
    _endTimeController = TextEditingController(
      text: _extractEndTime(widget.slotTime),
    );
    _priceController = TextEditingController(text: '30.00');
    _capacityController = TextEditingController(text: '1');
    _selectedArena = widget.arenaName ?? 'Indoor Arena 1';
  }

  String _extractStartTime(String? timeRange) {
    if (timeRange == null || !timeRange.contains(' - ')) return '09:00 AM';
    return timeRange.split(' - ')[0];
  }

  String _extractEndTime(String? timeRange) {
    if (timeRange == null || !timeRange.contains(' - ')) return '10:00 AM';
    return timeRange.split(' - ')[1];
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
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
          'Edit Slot Availability',
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
              // Facility Selection
              const Text(
                'Facility',
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
                    value: _arenas.contains(_selectedArena)
                        ? _selectedArena
                        : _arenas[0],
                    dropdownColor: AppColors.cardSurface,
                    isExpanded: true,
                    style: const TextStyle(color: AppColors.textPrimary),
                    items: _arenas.map((String arena) {
                      return DropdownMenuItem<String>(
                        value: arena,
                        child: Text(arena),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      if (val != null) {
                        setState(() {
                          _selectedArena = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Start and End Time Fields
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start Time',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _startTimeController,
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _endTimeController,
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Price and Capacity Fields
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Slot Fee (£)',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Max Horses',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _capacityController,
                          keyboardType: TextInputType.number,
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
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Delete Slot',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Update Slot',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
