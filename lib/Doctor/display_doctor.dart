import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'doctor.dart';

class DisplayDoctor extends StatefulWidget {
  const DisplayDoctor({super.key});

  @override
  State<DisplayDoctor> createState() => _DisplayDoctorState();
}

class _DisplayDoctorState extends State<DisplayDoctor> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doctors = doctor.doctors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Wel Come to Doctor\'s List'),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    //Displaying Image from firestore database
                    // leading: CircleAvatar(
                    //     child: Image.network('doctors[index].docPhotoUrl')),
                    title: Text(doctors[index].name),
                    subtitle: Text(doctors[index].speciality),
                    // You can navigate to user details screen on tap
                    onTap: () {
                      // Navigate to user details screen and pass the selected user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(
                                  doctor: doctors[index],
                                )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
