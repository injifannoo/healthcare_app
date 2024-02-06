import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Post/commentCardDoc.dart';
import 'package:healthcare_app/Post/postExport.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';
import 'comment_card.dart';

class CommentScreenDoc extends StatefulWidget {
  final postId;
  const CommentScreenDoc({super.key, this.postId});

  @override
  State<CommentScreenDoc> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreenDoc> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DoctorInformation doctor =
        Provider.of<DoctorProvider>(context).currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.postId)
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
              itemBuilder: (context, index) => CommentCardDoc(
                snap: snapshot.data!.docs[index],
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
                backgroundImage: NetworkImage(doctor!.docPhotoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${doctor.name}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await postMethod().postComment(
                    widget.postId,
                    _commentController.text,
                    doctor.doctorId,
                    doctor.name,
                    doctor.docPhotoUrl,
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
