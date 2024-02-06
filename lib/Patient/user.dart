//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserField {
  static String lastMessageUserTime = 'lastMessageTime';
}

class Users {
  final String email;
  final String password;
  final String name;
  final String photoUrl;
  final String lastMessageTime;
  final String uid;
  final List followers;
  final List following;
  final String role;
  // final String address;
  // final String dateOfBirth;
  // final String gender;
  // final String phone;

  const Users({
    required this.email,
    required this.password,
    required this.name,
    required this.photoUrl,
    required this.lastMessageTime,
    required this.uid,
    required this.followers,
    required this.following,
    required this.role,
    // required this.address,
    // required this.phone,
    // required this.dateOfBirth,
    // required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'photoUrl': photoUrl,
        'lastMessageTime': lastMessageTime!,
        "followers": followers,
        "following": following,
        "role": role,
        "uid": uid,
        // 'address': address,
        // 'dateOfBirth': dateOfBirth,
        // 'gender': gender,
        // 'phone': phone,
      };
  static Users fromSnap(json) {
    var snapshot = (json.data() as Map<String, dynamic>);
    print('fromSnap');
    return Users(
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      name: snapshot['name'],
      photoUrl: snapshot['photoUrl'] ?? '',
      lastMessageTime: snapshot['lastMessageTime'] ?? '', //'uid': uid,
      uid: snapshot['uid'],
      followers: snapshot["followers"] ?? '',
      following: snapshot["following"] ?? '',
      role: snapshot["role"] ?? '',

      // address: snapshot['address'],
      // dateOfBirth: snapshot['dateOfBirth'],
      // gender: snapshot['gender'],
      // phone: snapshot['phone'],
    );
  }

  static DateTime? toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;
  }
}

class Admin {
  final String email;
  final String password;
  final String name;
  final String photoUrl;
  final String uid;
  final bool approved;
  final String role;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String phone;

  const Admin({
    required this.email,
    required this.password,
    required this.name,
    required this.photoUrl,
    required this.uid,
    required this.role,
    required this.address,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.approved,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'photoUrl': photoUrl,
        "role": role,
        "uid": uid,
        'address': address,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phone': phone,
        'approved': approved,
      };
  static Admin fromSnap(json) {
    var snapshot = (json.data() as Map<String, dynamic>);
    print('fromSnap');
    return Admin(
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      name: snapshot['name'],
      photoUrl: snapshot['photoUrl'] ?? '',
      uid: snapshot['uid'],
      role: snapshot["role"] ?? '',
      address: snapshot['address'],
      dateOfBirth: snapshot['dateOfBirth'],
      gender: snapshot['gender'],
      phone: snapshot['phone'],
      approved: snapshot['approved'],
    );
  }
}
