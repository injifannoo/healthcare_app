import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Post/post.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';
import 'comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Users user = Provider.of<UserProvider>(context).getCurrentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublised', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.name}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await postMethod().postComment(
                    widget.snap['postId'],
                    _commentController.text,
                    user.uid,
                    user.name,
                    user.photoUrl,
                  );
                  setState(() {
                    _commentController.text = '';
                  });
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: const Text(
                      'Comment',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
