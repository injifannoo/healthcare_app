import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({super.key});

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppointmentsProvider>(context, listen: false)
        .fetchAppointment();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<AppointmentsProvider>(context);
    final List<Appointment> app = appointments.appointments;

    final doctors = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doc = doctors.doctors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
      ),
      body: ListView.builder(
        itemCount: app.length,
        itemBuilder: (context, index) {
          // Find the corresponding doctor based on doctorId from the appointment
          DoctorInformation doctor = doc.firstWhere(
            (doctor) => doctor.doctorId == app[index].doctorId,
          );

          return ListTile(
            leading: Text(doctor.name),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       doctor.docPhotoUrl), // Assuming doctor has imageURL
            // ),
            title: Text(doctor.email),
            subtitle:
                Text('Date: ${app[index].date}, Time: ${app[index].timeRange}'),
          );
        },
      ),
    );
  }
}
