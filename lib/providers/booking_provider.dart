import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _userBookings = [];
  List<String> _adminActivities = [];

  // App-Wide System Notifications List
  final List<Map<String, String>> _notifications = [
    {
      'title': 'Arena Maintenance',
      'message':
          'Main arena closed today between 2 PM - 4 PM for surface harrowing.',
      'date': 'Today',
    },
    {
      'title': 'New Offers Live',
      'message': 'Check out summer block booking discounts on private lessons!',
      'date': 'Yesterday',
    },
  ];

  List<Booking> get userBookings =>
      _userBookings.where((b) => b.status != 'Blocked').toList();

  List<Booking> get allBookings => _userBookings;
  List<String> get adminActivities => _adminActivities;
  List<Map<String, String>> get notifications => _notifications;

  BookingProvider() {
    loadDataFromStorage();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedBookings = jsonEncode(
      _userBookings.map((b) => b.toMap()).toList(),
    );
    await prefs.setString('april_farm_bookings', encodedBookings);
    await prefs.setStringList('april_farm_activities', _adminActivities);
  }

  Future<void> loadDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedBookings = prefs.getString('april_farm_bookings');
    if (encodedBookings != null) {
      final List<dynamic> decoded = jsonDecode(encodedBookings);
      _userBookings = decoded.map((item) => Booking.fromMap(item)).toList();
    }
    _adminActivities =
        prefs.getStringList('april_farm_activities') ??
        ['Invoice #2024-007 paid', 'Notification broadcast sent to all riders'];
    notifyListeners();
  }

  void addCustomerBooking(Booking booking) {
    _userBookings.add(booking);
    _adminActivities.insert(
      0,
      'New booking: ${booking.serviceName} (${booking.customerName})',
    );
    _saveToStorage();
    notifyListeners();
  }

  // Admin Blocks Time & Broadcasts Notification to Users
  void addAdminBlock(String reason) {
    // 1. Post to Notifications Screen for customers
    _notifications.insert(0, {
      'title': 'Arena Slot Unavailable',
      'message':
          'Notice: Arena blocked for "$reason". Please select alternative available time slots.',
      'date': 'Just Now',
    });

    // 2. Log in Admin Recent Activity
    _adminActivities.insert(0, 'Broadcast Alert: Blocked slot for "$reason"');

    _saveToStorage();
    notifyListeners();
  }

  // Helper method for logging custom admin activities (Offers, Broadcasts, etc.)
  void addAdminActivity(String activity) {
    _adminActivities.insert(0, activity);
    _saveToStorage();
    notifyListeners();
  }

  void cancelBooking(String bookingId) {
    _userBookings.removeWhere((b) => b.id == bookingId);
    _saveToStorage();
    notifyListeners();
  }
}
