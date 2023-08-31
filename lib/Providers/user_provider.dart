import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<Users> _users = [];

  List<Users> get users => _users;

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<Users> users = [];
      for (QueryDocumentSnapshot userSnapshot in usersSnapshot.docs) {
        Users user = Users(
          name: userSnapshot.get('name'),
          email: userSnapshot.get('email'),
          password: userSnapshot.get('password'),
          photoUrl: userSnapshot.get('photoUrl'),
        );
        users.add(user);
      }
      _users = users;
      notifyListeners();
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  Users? _currentUser;

  Users? get currentUser => _currentUser;

  Future<void> fetchCurrentUser(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      _currentUser = Users(
        name: userSnapshot.get('name'),
        email: userSnapshot.get('email'),
        password: userSnapshot.get('password'),
        photoUrl: userSnapshot.get('photoUrl'),
        // Add other user properties as needed
      );

      notifyListeners();
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }
}
