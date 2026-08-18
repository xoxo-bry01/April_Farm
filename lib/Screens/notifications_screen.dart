import 'package:flutter/material.dart';
import '../app_colours.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Arena Occupied: BS Jumping Clinic',
      'body': 'The Outdoor Arena is fully booked today from 2:00 PM to 5:00 PM.',
      'time': '10 mins ago',
      'icon': Icons.warning_amber_rounded,
      'isRead': false,
    },
    {
      'title': 'Upcoming Booking Reminder',
      'body': 'Your Arena Hire session starts tomorrow at 10:00 AM.',
      'time': '2 hours ago',
      'icon': Icons.calendar_today,
      'isRead': false,
    },
    {
      'title': 'Pony Club Event Notice',
      'body': 'Indoor Arena reserved for Pony Club rally on Saturday morning.',
      'time': 'Yesterday',
      'icon': Icons.campaign,
      'isRead': true,
    },
    {
      'title': 'Maintenance Alert',
      'body': 'Harrowing scheduled for main arena tomorrow between 7:00 AM and 8:00 AM.',
      'time': '2 days ago',
      'icon': Icons.build_circle_outlined,
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Livery Diary & Alerts',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: AppColors.primaryOrange),
            tooltip: 'Mark all as read',
            onPressed: () {
              setState(() {
                for (var note in _notifications) {
                  note['isRead'] = true;
                }
              });
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                'No notifications right now',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                final bool isRead = item['isRead'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isRead
                        ? AppColors.cardSurface.withValues(alpha: 0.6)
                        : AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: isRead
                        ? null
                        : Border.all(
                            color: AppColors.primaryOrange.withValues(alpha: 0.4),
                          ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: isRead
                          ? AppColors.background
                          : AppColors.primaryOrange.withValues(alpha: 0.15),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isRead
                            ? AppColors.textSecondary
                            : AppColors.primaryOrange,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'],
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          item['time'],
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        item['body'],
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        item['isRead'] = true;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}