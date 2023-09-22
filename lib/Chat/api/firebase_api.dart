import 'dart:async';
//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_app/Providers/provider.dart';
import '../../models/model.dart';
import '../model/message.dart';
import '../utils.dart';

class FirebaseApi {
  static dynamic json;
  static Stream<List<DoctorInformation>> getUsers() =>
      FirebaseFirestore.instance
          .collection('Doctor')
          .orderBy(UserField.lastMessageTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(DoctorInformation.fromSnap(json)
                  as Function(Map<String, dynamic> json))
              as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
                  List<DoctorInformation>>);

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');
    // Replace with your provider

    DoctorInformation currentDoctor = DoctorProvider().currentUser!;
// Assuming you have a currentUser property
    final myId = currentDoctor.doctorId;
    final myUsername = currentDoctor.name;
    final myUrlAvatar = currentDoctor.docPhotoUrl;

    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('Doctor');
    await refUsers
        .doc(idUser)
        .update({DoctorField.lastMessageTime: DateTime.now()});
    print(currentDoctor);
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
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
