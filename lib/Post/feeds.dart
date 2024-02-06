//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'postExport.dart';

class Feed extends StatefulWidget {
  Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  String? selectedRole;

  void goAddPost() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    DocumentSnapshot doctorSnapshot =
        await FirebaseFirestore.instance.collection('Doctor').doc(userId).get();
    DocumentSnapshot adminSnapshot =
        await FirebaseFirestore.instance.collection('Admins').doc(userId).get();

    String userRole = userSnapshot.exists ? userSnapshot.get('role') : '';
    String doctorRole = doctorSnapshot.exists ? doctorSnapshot.get('role') : '';
    String adminRole = adminSnapshot.exists ? adminSnapshot.get('role') : '';
    bool approved =
        doctorSnapshot.exists ? doctorSnapshot.get('approved') : false;
    bool approvedAdmin =
        adminSnapshot.exists ? adminSnapshot.get('approved') : false;

    if ((userRole == 'doctor' || doctorRole == 'doctor') && approved == true) {
      Navigator.of(context as BuildContext).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AddPost(),
        ),
      );
    } else {
      Navigator.of(context as BuildContext).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Feed(),
        ),
      );
    }
  }

  Future<String> role() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    DocumentSnapshot doctorSnapshot =
        await FirebaseFirestore.instance.collection('Doctor').doc(userId).get();
    DocumentSnapshot adminSnapshot =
        await FirebaseFirestore.instance.collection('Admins').doc(userId).get();

    String userRole = userSnapshot.exists ? userSnapshot.get('role') : '';
    String doctorRole = doctorSnapshot.exists ? doctorSnapshot.get('role') : '';
    String adminRole = adminSnapshot.exists ? adminSnapshot.get('role') : '';
    bool approved =
        doctorSnapshot.exists ? doctorSnapshot.get('approved') : false;
    bool approvedAdmin =
        adminSnapshot.exists ? adminSnapshot.get('approved') : false;
    return doctorRole;
  }

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
        leading: IconButton(
          onPressed: () {
            if (role == 'doctor') {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AddPost()));
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPost(),
                ),
              );
            }
          },
          icon: const Icon(Icons.post_add_outlined),
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
              itemBuilder: (context, index) => PostCard(
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
