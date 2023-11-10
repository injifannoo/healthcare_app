import '../model/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
              radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).canvasColor : Colors.blue,
            borderRadius: isMe
                ? borderRadius
                    .subtract(const BorderRadius.only(bottomLeft: radius))
                : borderRadius
                    .subtract(const BorderRadius.only(bottomRight: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.blue : Colors.red),
            textAlign: isMe ? TextAlign.start : TextAlign.end,
          ),
        ],
      );
}
