import '../widget/messages_widget_user.dart';
import '../widget/new_message_widget_user.dart';
import '../widget/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/models/model.dart';

class UserChatPage extends StatelessWidget {
  final Users user;

  const UserChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('User id value in userChatPage: ${user.uid}');

    if (user.uid == null) {
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
      return Scaffold(
        appBar: AppBar(
          title: buildText('ChatsPage'),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: user.name),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessageUsersWidget(idUser: user.uid),
                ),
              ),
              NewMessageUserWidget(idUser: user.uid)
            ],
          ),
        ),
      );
    }
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
        ),
      );
}
