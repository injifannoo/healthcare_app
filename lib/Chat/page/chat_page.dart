import '../widget/messages_widget.dart';
import '../widget/new_message_widget.dart';
import '../widget/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/models/model.dart';

class ChatPage extends StatelessWidget {
  final DoctorInformation user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  child: MessagesWidget(idUser: user.doctorId),
                ),
              ),
              NewMessageWidget(idUser: user.doctorId)
            ],
          ),
        ),
      );
  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
