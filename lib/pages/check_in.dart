import 'package:flutter/material.dart';
import 'package:healthcare_app/pages/pages.dart';

class Checkin extends StatelessWidget {
  Checkin({super.key});
  final a = AppBar(
    backgroundColor: Colors.brown,
    title: const Text('Checkin'),
    leading: GestureDetector(
      child: const Icon(Icons.menu),
      onTap: () {},
    ),
    actions: [
      GestureDetector(
        child: const Icon(Icons.settings),
        onTap: () {
          // handle the press
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: a,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()),
                  );
                },
                child: Text('My Appointment')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicalHistoryPage()),
                  );
                },
                child: Text('Medical History')),
          ],
        ),
      ),
    );
  }
}
