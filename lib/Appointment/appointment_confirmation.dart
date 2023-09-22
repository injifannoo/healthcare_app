import 'package:flutter/material.dart';
// Import DateFormat from intl package
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'app.dart'; // Import the DoctorInformation class

class AppointmentConfirmationScreen extends StatefulWidget {
  final DoctorInformation doctor;
  final DateTime selectedDate;
  //final TimeOfDay selectedTime;
  final String selectedTimeRange;

  const AppointmentConfirmationScreen({super.key, 
    required this.doctor,
    //required this.appointment,
    required this.selectedDate,
    //required this.selectedTime,
    required this.selectedTimeRange,
  });

  @override
  State<AppointmentConfirmationScreen> createState() =>
      _AppointmentConfirmationScreenState();
}

class _AppointmentConfirmationScreenState
    extends State<AppointmentConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppointmentsProvider>(context, listen: false)
        .fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    final apppointments = Provider.of<AppointmentsProvider>(context);
    final List<Appointment> app = apppointments.appointments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointment Confirmation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Doctor: ${widget.doctor.name}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Doctor: ${widget.doctor.doctorId}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Date: ${widget.doctor.availableDates}', // Format the date
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Time: ${widget.doctor.availableTimeRanges}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for booking your appointment!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: const Text('Back to Doctor Details'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAppointmentPage(),
                  ),
                );
              },
              child: const Text('My Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
