import 'package:flutter/material.dart';
import 'package:healthcare_app/pages/homepage.dart';
import 'package:healthcare_app/pages/services.dart';
import 'package:provider/provider.dart';
import 'usecases/usecase_import.dart';
import 'models/model.dart';
import 'pages/pages.dart'; // Import the ChatPage

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _currentPage = 0;
  static List<Widget> pages = <Widget>[
    const MyHomePage(),
    Services(),
    Checkin(),
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
        title: const Text('Healthcare App'),
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_send_rounded),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Check-in',
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
