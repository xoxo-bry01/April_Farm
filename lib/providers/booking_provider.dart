import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _allBookings = [];
  final List<String> _adminActivities = [];
  final List<String> _notifications = [];

  // Current logged in customer name
  String _currentUserName = 'Bryanna Sonebong';

  // Getters
  List<Booking> get allBookings => List.unmodifiable(_allBookings);

  // FILTERED: Customers ONLY see bookings matching their own name
  List<Booking> get userBookings {
    return List.unmodifiable(
      _allBookings.where((b) => b.customerName == _currentUserName).toList(),
    );
  }

  List<String> get adminActivities => List.unmodifiable(_adminActivities);
  List<String> get notifications => List.unmodifiable(_notifications);

  BookingProvider() {
    _fetchInitialBookings();
  }

  void setCurrentUser(String name) {
    _currentUserName = name;
    notifyListeners();
  }

  Future<void> _fetchInitialBookings() async {
    try {
      final response = await Supabase.instance.client
          .from('tblBooking')
          .select();

      final List<dynamic> data = response as List<dynamic>;
      _allBookings.clear();

      for (var row in data) {
        _allBookings.add(
          Booking(
            id:
                row['id']?.toString() ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            serviceName: row['service_name'] ?? 'Lesson',
            customerName: row['customer_name'] ?? 'Rider',
            date: row['booking_date'] != null
                ? DateTime.parse(row['booking_date'])
                : DateTime.now(),
            status: row['status'] ?? 'Paid',
            isManualEntry: row['is_manual_entry'] ?? false,
            specialNotes: row['special_notes'] ?? '',
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching initial bookings from Supabase: $e');
    }
  }

  Future<void> addCustomerBooking(Booking booking) async {
    _allBookings.add(booking);
    _adminActivities.insert(
      0,
      'New booking added: ${booking.serviceName} for ${booking.customerName}',
    );
    _notifications.insert(
      0,
      'Booking confirmed: ${booking.serviceName} on ${booking.date.day}/${booking.date.month}',
    );
    notifyListeners();

    try {
      await Supabase.instance.client.from('tblBooking').insert({
        'id': booking.id,
        'customer_name': booking.customerName,
        'service_name': booking.serviceName,
        'booking_date': booking.date.toIso8601String(),
        'status': booking.status,
        'is_manual_entry': booking.isManualEntry,
        'special_notes': booking.specialNotes,
      });
    } catch (e) {
      debugPrint('Error writing booking to Supabase: $e');
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    _allBookings.removeWhere((b) => b.id == bookingId);
    _notifications.insert(0, 'Booking cancelled');
    notifyListeners();

    try {
      await Supabase.instance.client
          .from('tblBooking')
          .delete()
          .eq('id', bookingId);
    } catch (e) {
      debugPrint('Error deleting booking from Supabase: $e');
    }
  }

  void addAdminActivity(String activity) {
    _adminActivities.insert(0, activity);
    notifyListeners();
  }
}
