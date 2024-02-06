//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/Post/user_postcard.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'postExport.dart';

class FeedUser extends StatefulWidget {
  FeedUser({super.key});

  @override
  State<FeedUser> createState() => _FeedState();
}

class _FeedState extends State<FeedUser> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/images/health.jpg',
          color: primaryColor,
          height: 12,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ChatsPage()));
              },
              icon: const Icon(Icons.messenger_outline))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) => PostCardUser(
                snap: snapshot.data?.docs[index].data(),
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
