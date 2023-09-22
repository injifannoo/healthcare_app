import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_app/Auntethication/auth.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  //for refreshUsers
  Users? _user;
  final Auth _auth = Auth();
  Users get getCurrentUser => _user!;
  //for fetchUsers function
  List<Users> _users = [];
  List<Users> get getUsers => _users;

  Future<void> refreshUser() async {
    Users user = await _auth.getUserDetails();
    _user = user;
  }

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
          lastMessageTime: userSnapshot.get('lastMessageTime'),
          uid: userSnapshot.get('uid'),
          followers: userSnapshot.get("followers"),
          following: userSnapshot.get("following"),
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
        lastMessageTime: userSnapshot.get('lastMessageTime'),
        uid: userSnapshot.get('uid'),
        followers: userSnapshot.get("followers"),
        following: userSnapshot.get("following"),
        // Add other user properties as needed
      );
      notifyListeners();
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }
}
