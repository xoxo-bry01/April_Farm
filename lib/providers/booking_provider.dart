import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  // Store all bookings
  final List<Booking> _allBookings = [];

  // Store blocked dates set by admin
  final List<DateTime> _blockedDates = [];

  // Store admin activity logs
  final List<String> _adminActivities = ['System initialized'];

  // Store notifications
  final List<String> _notifications = ['Welcome to April Farm!'];

  // Primary customer name for current user session
  final String _currentCustomerName = 'Bryanna Sonebong';

  // Getters
  List<Booking> get allBookings => List.unmodifiable(_allBookings);
  List<DateTime> get blockedDates => List.unmodifiable(_blockedDates);
  List<String> get adminActivities => List.unmodifiable(_adminActivities);
  List<String> get notifications => List.unmodifiable(_notifications);

  // Alias getters to clear errors in my_bookings_screen & role_selection_screen
  List<Booking> get userBookings => getCustomerBookings(_currentCustomerName);

  // Customer specific bookings (Filtered by user identity)
  List<Booking> getCustomerBookings(String customerName) {
    return _allBookings
        .where((booking) => booking.customerName == customerName)
        .toList();
  }

  // Add customer booking
  void addCustomerBooking(Booking newBooking) {
    _allBookings.add(newBooking);
    addAdminActivity('New booking created: ${newBooking.serviceName}');
    addNotification('Booking confirmed for ${newBooking.serviceName}');
    notifyListeners();
  }

  // Cancel booking method to clear error in my_bookings_screen
  void cancelBooking(String bookingId) {
    _allBookings.removeWhere((booking) => booking.id == bookingId);
    addAdminActivity('Booking cancelled ID: $bookingId');
    addNotification('A booking was cancelled.');
    notifyListeners();
  }

  // Notification helper methods
  void addNotification(String message) {
    _notifications.insert(0, message);
    notifyListeners();
  }

  // Admin activity log method
  void addAdminActivity(String activity) {
    _adminActivities.insert(0, activity);
    notifyListeners();
  }

  // Check if a specific date is blocked
  bool isDateBlocked(DateTime date) {
    return _blockedDates.any(
      (blockedDate) =>
          blockedDate.year == date.year &&
          blockedDate.month == date.month &&
          blockedDate.day == date.day,
    );
  }

  // Method for admin to block a new date
  void blockDate(DateTime date) {
    if (!isDateBlocked(date)) {
      _blockedDates.add(date);
      addAdminActivity('Blocked date: ${date.day}/${date.month}/${date.year}');
      addNotification(
        'Date ${date.day}/${date.month} has been blocked for maintenance.',
      );
      notifyListeners();
    }
  }

  // Method for admin to unblock a date
  void unblockDate(DateTime date) {
    _blockedDates.removeWhere(
      (blockedDate) =>
          blockedDate.year == date.year &&
          blockedDate.month == date.month &&
          blockedDate.day == date.day,
    );
    addAdminActivity('Unblocked date: ${date.day}/${date.month}/${date.year}');
    notifyListeners();
  }

  // Clear all notifications
  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
