import 'package:flutter/material.dart';
import 'package:healthcare_app/Admin/signup_admin.dart';
import 'package:healthcare_app/Doctor/add_doctor.dart';
import 'package:healthcare_app/Auntethication/login_screen.dart';
import 'package:healthcare_app/Auntethication/signup_screen.dart';

class SignUpOne extends StatefulWidget {
  @override
  _SignUpOneState createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  String? selectedRole;

  // Function to save the selected role to the database and navigate to the appropriate screen
  void goSignUpPage() {
    // Check the selected role and navigate accordingly
    if (selectedRole == 'other') {
      // Navigate to the doctor signup page and pass the selected role as an argument
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(selectedRole: selectedRole),
        ),
      );
    } else if (selectedRole == 'doctor') {
      // Navigate to the other signup page and pass the selected role as an argument
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddDoctor(selectedRole: selectedRole),
        ),
      );
    } else if (selectedRole == 'admin') {
      // Navigate to the other signup page and pass the selected role as an argument
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpAdmin(selectedRole: selectedRole),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.green, // Set the background color
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/health.jpg', // Add your health app icon image
              width: 300, // Set the desired width
              height: 300, // Set the desired height
            ),
            const SizedBox(height: 20), // Add some spacing

            const Text(
              'Welcome to\nYour Health App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white, // Set the text color
                fontWeight: FontWeight.bold, // Apply a bold font weight
              ),
            ),

            const SizedBox(height: 20),
            Text('What is your role please'),
            Center(
              child: Container(
                padding: const EdgeInsets.all(1),
                constraints: const BoxConstraints(
                  minWidth: 600,
                  maxWidth: 600,
                ),
                child: DropdownButton<String>(
                  hint: const Text('Select role'),
                  iconSize: 40,
                  icon: const Icon(Icons.arrow_drop_down),
                  value: selectedRole,
                  onChanged: (newValue) {
                    setState(() {
                      selectedRole = newValue;
                    });
                  },
                  items: <String>['doctor', 'other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goSignUpPage,
        child: Icon(Icons.check),
      ),
    );
  }
}
