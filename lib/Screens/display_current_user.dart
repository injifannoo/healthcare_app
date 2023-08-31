import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';

class DisplayCurrentUser extends StatefulWidget {
  const DisplayCurrentUser({Key? key}) : super(key: key);

  @override
  _DisplayUserState createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayCurrentUser> {
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
      appBar: AppBar(title: Text('Current User')),
      body: currentUser != null
          ? Card(
              child: Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.photoUrl),
                      radius: 24,
                    ),
                    Text('Name: ${currentUser.name}'),
                    Text('Email: ${currentUser.email}'),
                    // Display other user properties
                  ]),
            ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
