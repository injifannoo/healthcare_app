import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditAdminProfile extends StatefulWidget {
  const EditAdminProfile({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<EditAdminProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _doctor;
  String _displayName = '';
  String _email = '';
  String _contact = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    _doctor = _auth.currentUser;
    if (_doctor != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('Doctor').doc(_doctor!.uid).get();
      setState(() {
        _displayName = userSnapshot.get('name');
        _email = _doctor!.email!;
        _contact = userSnapshot.get('contact');
        _nameController.text = _displayName;
        _emailController.text = _email;
        _contactController.text = _contact;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (_doctor != null) {
      await _firestore.collection('Doctor').doc(_doctor!.uid).update({
        'name': _displayName,
        'email': _email,
        'contact': _contact,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _displayName,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 1.0),
                          Text(
                            _email,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Phone:  ${_contact}',
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
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      _displayName = value;
                    });
                  },
                  controller: _nameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  controller: _emailController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onChanged: (value) {
                    setState(() {
                      _contact = value;
                    });
                  },
                  controller: _contactController,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
