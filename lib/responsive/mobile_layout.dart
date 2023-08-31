import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Doctor/doctor.dart';
import '../Providers/provider.dart';
import '../models/model.dart' as model;
import '../models/model.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchCurrentUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final Users? currentUser = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile size Healthcare App'),
      ),
      body: currentUser != null
          ? Column(
              children: [
                Text('Name: ${currentUser.name}'),
                // Display other user properties
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
