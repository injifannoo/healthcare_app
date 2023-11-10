import 'dart:async';
//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare_app/Providers/provider.dart';
import '../../models/model.dart';
import '../model/message.dart';
import '../utils.dart';

class FirebaseApi {
  static dynamic json;
  static Stream<List<DoctorInformation>> getUsers() =>
      FirebaseFirestore.instance
          .collection('Doctor')
          .orderBy(DoctorField.lastMessageTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(DoctorInformation.fromSnap(json)
                  as Function(Map<String, dynamic> json))
              as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
                  List<DoctorInformation>>);

  static Future<void> uploadMessage(
      String groupChatId, String idUser, String message) async {
    try {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$groupChatId/messages');

      final userId = FirebaseAuth.instance.currentUser!.uid;

      //final user =FirebaseFirestore.instance.collection("users").doc(userId).get();

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      //List<Users> users = [];

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      String name = userData['name'] ?? '';
      String email = userData['email'] ?? '';
      String password = userData['password'] ?? '';
      String photoUrl = userData['photoUrl'] ?? '';
      String uid = userData['uid'] ?? '';
      List followers = userData['followers'] ?? '';
      List following = userData['following'] ?? '';
      String lastMessageTime = userData['lastMessageTime'] ?? '';
      String role = userData['role'] ?? '';

      Users user = Users(
          name: name,
          email: email,
          password: password,
          photoUrl: photoUrl,
          uid: uid,
          followers: followers,
          following: following,
          role: role,
          lastMessageTime: lastMessageTime);

      // Users? currentUser = UserProvider().getCurrentUser;
      if (user == null) {
        throw Exception("Current user is null");
      }
      print("user id in firebaseAPi: ${user.uid}");

      final myId = user.uid;
      final myUsername = user.name;
      final myUrlAvatar = user.photoUrl;
      final recieverId = idUser;

      final newMessage = Message(
        idUser: myId,
        recieverId: recieverId,
        urlAvatar: myUrlAvatar,
        username: myUsername,
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('Doctor');
      await refUsers.doc(idUser).update({
        DoctorField.lastMessageTime: DateTime.now().toString(),
      });
      print(user.name);
    } catch (e) {
      print('Error uploading message: $e');
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
    final refUsers = FirebaseFirestore.instance.collection('Doctor');

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
