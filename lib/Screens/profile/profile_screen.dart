import 'package:flutter/material.dart';
import '../../app_colours.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  void _showHorseListModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Horses',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppColors.primaryOrange,
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showAddHorseDialog();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_myHorses.isEmpty)
              const Text(
                'No horses added yet.',
                style: TextStyle(color: AppColors.textSecondary),
              )
            else
              ..._myHorses.map(
                (horse) => ListTile(
                  contentPadding: EdgeInsets.zero,
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
                    '${horse['breed']} • ${horse['notes']}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Circular Avatar & User Info matching Vision Screen 9
            const CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.cardSurface,
              backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=47'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Bryanna Sonebong',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'bryanna@example.com',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 2),
            const Text(
              '+44 7700 900123',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 28),

            // Profile Action Menu matching Screen 9 List
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildMenuOption(
                    icon: Icons.person_outline,
                    title: 'Account Settings',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.background, height: 1),
                  _buildMenuOption(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.background, height: 1),
                  _buildMenuOption(
                    icon: Icons.pets_outlined,
                    title: 'My Horses',
                    onTap: _showHorseListModal,
                  ),
                  const Divider(color: AppColors.background, height: 1),
                  _buildMenuOption(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.background, height: 1),
                  _buildMenuOption(
                    icon: Icons.info_outline,
                    title: 'About April Farm',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Log Out Button matching Vision Screen 9
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Clean sign-out straight to Login Screen 2
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.redAccent,
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

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
