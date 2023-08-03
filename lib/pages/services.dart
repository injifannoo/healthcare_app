import 'package:flutter/material.dart';
import 'package:healthcare_app/pages/chat_page.dart';

class Services extends StatelessWidget {
  Services({super.key});
  final a = AppBar(
    backgroundColor: Colors.brown,
    title: const Text('Services'),
    leading: GestureDetector(
      child: const Icon(Icons.menu),
      onTap: () {},
    ),
    actions: [
      GestureDetector(
        child: const Icon(Icons.settings),
        onTap: () {
          // handle the press
        },
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: a,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
            child: Text('chat'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Consultancy and Education'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Telemedicine'),
          )
        ],
      ),
    );
  }
}
