import '../page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/models/model.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<DoctorInformation> users;

  const ChatBodyWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          print('good working');
          return SizedBox(
            height: 75,
            width: 100,
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.docPhotoUrl),
              ),
              title: Text(
                user.name,
                style: const TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
                print("to chatPage name ${user.name}");
              },
            ),
          );
        },
      );
}
