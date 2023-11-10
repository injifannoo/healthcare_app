import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare_app/Providers/provider.dart';
import 'package:healthcare_app/models/model.dart';
import 'package:provider/provider.dart';

import '../api/firebase_api_user.dart';
import '../model/message_user.dart';
import 'message_widget_user.dart';
import 'package:flutter/material.dart';

class MessageUsersWidget extends StatefulWidget {
  final String idUser;

  const MessageUsersWidget({
    super.key,
    required this.idUser,
  });

  @override
  State<MessageUsersWidget> createState() => _MessageUsersWidgetState();
}

class _MessageUsersWidgetState extends State<MessageUsersWidget> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    print('idUser value in MessageUsersWidget : ${widget.idUser}');

    // final doc = Provider.of<DoctorProvider>(context);
    // final DoctorInformation? doctor = doc.currentUser;
    if (widget.idUser == null) {
      // Data is not passed
      return Scaffold(
        appBar: AppBar(
          title: buildText('Error: User data not provided'),
        ),
        body: const Center(
          child: Text('No user data provided.'),
        ),
      );
    } else {
      return StreamBuilder<List<MessageUser>>(
        stream: FirebaseApiUser.getMessageUsers(widget.idUser),
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

                          return MessageUserWidget(
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
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
