import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colours.dart';
import '../providers/booking_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = 
        Provider.of<BookingProvider>(context).notifications;

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
                for (var note in notifications) {
                  note['isRead'] = true;
                }
              });
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No notifications right now',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> item = notifications[index];
                final bool isRead = (item['isRead'] as bool?) ?? false;

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
                        item['icon'] as IconData? ?? Icons.notifications,
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
                            item['title'].toString(),
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          item['time'].toString(),
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
                        item['body'].toString(),
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