import 'package:firebase_auth/firebase_auth.dart';

import '../api/firebase_api.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    super.key,
    required this.idUser,
  });

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  //String recieverID = '';
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String groupChatId = '';

  void sendMessage() async {
    String peerId = widget.idUser;
    if (userId.compareTo(peerId) < 0) {
      groupChatId = '${userId + peerId}';
    } else {
      groupChatId = '${peerId + userId}';
    }
    FocusScope.of(context).unfocus();
    await FirebaseApi.uploadMessage(groupChatId, widget.idUser, message);
    _controller.clear();
    print("GroupchatId in newMessageWidget: ${groupChatId}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black87,
                labelText: 'Type your message',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
