import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/app.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/Doctor/doctor-page.dart';
import 'package:healthcare_app/Post/feeds.dart';
import 'package:healthcare_app/Screens/navBar.dart';
import 'package:healthcare_app/Screens/screen.dart';
import 'package:healthcare_app/Screens/userProfile.dart';
import 'package:healthcare_app/inj.dart';

import 'Auntethication/auth.dart';
import 'Doctor/doctor.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _currentPage = 0;
  static List<Widget> pages = <Widget>[
    const WelcomePage(),
    const DoctorPage(),
    const Feed(),
    const ChatsPage(),
    const MyAppointmentPage(),
    const DisplayUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _currentPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: String.fromEnvironment("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_outlined),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'My Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
            //backgroundColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
