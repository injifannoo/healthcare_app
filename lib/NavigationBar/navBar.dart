import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_app/Patient/editUserProfile.dart';
import 'package:healthcare_app/Auntethication/login_screen.dart';
import '../Auntethication/auntethication.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _displayName = '';
  String _email = '';
  String _image = '';

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
        _image = userSnapshot.get('photoUrl');
      });
    }
  }

  Future<void> signOut() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _displayName;
    _email;
    _image;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_displayName),
            accountEmail: Text(_email),
            onDetailsPressed: () {
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditUserProfile()),
                  );
                },
                icon: const Icon(Icons.edit),
                //label: const Text('edit'),
              );
            },
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  _image, // Add your health app icon image
                  width: 90, // Set the desired width
                  height: 90,
                  fit: BoxFit.cover, // Set the desired height
                ),
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('My Appointment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyAppointmentPage(),
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('About'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.timeline),
            title: Text('Version 1.1.0'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () => signOut(),
          ),
        ],
      ),
    );
  }
}
