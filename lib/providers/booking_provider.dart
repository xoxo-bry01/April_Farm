// lib/providers/booking_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  BookingProvider() {
    loadBookingsFromStorage();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _bookings.map((booking) => booking.toMap()).toList(),
    );
    await prefs.setString('april_farm_bookings', encodedData);
  }

  Future<void> loadBookingsFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('april_farm_bookings');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      _bookings = decodedData.map((item) => Booking.fromMap(item)).toList();
      notifyListeners();
    }
  }

  void addBooking(Booking newBooking) {
    _bookings.add(newBooking);
    _saveToStorage();
    notifyListeners();
  }

  void cancelBooking(String bookingId) {
    _bookings.removeWhere((b) => b.id == bookingId);
    _saveToStorage();
    notifyListeners();
  }
}