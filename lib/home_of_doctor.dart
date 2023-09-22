import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/my_appointment_page.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/Post/feeds.dart';
import 'package:healthcare_app/Screens/profile.dart';
import 'package:healthcare_app/Screens/search.dart';


class HomeOfDoctor extends StatefulWidget {
  const HomeOfDoctor({
    super.key,
  });
  @override
  State<HomeOfDoctor> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeOfDoctor> {
  int _currentPage = 0;
  static List<Widget> pages = <Widget>[
    const HomeOfDoctor(),
    const Feed(),
    const MyAppointmentPage(),
    const ChatsPage(),
    const SearchScreen(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
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
            icon: Icon(Icons.health_and_safety),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'My Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
