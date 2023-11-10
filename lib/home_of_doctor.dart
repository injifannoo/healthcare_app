import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/my_appointment_page.dart';
import 'package:healthcare_app/Chat%20U/page/chats_page2.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
import 'package:healthcare_app/ChatUser/page/chats_page_user.dart';
import 'package:healthcare_app/Post/feeds.dart';
import 'package:healthcare_app/Screens/doctorProfile.dart';
import 'package:healthcare_app/Screens/login_screen.dart';
import 'package:healthcare_app/Screens/navBarDoc.dart';
import 'package:healthcare_app/Screens/profile.dart';
import 'package:healthcare_app/Screens/search.dart';
import 'package:healthcare_app/inj.dart';
import 'package:healthcare_app/models/post.dart';

import 'Post/post.dart';

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
    //const HomeOfDoctor(),
    const WelcomePage(),
    const AddPost(),
    const MyAppointmentPage(),
    const ChatsPage2(),
    const SearchScreen(),
    // ProfileScreen(
    //   uid: FirebaseAuth.instance.currentUser!.uid,
    // ),
    const DoctorProfile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBarDoc(),
      appBar: AppBar(
        title: const Text('Healthcare App'),
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
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.orange,
        currentIndex: _currentPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'My Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
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
