import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Doctor/doctor.dart';
import 'package:healthcare_app/Screens/login_screen.dart';
import 'package:healthcare_app/utils/colors.dart';
import 'package:healthcare_app/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddDoctor extends StatefulWidget {
  final String? selectedRole;

  const AddDoctor({super.key, this.selectedRole});

  @override
  State<AddDoctor> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AddDoctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  Uint8List? _image;
  Uint8List? _doctorDoc;
  final List<String> availableDates = [];
  final List<String> availableTimeRanges = [];

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _specialityController.dispose();
    _languageController.dispose();
    _contactController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      print('setstate of doctor profile image is working');
    });
  }

  void selectDocImage() async {
    Uint8List docPic = await pickImage(ImageSource.gallery);

    setState(() {
      _doctorDoc = docPic;
      print('setstate of doctor doc is working');
    });
  }

  void addDoctor(String? selectedRole) async {
    setState(() {
      _isLoading = true;
      print('state in add doctor');
    });

    String res = await Doct().signUpDoctor(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      speciality: _specialityController.text,
      contact: _contactController.text,
      language: _languageController.text,
      gender: _genderController.text,
      file: _image!,
      docIdFile: _doctorDoc!,
      availableDates: availableDates,
      availableTimeRanges: availableTimeRanges,
      role: selectedRole!,
      doctorId: '',
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (contest) => const LoginScreen()),
      );
    }
  }

  void navigateToDisplayDoctor() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (contest) => const DisplayDoctor()),
    );
  }

  void _addAvailableDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        availableDates.add(pickedDate.toString());
        print("pick date");
      });
    }
  }

  // void _addAvailableTimeRange() async {
  //   TimeOfDay now = TimeOfDay.now();
  //   TimeOfDay initialStartTime = now;
  //   TimeOfDay initialEndTime = now.replacing(hour: now.hour + 1);

  //   TimeRange? pickedTimeRange = await showTimeRangePicker(
  //     context: context,
  //     start: initialStartTime,
  //     end: initialEndTime,
  //     backgroundWidget: const SizedBox(),
  //     labelStyle: TextStyle(
  //       height: 100,
  //     ),
  //   );

  //   if (pickedTimeRange != null) {
  //     setState(() {
  //       availableTimeRanges.add(pickedTimeRange.toString());
  //       print("pick Time");
  //     });
  //   }
  //}
  void _addAvailableTimeRange() async {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay initialStartTime = now;
    TimeOfDay initialEndTime = now.replacing(hour: now.hour + 1);

    TimeRange? pickedTimeRange = await showTimeRangePicker(
      context: context,
      start: initialStartTime,
      end: initialEndTime,
      backgroundWidget: const SizedBox(),
      labelStyle: TextStyle(
        height: 100,
      ),
    );

    if (pickedTimeRange != null) {
      String formattedTimeRange =
          '${pickedTimeRange.startTime.format(context)} - ${pickedTimeRange.endTime.format(context)}';

      setState(() {
        availableTimeRanges.add(formattedTimeRange);
        print("pick Time");
      });
    }
  }

  // void _addAvailableTimeRange() async {
  //   TimeOfDay now = TimeOfDay.now();
  //   TimeOfDay initialStartTime = now;
  //   TimeOfDay initialEndTime = now.replacing(hour: now.hour + 1);

  //   TimeRange? pickedTimeRange = await showTimeRangePicker(
  //     context: context,
  //     start: initialStartTime,
  //     end: initialEndTime,
  //   );

  //   if (pickedTimeRange != null) {
  //     setState(() {
  //       String formattedTimeRange =
  //           '${pickedTimeRange.startTime.format(context)} - ${pickedTimeRange.endTime.format(context)}';
  //       availableTimeRanges.add(formattedTimeRange);
  //       print("Picked Time Range: $availableTimeRanges");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctors'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Flexible(flex: 1, child: Container()),
                //image
                Image.asset(
                  'assets/images/health.jpg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                //circular widget to accept and show our selected file
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
                    hintText: 'please input Doctor\'s Full Name',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _nameController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input Doctor\'s speciality',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _specialityController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input Doctor\'s contact',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _contactController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input language',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _languageController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    hintText: 'please input Gender',
                    tectInputType: TextInputType.text,
                    textEditingcontroller: _genderController),
                const SizedBox(
                  height: 10,
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
                TextFieldInput(
                    hintText: 'please input your Email',
                    tectInputType: TextInputType.emailAddress,
                    textEditingcontroller: _emailController),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: _addAvailableDate,
                    child: const Text('Add Available Date')),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableDates.length,
                  itemBuilder: (context, index) {
                    return Text(availableDates[index]);
                  },
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: _addAvailableTimeRange,
                      child: const Text('Add Available Time Range')),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableTimeRanges.length,
                  itemBuilder: (context, index) {
                    return Text(availableTimeRanges[index]);
                  },
                ),
                const Text(
                    'Please upload your document confirm that you are doctor(in form of image)'),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    _doctorDoc != null
                        ? CircleAvatar(
                            radius: 32,
                            backgroundImage: MemoryImage(_doctorDoc!),
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
                        onPressed: selectDocImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(flex: 1, child: Container()),

                InkWell(
                  onTap: () => addDoctor(widget.selectedRole),
                  child: Container(
                    width: double.infinity,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
