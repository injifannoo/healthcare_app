import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import '../Doctor/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Screens/editDoctorProfile.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _doctor;
  String _displayName = '';
  String _email = '';
  String _contact = '';
  String _speciality = '';

  @override
  void initState() {
    super.initState();
    _getDoctorProfile();
  }

  Future<void> _getDoctorProfile() async {
    _doctor = _auth.currentUser;
    if (_doctor != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('Doctor').doc(_doctor!.uid).get();
      setState(() {
        _displayName = userSnapshot.get('name');
        _email = _doctor!.email!;
        _contact = userSnapshot.get('contact');
        _speciality = userSnapshot.get('speciality');
      });
    }
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditDoctorProfile(),
      ),
    ).then((updatedProfile) {
      if (updatedProfile != null) {
        setState(() {
          _displayName = updatedProfile['name'];
          _email = updatedProfile['email'];
          _displayName = updatedProfile['contact'];
          _displayName = updatedProfile['speciality'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  _displayName,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  _email,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Phone:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  _contact,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Speciality:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  _speciality,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _editProfile,
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     final doctor = Provider.of<DoctorProvider>(context);
//     final DoctorInformation? doctors = doctor.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Doctor Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(
//             horizontal: 0,
//             vertical: 10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   //display image
//                   CircleAvatar(child: Image.asset(doctors!.docPhotoUrl)),
//                   const SizedBox(height: 15),
//                   Text(
//                     doctors.name,
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Name:' '${doctors.name}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   // Underline the text
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               Text(
//                 'Email: ${doctors.email}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               Text(
//                 'Speciality: ${doctors.speciality}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Contact: ${doctors.contact}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Gender: ${doctors.gender}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Language: ${doctors.language}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               Text(
//                 'Available Dates: ${doctors.availableDates.join(", ")}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Available Time Ranges: ${doctors.availableTimeRanges.join(", ")}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.green, // Change the text color to green
//                   fontWeight: FontWeight.bold, // Make the text bold
//                   fontStyle: FontStyle.italic, // Add italic style
//                   decorationColor:
//                       Colors.orange, // Set the underline color to orange
//                   decorationThickness: 2,
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
