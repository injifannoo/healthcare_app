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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  //display image
                  // CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: Image.network(doctor.docPhotoUrl),),
                  Image.asset(
                    'assets/images/health.jpg', // Add your health app icon image
                    width: 90, // Set the desired width
                    height: 90,
                    fit: BoxFit.cover, // Set the desired height
                  ),
                  const SizedBox(height: 20),

                  Text(doctor.name,
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              const SizedBox(height: 10),
              // Text(
              //   'Name:''${doctor.name}',
              //   style: const TextStyle(
              //     fontSize: 18,
              //     color: Colors.green, // Change the text color to green
              //     fontWeight: FontWeight.bold, // Make the text bold
              //     fontStyle: FontStyle.italic, // Add italic style
              //      // Underline the text
              //     decorationColor:
              //         Colors.orange, // Set the underline color to orange
              //     decorationThickness: 2,
              //   ),
              // ),
              Row(
                children: [
                  const Icon(Icons.person),
                  Text(
                    ' ${doctor.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                    //const TextStyle(
                    //   fontSize: 18,
                    //   color: Colors.green, // Change the text color to green
                    //   fontWeight: FontWeight.bold, // Make the text bold
                    //   fontStyle: FontStyle.italic, // Add italic style
                    //   decorationColor:
                    //       Colors.orange, // Set the underline color to orange
                    //   decorationThickness: 2,
                    // ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Icon(Icons.email),
                  Text(
                    ' ${doctor.email}',
                    style: Theme.of(context).textTheme.headlineSmall,
                    // const TextStyle(
                    //   fontSize: 18,
                    //   color: Colors.green, // Change the text color to green
                    //   fontWeight: FontWeight.bold, // Make the text bold
                    //   fontStyle: FontStyle.italic, // Add italic style
                    //   decorationColor:
                    //       Colors.orange, // Set the underline color to orange
                    //   decorationThickness: 2,
                    // ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.health_and_safety),
                  Text(
                    ' Specialist of ${doctor.speciality}',
                    style: Theme.of(context).textTheme.headlineSmall,
                    //const TextStyle(
                    //   fontSize: 18,
                    //   color: Colors.green, // Change the text color to green
                    //   fontWeight: FontWeight.bold, // Make the text bold
                    //   fontStyle: FontStyle.italic, // Add italic style
                    //   decorationColor:
                    //       Colors.orange, // Set the underline color to orange
                    //   decorationThickness: 2,
                    // ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.call),
                  Text(
                    ' ${doctor.contact}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.person_2),
                  Text(
                    'Gender: ${doctor.gender}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.language),
                  Text(
                    ' ${doctor.language}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'Available Dates',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Column(
                    children: doctor.availableDates.map((dateTime) {
                      String extractedDate = dateTime.toString().split(" ")[0];
                      return Text(
                        extractedDate,
                        style: Theme.of(context).textTheme.labelMedium,
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Available Times',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        doctor.availableTimeRanges.map<Widget>((timeRange) {
                      final startTime = timeRange
                          .substring(timeRange.indexOf("(") + 1,
                              timeRange.indexOf(")"))
                          .trim();
                      final endTime = timeRange
                          .substring(timeRange.lastIndexOf("(") + 1,
                              timeRange.lastIndexOf(")"))
                          .trim();

                      final formattedTimeRange = '$startTime - $endTime';

                      return Text(
                        formattedTimeRange,
                        style: Theme.of(context).textTheme.labelMedium,
                      );
                    }).toList(),
                  ),
                ],
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
      ),
    );
  }
}
