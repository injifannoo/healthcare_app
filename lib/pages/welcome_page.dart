import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final a = AppBar(
    backgroundColor: Colors.brown,
    title: const Text('Checkin'),
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
      body:
          const Center(child: Expanded(child: Text('WELCOME TO ABC HOSPITAL'))),
    );
  }
}
