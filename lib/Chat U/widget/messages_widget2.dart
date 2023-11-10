import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare_app/Providers/provider.dart';
import 'package:healthcare_app/models/model.dart';
import 'package:provider/provider.dart';

import '../api/firebase_api2.dart';
import '../model/message2.dart';
import 'message_widget2.dart';
import 'package:flutter/material.dart';

class MessagesWidget2 extends StatefulWidget {
  final String idUser;

  const MessagesWidget2({
    super.key,
    required this.idUser,
  });

  @override
  State<MessagesWidget2> createState() => _MessagesWidget2State();
}

class _MessagesWidget2State extends State<MessagesWidget2> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String groupChatId = '';

  @override
  void initState() {
    super.initState();
    // final userId = FirebaseAuth.instance.currentUser?.uid;
    // if (userId != null) {
    //   Provider.of<DoctorProvider>(context, listen: false)
    //       .fetchCurrentDoctor(userId);
    // }
  }

  String groupId() {
    String peerId = widget.idUser;
    if (userId.compareTo(peerId) < 0) {
      groupChatId = '${userId + peerId}';
    } else {
      groupChatId = '${peerId + userId}';
      print("Groupchat in MessageWedget: ${groupChatId}");
    }
    return groupChatId;
  }

  @override
  Widget build(BuildContext context) {
    // final doc = Provider.of<DoctorProvider>(context);
    // final DoctorInformation? doctor = doc.currentUser;
    return StreamBuilder<List<Message>>(
      stream: FirebaseApi2.getMessages(groupId()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final messages = snapshot.data;

              return messages!.isEmpty
                  ? buildText('Say Hi..')
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];

                        return MessageWidget(
                          message: message,
                          isMe: message.idUser == userId,
                        );
                      },
                    );
            }
        }
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
