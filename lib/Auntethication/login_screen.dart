import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Auntethication/signUpOne.dart';
import 'package:healthcare_app/Patient/home.dart';
import 'package:healthcare_app/Admin/home_of%20Admin.dart';
import 'package:healthcare_app/Doctor/home_of_doctor.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/widgets.dart';
//import 'package:provider/provider.dart';
export '../utils/image.dart';
import 'auntethication.dart';
import '../utils/utils.dart';
import '../Screens/screen.dart';
import '../Doctor/doctor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'other';
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginAdmin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance
          .collection('Doctor')
          .doc(userId)
          .get();
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(userId)
          .get();

      String userRole = userSnapshot.exists ? userSnapshot.get('role') : '';
      String doctorRole =
          doctorSnapshot.exists ? doctorSnapshot.get('role') : '';
      String adminRole = adminSnapshot.exists ? adminSnapshot.get('role') : '';
      bool approved =
          doctorSnapshot.exists ? doctorSnapshot.get('approved') : false;
      bool approvedAdmin =
          adminSnapshot.exists ? adminSnapshot.get('approved') : false;

      setState(() {
        _isLoading = false;
      });
//Doctor Login
      if ((userRole == 'doctor' || doctorRole == 'doctor') &&
          approved == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeOfDoctor(),
          ),
        );
      } else if ((userRole == 'doctor' || doctorRole == 'doctor') &&
          approved == false) {
        showSnackBar(
            'Your registration as Doctor is pending approval.', context);
      }
// Admin Login
      else if ((adminRole == 'admin' ||
              userRole == 'admin' ||
              doctorRole == 'admin') &&
          approvedAdmin == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeOfAdmin(),
          ),
        );
      } else if ((adminRole == 'admin' ||
              doctorRole == 'admin' ||
              userRole == 'admin') &&
          approvedAdmin == false) {
        showSnackBar(
            'Your registration as Admin is pending approval.', context);
      }

      //user Login
      else if (userRole == 'other' || doctorRole == 'other') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        showSnackBar('No this kind of User.', context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar('here is error $e.$toString()', context);
    }
  }

  void navigateTosignUpUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => SignUpOne()),
    );
  }

  void navigateToSignUpDoctor() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => SignUpOne()),
    );
  }

// Function to send a password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
    } catch (e) {
      // Handle any errors that occur during the password reset process
      print("Error sending password reset email: $e");
    }
  }

// Inside your LoginScreen widget, add a method to handle the password reset
  void resetPassword() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController emailController = TextEditingController();
        return AlertDialog(
          title: Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Call the sendPasswordResetEmail function
                  sendPasswordResetEmail(emailController.text);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Password reset email sent to ${emailController.text}'),
                    ),
                  );
                },
                child: Text('Send Email'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login page'),
      ),
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Container(
          //padding: const EdgeInsets.all(100),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: Center(
            // child: Container(
            //color: Colors.brown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(flex: 1, child: Container()),

                //textinput for email
                TextFieldInput(
                  hintText: 'please input your Email',
                  tectInputType: TextInputType.emailAddress,
                  textEditingcontroller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'please input your Password',
                  tectInputType: TextInputType.text,
                  textEditingcontroller: _passwordController,
                  isPass: true,
                ),
                //submit button
                const SizedBox(
                  height: 24,
                ),

                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: loginAdmin,
                  child: Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        color: blueColor),
                    child: _isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: resetPassword,
                  child: Text('Forgot Password?'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(flex: 2, child: Container()),

                //signing up if don't have account
                InkWell(
                  onTap: selectedRole == 'other'
                      ? navigateTosignUpUser
                      : navigateToSignUpDoctor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text('Don\'t have account?'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // ),
      //)
    );
  }
}
