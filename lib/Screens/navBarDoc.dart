import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/Post/feeds.dart';
import 'package:healthcare_app/Screens/editUserProfile.dart';
import 'package:healthcare_app/Screens/login_screen.dart';
import '../Auntethication/auntethication.dart';

class NavBarDoc extends StatefulWidget {
  const NavBarDoc({super.key});

  @override
  State<NavBarDoc> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarDoc> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _doctor;
  String _displayName = '';
  String _email = '';
  String _image = '';

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
        _image = userSnapshot.get('docPhotoUrl');
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
              leading: const Icon(Icons.post_add_rounded),
              title: Text('Post'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Feed(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatsPage(),
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.light),
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
