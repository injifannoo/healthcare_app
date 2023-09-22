import 'package:cloud_firestore/cloud_firestore.dart';
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
    //required String datePublished,
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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print('text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
