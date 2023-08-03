import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../usecases/usecase_import.dart';
import '../models/model.dart';
import '../pages/pages.dart'; // Import the ChatPage

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<PagesProvider>(context);
    String selectedSlot = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate appointment scheduling
                Appointment appointment = Appointment(
                  patientName: 'John Doe',
                  appointmentDate: DateTime.now().add(const Duration(days: 1)),
                );

                appointmentProvider.setAppointment(appointment);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentPage()),
                );
              },
              child: const Text('Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalHistoryPage()),
                );
              },
              child: const Text('Medical History'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
              child: const Text('Chat'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AvailableSlot(
                            onSlotSelected: (String slot) {
                              setState(() {
                                selectedSlot = slot;
                              });
                            },
                          )),
                );
              },
              child: const Text('Available Slot by HP'),
            ),
          ],
        ),
      ),
    );
  }
}
