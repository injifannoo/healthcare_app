import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Admin/ApproveDoc.dart';
import 'package:healthcare_app/Admin/admin_profile.dart';
import 'package:healthcare_app/Admin/approve_doctor.dart';
import 'package:healthcare_app/Appointment/my_appointment_page.dart';
import 'package:healthcare_app/Chat%20U/page/chats_page2.dart';
import 'package:healthcare_app/Chat/page/chats_page.dart';
//import 'package:healthcare_app/ChatUser/page/chats_page_user.dart';
import 'package:healthcare_app/Doctor/doctor-page.dart';
import 'package:healthcare_app/Post/feeds.dart';
import 'package:healthcare_app/Patient/display_user.dart';
import 'package:healthcare_app/Doctor/doctorProfile.dart';
import 'package:healthcare_app/Auntethication/login_screen.dart';
import 'package:healthcare_app/NavigationBar/navBar.dart';
import 'package:healthcare_app/NavigationBar/navBarAdmin.dart';
import 'package:healthcare_app/NavigationBar/navBarDoc.dart';
import 'package:healthcare_app/Post/profile.dart';
import 'package:healthcare_app/Post/search.dart';
import 'package:healthcare_app/Doctor/welcomePage.dart';
import 'package:healthcare_app/Doctor/doctor_info.dart';
import 'package:healthcare_app/Post/post.dart';

import '../Post/postExport.dart';

class HomeOfAdmin extends StatefulWidget {
  const HomeOfAdmin({
    super.key,
  });
  @override
  State<HomeOfAdmin> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeOfAdmin> {
  late final DoctorInformation doctor;
  int _currentPage = 0;
  static List<Widget> pages = <Widget>[
    const WelcomePage(),
    //const DoctorPage(),
    //Feed(),
    // const ChatsPage(),
    const ApproveDoc(),
    const AdminProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBarAdmin(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.health_and_safety),
          //   label: 'Doctors',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.post_add_outlined),
          //   label: 'Posts',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message_outlined),
          //   label: 'Chat',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.approval_rounded),
            label: 'Approve Doctor',
            //backgroundColor: Colors.amber,
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
