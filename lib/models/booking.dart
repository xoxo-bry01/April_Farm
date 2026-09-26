class Booking {
  final String id;
  final String serviceName;
  final String customerName;
  final DateTime date;
  final String status;
  final bool isManualEntry;
  final String specialNotes;

  Booking({
    required this.id,
    required this.serviceName,
    required this.customerName,
    required this.date,
    this.status = 'Paid',
    this.isManualEntry = false,
    this.specialNotes = '',
  });

  // Factory constructor to convert Supabase JSON data safely
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id:
          json['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      serviceName: json['service_name'] ?? 'Lesson',
      customerName: json['customer_name'] ?? 'Rider',
      date: json['booking_date'] != null
          ? DateTime.parse(json['booking_date'])
          : DateTime.now(),
      status: json['status'] ?? 'Paid',
      isManualEntry: json['is_manual_entry'] ?? false,
      specialNotes: json['special_notes'] ?? '',
    );
  }

  // Method to convert a Booking instance into a Map for Supabase inserts
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
      'customer_name': customerName,
      'booking_date': date.toIso8601String(),
      'status': status,
      'is_manual_entry': isManualEntry,
      'special_notes': specialNotes,
    };
  }
}
