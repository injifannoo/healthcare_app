import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
//import 'dart:html';

class DoctorInformation {
  final String email;
  final String password;
  final String name;
  final String speciality;
  // final String experience;
  final String docPhotoUrl;
  final String doctorId;
  // final String location;
  final String language;
  // final bool telemedicineAvailable;
  // final List<String> servicesOffered;
  // final String education;
  final String contact;
  // final bool available;
  // final String pricing;
  final String gender;
  final String doctorDoc;
  List<dynamic> availableDates;
  List<dynamic> availableTimeRanges;

  DoctorInformation({
    required this.email,
    required this.password,
    required this.name,
    required this.speciality,
    required this.language,
    required this.contact,
    required this.gender,
    // required this.education,
    // required this.experience,
    required this.docPhotoUrl,
    required this.doctorId,
    required this.doctorDoc,
    required this.availableDates,
    required this.availableTimeRanges,
    // required this.location,
    // required this.telemedicineAvailable,
    // required this.servicesOffered,

    // required this.available,
    // required this.pricing,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'speciality': speciality,
        // 'exerience': experience,
        'docPhotoUrl': docPhotoUrl,
        'doctorDoc': doctorDoc,
        // 'location': location,
        'language': language,
        // 'telemed': telemedicineAvailable,
        // 'service': servicesOffered,
        // 'education': education,
        'contact': contact,
        // 'available': available,
        // 'price': pricing,
        'gender': gender,
        'doctorId': doctorId,
        'availableDates': availableDates,
        'availableTimeRanges':
            availableTimeRanges.map((range) => range).toList(),
      };
  static DoctorInformation fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return DoctorInformation(
      email: snapshot['email'],
      password: snapshot['password'],
      name: snapshot['name'],
      speciality: snapshot['speciality'],
      // experience: snapshot['experience'],
      // location: snapshot['location'],
      language: snapshot['language'],
      // telemedicineAvailable: snapshot['telemedicineAvailable'],
      // servicesOffered: snapshot['servicesOffered'],
      // education: snapshot['education'],
      contact: snapshot['contactInformation'],
      // available: snapshot['available'],
      // pricing: snapshot['pricing'],
      gender: snapshot['gender'],
      docPhotoUrl: snapshot['docPhotoUrl'],
      doctorDoc: snapshot['doctorDoc'],
      doctorId: snapshot['doctorId'],
      availableDates: snapshot['availableDates'],
      availableTimeRanges: snapshot['availableTimesRanges'],
    );
  }
}
