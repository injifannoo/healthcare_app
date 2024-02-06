//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String name;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.name,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'name': name,
        'postId': postId,
        'datePublished': datePublished,
        'PostUrl': postUrl,
        'ProfileImage': profileImage,
        'likes': likes,
      };
  // static Post fromSnap(DocumentSnapshot snap) {
  //   var snapshot = (snap.data() as Map<String, dynamic>);
  //   return Post(
  //       description: snapshot['description'],
  //       uid: snapshot['uid'],
  //       name: snapshot['name'],
  //       postId: snapshot['postId'],
  //       datePublished: snapshot['datePublished'],
  //       postUrl: snapshot['PostUrl'],
  //       profileImage: snapshot['ProfileImage'],
  //       likes: snapshot['likes']);
  // }
  static Post fromSnap(snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    Map<String, dynamic> userData = snapshot;
    String description = userData['description'] ?? '';
    String uid = userData['uid'] ?? '';
    String name = userData['name'] ?? '';
    DateTime datePublished = userData['datePublished'] ?? '';
    String postUrl = userData['postUrl'] ?? '';
    String postId = userData['postId'] ?? '';
    String profileImage = userData['profileImage'] ?? '';
    String likes = userData['likes'] ?? '';

    return Post(
      name: name,
      description: description,
      uid: uid,
      datePublished: datePublished,
      postUrl: postUrl,
      postId: postId,
      profileImage: profileImage,
      likes: likes,
    );
  }
}
