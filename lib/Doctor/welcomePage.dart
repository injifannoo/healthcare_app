import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/doc_my_appt.dart';
import 'package:healthcare_app/Appointment/my_appointment_page.dart';
import 'package:healthcare_app/Patient/home.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/health.jpg', // Add your health app icon image
              width: 150, // Set the desired width
              height: 150, // Set the desired height
            ),
            const SizedBox(height: 20), // Add some spacing

            const Text(
              'Welcome to\nYour Health App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white, // Set the text color
                fontWeight: FontWeight.bold, // Apply a bold font weight
              ),
            ),

            const SizedBox(height: 20), // Add some spacing

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DocMyAppointmentPage()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent, // Set button text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Set padding
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('My Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
