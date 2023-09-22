//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String name;
  final String postID;
  final DateTime datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.name,
    required this.postID,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'name': name,
        'postId': postID,
        'datePublished': datePublished,
        'PostUrl': postUrl,
        'ProfileImage': profileImage,
        'likes': likes,
      };
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        postID: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['PostUrl'],
        profileImage: snapshot['ProfileImage'],
        likes: snapshot['likes']);
  }
}
