import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';
import '../usecases/usecase_import.dart';
import '../Health_professional/health_proffessional.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DayTimeSlot> dayTimeSlots = []; // Define and initialize the list
    final appointmentProvider = Provider.of<PagesProvider>(context);
    final appointment = appointmentProvider.appointment;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Appointment Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Current Appointment',
              style: TextStyle(
                color: Colors.yellowAccent,
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
              ),
            ),
            Text('Patient Name: ${appointment?.patientName}'),
            Text('Appointment Date: ${appointment?.appointmentDate}'),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewAppointment(
                            selectedSlots: dayTimeSlots,
                          )),
                );
                debugPrint('create something here');
              },
              icon: const Icon(Icons.create),
              label: const Text('New Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
