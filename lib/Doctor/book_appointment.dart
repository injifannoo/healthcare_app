import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'doctor.dart';

class MyAppointmentScreen extends StatefulWidget {
  final DoctorInformation doctor;

  const MyAppointmentScreen({super.key, required this.doctor});

  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  DateTime? selectedDate;
  String? selectedTimeRange;
  TimeOfDay? selectedTime;

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
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Appointment Dates:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<DateTime>(
              value: selectedDate,
              hint: const Text('Select a date'),
              onChanged: (newDate) {
                setState(() {
                  selectedDate = newDate;
                  print("Selected Date: $selectedDate");
                });
              },
              items: widget.doctor.availableDates
                  .map<DropdownMenuItem<DateTime>>((date) {
                return DropdownMenuItem<DateTime>(
                  value: DateTime.parse(date),
                  child: Text(
                      DateFormat('yyyy-MM-dd').format(DateTime.parse(date))),
                );
              }).toList(),
            ),
            // Inside your _MyAppointmentScreenState class
            DropdownButton<String>(
              value: selectedTimeRange,
              hint: const Text('Select a time range'),
              onChanged: (newTimeRange) {
                print(
                    "Available Time Ranges: ${widget.doctor.availableTimeRanges}");
                print("Selected Time Range: $newTimeRange");
                setState(() {
                  selectedTimeRange = newTimeRange;
                  print("Selected Time Range: $selectedTimeRange");
                });
              },
              items: widget.doctor.availableTimeRanges
                  .map<DropdownMenuItem<String>>(
                (timeRange) {
                  return DropdownMenuItem<String>(
                    value: timeRange,
                    child: Text(timeRange),
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null && selectedTimeRange != null) {
                  Provider.of<AppointmentsProvider>(context, listen: false)
                      .addAppointment(
                    doctorId: widget.doctor
                        .doctorId, // Assuming there's an id field in Appointment
                    date: selectedDate!.toString(),
                    timeRange: selectedTimeRange!,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentConfirmationScreen(
                        doctor: widget.doctor,
                        //appointment: widget.appointment,
                        selectedDate: selectedDate!,
                        selectedTimeRange: selectedTimeRange!,
                      ),
                    ),
                  );
                } else {
                  // Show an error message if date and time are not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a date and time.'),
                    ),
                  );
                }
              },
              child: const Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
