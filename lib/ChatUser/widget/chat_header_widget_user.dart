import '../page/user_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/models/model.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<Users> users;

  const ChatHeaderWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Text(
                'ChatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (index == -1) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.search),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserChatPage(user: users[index]),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}
