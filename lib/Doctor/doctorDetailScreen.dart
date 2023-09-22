import 'package:flutter/material.dart';
import '../models/model.dart';
import 'book_appointment.dart'; // Import the DoctorInformation class

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorInformation doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //display image
            // CircleAvatar(child: Image.network(doctor.docPhotoUrl)),
            // const SizedBox(height: 10),
            Text(
              doctor.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Name: ${doctor.name}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${doctor.email}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Speciality: ${doctor.speciality}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Contact: ${doctor.contact}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Gender: ${doctor.gender}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Language: ${doctor.language}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Available Dates: ${doctor.availableDates.join(", ")}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Available Time Ranges: ${doctor.availableTimeRanges.join(", ")}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Navigate to the appointment booking screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAppointmentScreen(doctor: doctor),
                  ),
                );
              },
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
