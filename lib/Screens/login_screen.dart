import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Screens/signUpOne.dart';
import 'package:healthcare_app/home.dart';
import 'package:healthcare_app/home_of_doctor.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/widgets.dart';
//import 'package:provider/provider.dart';
export '../utils/image.dart';
import '../Auntethication/auntethication.dart';
import '../utils/utils.dart';
import 'screen.dart';
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

  // void loginUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   String res = await Auth().loginUser(
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //   );

  //   setState(() {
  //     _isLoading = false;
  //   });

  //   if (res != 'success') {
  //     // ignore: use_build_context_synchronously
  //     showSnackBar(res, context);
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (contest) => const Home(),
  //       ),
  //     );
  //   }
  // }

  // void loginDoctor() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   String res = await Doct().loginDoctor(
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //   );
  //   setState(() {
  //     _isLoading = false;
  //   });

  //   if (res != 'success') {
  //     // ignore: use_build_context_synchronously
  //     showSnackBar(res, context);
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (contest) => const HomeOfDoctor(),
  //       ),
  //     );
  //   }
  // }
  // void loginUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );

  //     String userId = userCredential.user!.uid;

  //     DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();
  //     String userRole = userSnapshot.get('role');

  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (userRole == 'doctor') {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const HomeOfDoctor(),
  //         ),
  //       );
  //     } else {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const Home(),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showSnackBar(e.toString(), context);
  //   }
  // }

  // void loginDoctor() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );

  //     String userId = userCredential.user!.uid;

  //     DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance
  //         .collection('Doctor')
  //         .doc(userId)
  //         .get();
  //     String userRole = doctorSnapshot.get('role');

  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (userRole == 'doctor') {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const HomeOfDoctor(),
  //         ),
  //       );
  //     } else {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const Home(),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showSnackBar(e.toString(), context);
  //   }
  // }
  void loginUser() async {
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

      String userRole = userSnapshot.exists ? userSnapshot.get('role') : '';
      String doctorRole =
          doctorSnapshot.exists ? doctorSnapshot.get('role') : '';

      setState(() {
        _isLoading = false;
      });

      if (userRole == 'doctor' || doctorRole == 'doctor') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeOfDoctor(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(e.toString(), context);
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
                  onTap: loginUser,
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
