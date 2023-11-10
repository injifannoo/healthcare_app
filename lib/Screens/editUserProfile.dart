import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<EditUserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _displayName = '';
  String _email = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _displayName = userSnapshot.get('name');
        _email = _user!.email!;
        _nameController.text = _displayName;
        _emailController.text = _email;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'name': _displayName,
        'email': _email,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  _displayName,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16.0),
                Text(
                  _email,
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
