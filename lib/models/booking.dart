// lib/models/booking.dart
class Booking {
  final String id;
  final String serviceName;
  final String customerName;
  final DateTime date;
  final String status;
  final bool isManualEntry;

  Booking({
    required this.id,
    required this.serviceName,
    required this.customerName,
    required this.date,
    required this.status,
    this.isManualEntry = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceName': serviceName,
      'customerName': customerName,
      'date': date.toIso8601String(),
      'status': status,
      'isManualEntry': isManualEntry,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      serviceName: map['serviceName'],
      customerName: map['customerName'],
      date: DateTime.parse(map['date']),
      status: map['status'],
      isManualEntry: map['isManualEntry'] ?? false,
    );
  }
}