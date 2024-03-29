import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:healthcare_app/Auntethication/auth.dart';
import 'package:healthcare_app/Auntethication/login_screen.dart';
import 'package:healthcare_app/utils/colors.dart';
import 'package:healthcare_app/utils/image.dart';
import 'package:healthcare_app/widgets.dart';
import 'package:image_picker/image_picker.dart';

class SignUpAdmin extends StatefulWidget {
  final String? selectedRole;

  const SignUpAdmin({
    super.key,
    this.selectedRole,
  });

  @override
  State<SignUpAdmin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      print('setstate is working');
    });
  }

  void signUpAdmin(String? selectedRole) async {
    setState(() {
      _isLoading = true;
    });
    String res = await Auth().signUpAdmin(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      role: selectedRole!,
      fileAdmin: _image!,
      address: _addressController.text,
      dateOfBirth: _dateOfBirthController.text,
      gender: _genderController.text,
      phone: _phoneController.text,
      approved: false,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (contest) {
          return const LoginScreen();
        }),
      );
    }
  }

  void navigateToLoginUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SignUp page'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(flex: 1, child: Container()),
                //circular widget to accept and show our selected fileAdmin
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 32,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1682685797229-b2930538da47?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                          ),
                    Positioned(
                      bottom: -6,
                      left: 28,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),

                //textinput for email
                TextFieldInput(
                    hintText: 'please input your Full Name',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _nameController),
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 20,
                ),

                //here dropdown for role

                TextFieldInput(
                    hintText: 'please input your address',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _addressController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input your Gender',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _genderController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input your Date Of Birth',
                    tectInputType: TextInputType.datetime,
                    textEditingcontroller: _dateOfBirthController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input your phone Number',
                    tectInputType: TextInputType.phone,
                    textEditingcontroller: _phoneController),
                const SizedBox(
                  height: 10,
                ),
                //submit button
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () => signUpAdmin(widget.selectedRole),
                  child: Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        color: blueColor),
                    child: _isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text("SignUp"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(flex: 2, child: Container()),

                //signing up if don't have account
                InkWell(
                  onTap: navigateToLoginUser,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text('Do you have account?'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Login',
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
