import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Notification/notification.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';

class DocMyAppointmentPage extends StatefulWidget {
  const DocMyAppointmentPage({super.key});

  @override
  State<DocMyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<DocMyAppointmentPage> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    Provider.of<AppointmentsProvider>(context, listen: false)
        .fetchAppointment();
    // Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();

    Provider.of<DoctorProvider>(context, listen: false)
        .fetchCurrentDoctor(userId);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('My Appointments'),
    //   ),
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (BuildContext context, int index) {
    //             DoctorInformation doctor = doc.firstWhere(
    //                 (doctor) => doctor.doctorId == app[index].doctorId,
    //                 orElse: () => DoctorInformation(
    //                       name: '',
    //                       email: '',
    //                       password: '',
    //                       availableDates: [],
    //                       availableTimeRanges: [],
    //                       contact: '',
    //                       docPhotoUrl: '',
    //                       doctorDoc: '',
    //                       doctorId: '',
    //                       gender: '',
    //                       language: '',
    //                       speciality: '',
    //                       role: '',
    //                       approved: false,
    //                       lastMessageTime: '',
    //                     ));
    //             if (doctor != null) {
    //               return ListTile(
    //                 leading: CircleAvatar(
    //                   backgroundImage: NetworkImage(doctor.docPhotoUrl),
    //                 ),
    //                 title: Text(
    //                   doctor.name,
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.blue, // Change the text color to blue
    //                     fontWeight: FontWeight.bold, // Make the text bold
    //                     fontStyle: FontStyle.italic, // Add italic style
    //                     decoration:
    //                         TextDecoration.underline, // Underline the text
    //                     decorationColor:
    //                         Colors.orange, // Set the underline color to orange
    //                     decorationThickness: 2, // Set the underline thickness
    //                   ),
    //                 ),
    //                 subtitle: Text(
    //                   'Date: ${app[index].date}',
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.blue, // Change the text color to blue
    //                     fontWeight: FontWeight.bold, // Make the text bold
    //                     fontStyle: FontStyle.italic, // Add italic style
    //                     decoration:
    //                         TextDecoration.underline, // Underline the text
    //                     decorationColor:
    //                         Colors.orange, // Set the underline color to orange
    //                     decorationThickness: 2, // Set the underline thickness
    //                   ),
    //                 ),
    //                 trailing: Text(
    //                   'Time: ${app[index].timeRange}',
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.blue, // Change the text color to blue
    //                     fontWeight: FontWeight.bold, // Make the text bold
    //                     fontStyle: FontStyle.italic, // Add italic style
    //                     decoration:
    //                         TextDecoration.underline, // Underline the text
    //                     decorationColor:
    //                         Colors.orange, // Set the underline color to orange
    //                     decorationThickness: 2, // Set the underline thickness
    //                   ),
    //                 ),
    //               );
    //             } else {
    //               return const ListTile(
    //                 title: Text('Doctor not found'),
    //               );
    //             }
    //           },
    //           childCount: app.length,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    final appointments = Provider.of<AppointmentsProvider>(context);
    final List<Appointment> app = appointments.appointments;

    // final doctors = Provider.of<DoctorProvider>(context);
    // final List<DoctorInformation> doc = doctors.doctors;

    final doctors = Provider.of<UserProvider>(context);
    final List<Users> doc = doctors.getUsers;

    final doctor = Provider.of<DoctorProvider>(context);
    final DoctorInformation docto = doctor.currentUser!;

    return Container(
      height: 800,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: doc.length,
        itemBuilder: (context, index) {
          Users doctor = doc.firstWhere(
              (doctor) =>
                  doctor.uid == app[index].userId &&
                  (docto.doctorId == app[index].doctorId),
              orElse: () => const Users(
                    name: '',
                    email: '',
                    password: '',
                    role: '',
                    lastMessageTime: '',
                    photoUrl: '',
                    uid: '',
                    followers: [],
                    following: [],
                  ));
          if (doctor.uid == app[index].userId &&
              docto.doctorId == app[index].doctorId) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 2.8,
                  width: 400,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.yellow,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.network(
                              doctor.photoUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image(
                            //   image: NetworkImage(doc[index].docPhotoUrl),
                            // ),
                            Text(doctor.name,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue.withOpacity(0.6))),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              doctor.email,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue.withOpacity(0.6)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text('Dates: ${app[index].date}',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue.withOpacity(0.6))),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Times: ${app[index].timeRange}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue.withOpacity(0.6)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
