import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import '../Doctor/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Doctor/editDoctorProfile.dart';
import 'package:healthcare_app/Patient/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApproveDoctor extends StatefulWidget {
  DoctorInformation doctor;

  ApproveDoctor({key, required this.doctor}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<ApproveDoctor> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User? _doctor;
  // String _displayName = '';
  // String _email = '';
  // String _contact = '';
  // String _speciality = '';
  bool approved = false;
  // String doctorDoc = '';

  @override
  void initState() {
    super.initState();
    _getDoctorProfile();
  }

  Future<void> _getDoctorProfile() async {
    //_doctor = widget.doctor as User?;

    DocumentSnapshot userSnapshot =
        await _firestore.collection('Doctor').doc(widget.doctor.doctorId).get();
    setState(() {
      //     widget.doctor.name = userSnapshot.get('name');
      //     _email = _doctor!.email!;
      //     _contact = userSnapshot.get('contact');
      //     _speciality = userSnapshot.get('speciality');
      approved = userSnapshot.get('approved');
      //     doctorDoc = userSnapshot.get('doctorDoc');
    });
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDoctorProfile(doctor: widget.doctor),
      ),
    ).then((updatedProfile) {
      if (updatedProfile != null) {
        setState(() {
          widget.doctor.approved = updatedProfile['approved'];
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
                  widget.doctor.name,
                  //_displayName,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  widget.doctor.email,
                  //_email,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Phone:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  widget.doctor.contact,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Approved:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  widget.doctor.approved.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.doctor.doctorDoc,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditDoctorProfile(doctor: widget.doctor),
                      ),
                    ).then((updatedProfile) {
                      if (updatedProfile != null) {
                        setState(() {
                          widget.doctor.approved = updatedProfile['approved'];
                        });
                      }
                    });
                  },
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

class EditDoctorProfile extends StatefulWidget {
  final DoctorInformation doctor;
  const EditDoctorProfile({Key? key, required this.doctor}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<EditDoctorProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // String _displayName = '';
  // String _email = '';
  // String _contact = '';
  // String _speciality = '';
  //String doctorDoc = '';
  bool approved = false;

  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _contactController = TextEditingController();

  // TextEditingController _specialityController = TextEditingController();
  //TextEditingController _doctorDocController = TextEditingController();
  TextEditingController _approvedC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    if (widget.doctor != null) {
      DocumentSnapshot userSnapshot = await _firestore
          .collection('Doctor')
          .doc(widget.doctor.doctorId)
          .get();
      setState(() {
        // _displayName = userSnapshot.get('name');
        // _email = _doctor!.email!;
        // _contact = userSnapshot.get('contact');
        // _speciality = userSnapshot.get('speciality');
        // _nameController.text = _displayName;
        // _emailController.text = _email;
        // _contactController.text = _contact;
        // _specialityController.text = _speciality;
        approved = userSnapshot.get('approved');
        _approvedC.text = approved.toString();
        //_doctorDocController.text = doctorDoc;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (widget.doctor != null) {
      await _firestore.collection('Doctor').doc(widget.doctor.doctorId).update({
        // 'name': _displayName,
        // 'email': _email,
        // 'contact': _contact,
        // 'speciality': _speciality,
        'approved': approved,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User profile updated successfully!')),
      );
    }
    Navigator.pop(context);
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/health.jpg', // Add your health app icon image
                            width: 50, // Set the desired width
                            height: 50,
                            fit: BoxFit.cover, // Set the desired height
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       _displayName,
                      //       style: const TextStyle(
                      //           fontSize: 18.0, fontWeight: FontWeight.bold),
                      //     ),
                      //     const SizedBox(width: 1.0),
                      //     Text(
                      //       _email,
                      //       style: const TextStyle(
                      //           fontSize: 18.0, fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   'specialist of  ${_speciality}',
                //   style: const TextStyle(
                //       fontSize: 18.0, fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   'Phone:  ${_contact}',
                //   style: const TextStyle(
                //       fontSize: 18.0, fontWeight: FontWeight.bold),
                // ),
                Text(
                  'Approved:  ${approved}',
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
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Name'),
                //   onChanged: (value) {
                //     setState(() {
                //       _displayName = value;
                //     });
                //   },
                //   controller: _nameController,
                // ),
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Email'),
                //   onChanged: (value) {
                //     setState(() {
                //       _email = value;
                //     });
                //   },
                //   controller: _emailController,
                // ),
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Speciality'),
                //   onChanged: (value) {
                //     setState(() {
                //       _speciality = value;
                //     });
                //   },
                //   controller: _specialityController,
                // ),
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Phone'),
                //   onChanged: (value) {
                //     setState(() {
                //       _contact = value;
                //     });
                //   },
                //   controller: _contactController,
                // ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    constraints: const BoxConstraints(
                      minWidth: 600,
                      maxWidth: 600,
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('Select role'),
                      iconSize: 40,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: approved.toString(),
                      onChanged: (newValue) {
                        setState(() {
                          approved = newValue == 'true';
                        });
                      },
                      items: <String>['true', 'false']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Approved'),
                //   onChanged: (value) {
                //     setState(() {
                //       approved = value as bool;
                //     });
                //   },
                //   controller: _approvedC,
                // ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: const Text('Approve the Doctor'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
