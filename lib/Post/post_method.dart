import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Auntethication/auntethication.dart';
import '../models/model.dart' as model;
import 'package:uuid/uuid.dart';

class postMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost({
    required String description,
    required String uid,
    required String name,
    //required String postID,
    // required String datePublished,
    //required String postUrl,
    required String profileImage,
    required Uint8List file,
  }) async {
    String res = 'Somer error occurred';
    try {
      // if (email.isNotEmpty ||
      //     password.isNotEmpty ||
      //     address.isNotEmpty ||
      //     dateOfBirth.isNotEmpty ||
      //     gender.isNotEmpty ||
      //     name.isNotEmpty ||
      //     phone.isNotEmpty)
      {
        String postUrl =
            await Storage().uploadImageToStorage('postPics', file, true);
        String postId = const Uuid().v1();
        //add user info to database
        model.Post post = model.Post(
          description: description,
          uid: uid,
          name: name,
          postID: postId,
          datePublished: DateTime.now(),
          postUrl: postUrl,
          profileImage: profileImage,
          likes: [],
        );
        _firestore.collection('posts').doc(postId).set(post.toJson());
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
