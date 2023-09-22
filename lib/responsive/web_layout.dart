import 'package:flutter/material.dart';

import '../Doctor/doctor.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

@override
class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _currentPage = 0;
  List<Widget> pages = <Widget>[
    const WebScreenLayout(),
    const DisplayDoctor(),
    //Services(),
    //Checkin(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('web size Healthcare App'),
      ),
      body: const Text('Web size'),
    );
  }
}
