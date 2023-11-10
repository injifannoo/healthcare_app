import '../api/firebase_api_user.dart';
import 'package:flutter/material.dart';

class NewMessageUserWidget extends StatefulWidget {
  final String idUser;

  const NewMessageUserWidget({
    super.key,
    required this.idUser,
  });

  @override
  _NewMessageUserWidgetState createState() => _NewMessageUserWidgetState();
}

class _NewMessageUserWidgetState extends State<NewMessageUserWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessageUser() async {
    print("in NewMessageUserWidget  ${widget.idUser}");

    FocusScope.of(context).unfocus();
    await FirebaseApiUser.uploadMessageUser(widget.idUser, message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    print('idUser value in NewMessageUserWidget : ${widget.idUser}');

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
            onTap: message.trim().isEmpty ? null : sendMessageUser,
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
