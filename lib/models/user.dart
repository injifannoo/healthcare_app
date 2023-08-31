//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String password;
  final String name;
  final String photoUrl;
  // final String uid;
  //  final String address;
  // final String dateOfBirth;
  // final String gender;
  // final String phone;

  const Users({
    required this.email,
    required this.password,
    required this.name,
    required this.photoUrl,
    // required this.uid,
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
        // 'uid': uid,
        // 'address': address,
        // 'dateOfBirth': dateOfBirth,
        // 'gender': gender,
        // 'phone': phone,
      };
  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    print('fromSnap');
    return Users(
      email: snapshot['email'],
      password: snapshot['password'],
      name: snapshot['name'],
      photoUrl: snapshot['photoUrl'],
      // uid: snapshot['uid'],
      // address: snapshot['address'],
      // dateOfBirth: snapshot['dateOfBirth'],
      // gender: snapshot['gender'],
      // phone: snapshot['phone'],
    );
  }
}
