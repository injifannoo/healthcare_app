import 'dart:async';
//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare_app/Providers/provider.dart';
import '../../models/model.dart';
import '../model/message_user.dart';
import '../utils.dart';

class FirebaseApiUser {
  static dynamic json;

  static Stream<List<Users>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageUserTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(
              Users.fromSnap(json) as Function(Map<String, dynamic> json))
          as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<Users>>);

  static Future<void> uploadMessageUser(String idUser, String message) async {
    try {
      final refMessageUsers =
          FirebaseFirestore.instance.collection('chats/$idUser/messages');

      final userId = FirebaseAuth.instance.currentUser!.uid;

      //final user =FirebaseFirestore.instance.collection("users").doc(userId).get();

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Doctor')
          .doc(userId)
          .get();
      //List<Users> users = [];

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
      String role = userData['role'] ?? '';

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
          role: role,
          lastMessageTime: lastMessageTime);

      // Users? currentUser = UserProvider().getCurrentUser;
      if (doctor == null) {
        throw Exception("Current user is null");
      }

      final myId = doctor.doctorId;
      final myUsername = doctor.name;
      final myUrlAvatar = doctor.docPhotoUrl;

      final newMessageUser = MessageUser(
        idUser: myId,
        urlAvatar: myUrlAvatar,
        username: myUsername,
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessageUsers.add(newMessageUser.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers.doc(idUser).update({
        UserField.lastMessageUserTime: DateTime.now(),
      });
      print(doctor.name);
    } catch (e) {
      print('Error uploading message: $e');
      // Handle error appropriately, e.g., show error message to user
    }
  }

  static Stream<List<MessageUser>> getMessageUsers(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageUserField.createdAt, descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => MessageUser.fromJson(doc.data()))
            .toList();
      });

  static Future addRandomUsers(List<Users> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user;

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
