import 'package:flutter/material.dart';
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

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await Auth().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (contest) => const Home(),
        ),
      );
    }
  }

  void loginDoctor() async {
    setState(() {
      _isLoading = true;
    });

    String res = await Doct().loginDoctor(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (contest) => const HomeOfDoctor(),
        ),
      );
    }
  }

  void navigateTosignUpUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => const SignUpScreen()),
    );
  }

  void navigateToSignUpDoctor() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => const AddDoctor()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login page'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                Flexible(flex: 1, child: Container()),
                //image
                Image.asset(
                  'assets/images/health.jpeg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                //textinput for email
                TextFieldInput(
                    hintText: 'please input your Email',
                    tectInputType: TextInputType.emailAddress,
                    textEditingcontroller: _emailController),
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
                Container(
                  padding: const EdgeInsets.all(1), // Adjust padding as needed
                  constraints: const BoxConstraints(
                    minWidth: 500, // Minimum width of the dropdown box
                    maxWidth: 500, // Maximum width of the dropdown box
                  ),
                  child: DropdownButton<String>(
                    hint: const Text('select doctor or other'),
                    iconSize: 40, // Adjust the size of the dropdown icon
                    icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                    value: selectedRole,
                    onChanged: (newValue) {
                      setState(
                        () {
                          // Update the state to trigger a rebuild
                          selectedRole = newValue!;
                        },
                      );
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

                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: selectedRole == 'other' ? loginUser : loginDoctor,
                  child: Container(
                    width: double.infinity,
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
        ));
  }
}
