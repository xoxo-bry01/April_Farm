import 'package:flutter/material.dart';

class BookingModel {
  final String id;
  final String service;
  final String date;
  final String time;
  final String arena;
  final String status;
  final String payment;

  BookingModel({
    required this.id,
    required this.service,
    required this.date,
    required this.time,
    required this.arena,
    required this.status,
    required this.payment,
  });
}

class BookingProvider extends ChangeNotifier {
  final List<BookingModel> _upcomingBookings = [
    BookingModel(
      id: '1',
      service: 'Arena Hire',
      date: 'Wed, 19 Aug 2026',
      time: '10:00 AM - 10:50 AM',
      arena: 'Outdoor Arena',
      status: 'Confirmed',
      payment: 'Paid',
    ),
  ];

  List<BookingModel> get upcomingBookings => List.unmodifiable(_upcomingBookings);

  // Method to add a new booking dynamically
  void addBooking({
    required String service,
    required String date,
    required String time,
    String arena = 'Main Arena',
  }) {
    final newBooking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      service: service,
      date: date,
      time: time,
      arena: arena,
      status: 'Confirmed',
      payment: 'Paid',
    );

    _upcomingBookings.insert(0, newBooking);
    notifyListeners(); // Automatically rebuilds listening screens!
  }

  // Method to cancel a booking
  void cancelBooking(String id) {
    _upcomingBookings.removeWhere((booking) => booking.id == id);
    notifyListeners();
  }
}