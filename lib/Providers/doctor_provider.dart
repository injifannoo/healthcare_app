import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/model.dart';

class DoctorProvider with ChangeNotifier {
  List<DoctorInformation> _doctors = [];
  List<DoctorInformation> get doctors => _doctors;

  DoctorInformation? _currentUser;
  DoctorInformation? get currentUser => _currentUser;

  Future<void> fetchDoctors() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('Doctor')
          .orderBy(DoctorField.lastMessageTime, descending: true)
          .get();
      List<DoctorInformation> doctors = [];
      for (QueryDocumentSnapshot userSnapshot in usersSnapshot.docs) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        String name = userData['name'] ?? '';
        String email = userData['email'] ?? '';
        String password = userData['password'] ?? '';
        List<String> availableDates =
            (userData['availableDates'] ?? []).cast<String>();
        List<String> availableTimeRanges =
            (userData['availableTimeRanges'] ?? []).cast<String>();
        String contact = userData['contact'] ?? '';
        String docPhotoUrl = userData['docPhotoUrl'] ?? '';
        String doctorDoc = userData['doctorDoc'] ?? '';
        String doctorId = userData['doctorId'] ?? '';
        String gender = userData['gender'] ?? '';
        String language = userData['language'] ?? '';
        String speciality = userData['speciality'] ?? '';
        String lastMessageTime = userData['lastMessageTime'] ?? '';

        DoctorInformation doctor = DoctorInformation(
            name: name,
            email: email,
            password: password,
            availableDates: availableDates,
            availableTimeRanges: availableTimeRanges,
            contact: contact,
            docPhotoUrl: docPhotoUrl,
            doctorDoc: doctorDoc,
            doctorId: doctorId,
            gender: gender,
            language: language,
            speciality: speciality,
            lastMessageTime: lastMessageTime);
        doctors.add(doctor);
      }
      _doctors = doctors;
      notifyListeners();
    } catch (error) {
      print('Error fetching doctors: $error');
    }
  }

  Future<void> fetchCurrentDoctor(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Doctor')
          .doc(userId)
          .get();

      _currentUser = DoctorInformation(
        name: userSnapshot.get('name'),
        email: userSnapshot.get('email'),
        password: userSnapshot.get('password'),
        availableDates: userSnapshot.get('availableDates'),
        availableTimeRanges: userSnapshot.get('availableTimeRanges'),
        contact: userSnapshot.get('contact'),
        docPhotoUrl: userSnapshot.get('docPhotoUrl'),
        doctorDoc: userSnapshot.get('doctorDoc'),
        doctorId: userSnapshot.get('doctorId'),
        gender: userSnapshot.get(' gender'),
        language: userSnapshot.get(' language'),
        speciality: userSnapshot.get('speciality'),
        lastMessageTime: userSnapshot.get('lastMessageTime'),
      );
      notifyListeners();
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }
}
