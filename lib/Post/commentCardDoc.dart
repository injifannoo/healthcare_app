import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';

class CommentCardDoc extends StatefulWidget {
  final snap;
  const CommentCardDoc({super.key, this.snap});

  @override
  State<CommentCardDoc> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCardDoc> {
  @override
  Widget build(BuildContext context) {
    final DoctorInformation doctor =
        Provider.of<DoctorProvider>(context).currentUser!;

    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        //text: widget.snap['name'],
                        text: doctor.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${widget.snap['text']}',
                      ),
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(18),
            child: const Icon(
              Icons.favorite,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
