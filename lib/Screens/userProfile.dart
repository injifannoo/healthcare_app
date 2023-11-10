// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare_app/Screens/editUserProfile.dart';
// import 'package:healthcare_app/models/user.dart';
// import 'package:provider/provider.dart';

// import '../Providers/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});

//   _UserProfilePageState createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfile> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   User? _user;
//   String _displayName = '';
//   String _email = '';

//   @override
//   void initState() {
//     super.initState();
//     _getUserProfile();
//   }

//   Future<void> _getUserProfile() async {
//     _user = _auth.currentUser;
//     if (_user != null) {
//       DocumentSnapshot userSnapshot =
//           await _firestore.collection('users').doc(_user!.uid).get();
//       setState(() {
//         _displayName = userSnapshot.get('name');
//         _email = _user!.email!;
//       });
//     }
//   }

//   Future<void> _updateUserProfile() async {
//     if (_user != null) {
//       await _firestore.collection('users').doc(_user!.uid).update({
//         'name': _displayName,
//         'email': _email,
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User profile updated successfully!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Display Name:',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//                 Text(
//                   _displayName,
//                   style: const TextStyle(
//                       fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text(
//                   'Email:',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//                 Text(
//                   _email,
//                   style: const TextStyle(
//                       fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Display Name'),
//                   onChanged: (value) {
//                     setState(() {
//                       _displayName = value;
//                     });
//                   },
//                   controller: TextEditingController(text: _displayName),
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   onChanged: (value) {
//                     setState(() {
//                       _email = value;
//                     });
//                   },
//                   controller: TextEditingController(text: _email),
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: _updateUserProfile,
//                   child: const Text('Update Profile'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Screens/editUserProfile.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _displayName = '';
  String _email = '';

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
      });
    }
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditUserProfile(),
      ),
    ).then((updatedProfile) {
      if (updatedProfile != null) {
        setState(() {
          _displayName = updatedProfile['name'];
          _email = updatedProfile['email'];
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
