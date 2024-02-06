import 'package:flutter/material.dart';
import 'package:healthcare_app/Notification/notification.dart';
// Import DateFormat from intl package
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'app.dart'; // Import the DoctorInformation class
import 'package:intl/intl.dart';

class AppointmentConfirmationScreen extends StatefulWidget {
  final DoctorInformation doctor;
  final String selectedDate;
  //final TimeOfDay selectedTime;
  final String selectedTimeRange;

  const AppointmentConfirmationScreen({
    super.key,
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

// Function to format the date (You can customize this as needed)
  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('MMMM d, yyyy').format(date);
    return formattedDate;
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
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green, // Change the text color to green
                fontWeight: FontWeight.bold, // Make the text bold
                fontStyle: FontStyle.italic, // Add italic style
                decoration: TextDecoration.underline, // Underline the text
                decorationColor:
                    Colors.orange, // Set the underline color to orange
                decorationThickness: 2, // Set the underline thickness),
              ),
            ),
            //         Text(
            //           'Doctor: ${widget.doctor.doctorId}',
            //           style: const TextStyle(
            //           fontSize: 18,
            // color: Colors.green,  // Change the text color to green
            // fontWeight: FontWeight.bold,  // Make the text bold
            // fontStyle: FontStyle.italic,  // Add italic style
            // decoration: TextDecoration.underline,  // Underline the text
            // decorationColor: Colors.orange,  // Set the underline color to orange
            // decorationThickness: 2,  // Set the underline thickness),
            //         ),
            //         ),
            Text(
              'Date: ${(widget.selectedDate)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue, // Change the text color to blue
                fontWeight: FontWeight.bold, // Make the text bold
                fontStyle: FontStyle.italic, // Add italic style
                decoration: TextDecoration.underline, // Underline the text
                decorationColor:
                    Colors.orange, // Set the underline color to orange
                decorationThickness: 2, // Set the underline thickness
              ),
            ),

            Text(
              'Time: ${widget.selectedTimeRange}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green, // Change the text color to green
                fontWeight: FontWeight.bold, // Make the text bold
                fontStyle: FontStyle.italic, // Add italic style
                decoration: TextDecoration.underline, // Underline the text
                decorationColor:
                    Colors.orange, // Set the underline color to orange
                decorationThickness: 2, // Set the underline thickness
              ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyNotification(),
                  ),
                );
              },
              child: const Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
