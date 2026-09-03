import 'package:flutter/material.dart';
import '../../app_colours.dart';
import 'admin_home/admin_dashboard_screen.dart';
import 'admin_offers/offers_screen.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({super.key});

  @override
  State<AdminNavigationScreen> createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminDashboardScreen(),
    const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Admin Diary Placeholder',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    ),
    const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Livery Management Placeholder',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    ),
    const AdminOffersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: AppColors.cardSurface,
        selectedItemColor: AppColors.primaryOrange,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined),
            activeIcon: Icon(Icons.pets),
            label: 'Livery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            activeIcon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
        ],
      ),
    );
  }
}
