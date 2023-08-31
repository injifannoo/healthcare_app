import 'dart:convert';

class Appointment {
  final String doctorId;
  final String date;
  final String timeRange;

  Appointment({
    required this.doctorId,
    required this.date,
    required this.timeRange,
  });

  factory Appointment.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Appointment(
      doctorId: json['doctorId'],
      date: json['date'],
      timeRange: json['timeRange'],
    );
  }

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'date': date,
        'timeRange': timeRange,
      };
}
