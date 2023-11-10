import 'dart:async';
//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare_app/Providers/provider.dart';
import '../../models/model.dart';
import '../model/message2.dart';
import '../utils.dart';

class FirebaseApi2 {
  static dynamic json;
  static Stream<List<Users>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageUserTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(
              Users.fromSnap(json) as Function(Map<String, dynamic> json))
          as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<Users>>);

  static Future<void> uploadMessage(
      String groupChatId, String idUser, String message) async {
    try {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$groupChatId/messages');

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
      String doctorId = userData['doctorId'];
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

      final newMessage = Message(
        idUser: myId,
        urlAvatar: myUrlAvatar,
        username: myUsername,
        message: message,
        recieverId: idUser,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers.doc(idUser).update({
        UserField.lastMessageUserTime: DateTime.now().toString(),
      });
      print("in firebaseApi: ${doctor.name}");
    } catch (e) {
      print('Error uploading message in firebaseApi2: $e');
      // Handle error appropriately, e.g., show error message to user
    }
  }

  static Stream<List<Message>> getMessages(String groupChatId) =>
      FirebaseFirestore.instance
          .collection('chats/$groupChatId/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => Message.fromJson(doc.data()))
            .toList();
      });

  static Future addRandomUsers(List<DoctorInformation> users) async {
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
