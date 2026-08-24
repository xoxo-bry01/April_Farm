import 'package:flutter/material.dart';
import '../app_colours.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Temporary local state for saved horses (Will connect to Supabase next)
  final List<Map<String, String>> _myHorses = [
    {
      'name': 'Mimi',
      'breed': 'Connemara Pony',
      'notes': 'Needs extra warm-up for left lead canter.',
    },
  ];

  final _horseNameController = TextEditingController();
  final _horseBreedController = TextEditingController();
  final _horseNotesController = TextEditingController();

  void _showAddHorseDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text(
          'Add New Horse',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _horseNameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Horse Name',
                labelStyle: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextField(
              controller: _horseBreedController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Breed',
                labelStyle: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextField(
              controller: _horseNotesController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Special Care / Riding Notes',
                labelStyle: TextStyle(color: AppColors.textSecondary),
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
              if (_horseNameController.text.trim().isNotEmpty) {
                setState(() {
                  _myHorses.add({
                    'name': _horseNameController.text.trim(),
                    'breed': _horseBreedController.text.trim(),
                    'notes': _horseNotesController.text.trim(),
                  });
                });
                _horseNameController.clear();
                _horseBreedController.clear();
                _horseNotesController.clear();
                Navigator.pop(ctx);
              }
            },
            child: const Text(
              'Save Horse',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryOrange,
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Bryanna Sonebong',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Client Account',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // My Horses Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Horses',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppColors.primaryOrange,
                  ),
                  onPressed: _showAddHorseDialog,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Horse List
            if (_myHorses.isEmpty)
              const Text(
                'No horses added yet.',
                style: TextStyle(color: AppColors.textSecondary),
              )
            else
              ..._myHorses.map(
                (horse) => Card(
                  color: AppColors.cardSurface,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryOrange,
                      child: Icon(Icons.pets, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      horse['name'] ?? '',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Breed: ${horse['breed']}\nNotes: ${horse['notes']}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
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
