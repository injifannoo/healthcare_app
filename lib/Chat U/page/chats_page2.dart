import 'package:healthcare_app/models/model.dart';
import 'package:provider/provider.dart';
import '../widget/chat_body_widget2.dart';
import '../widget/chat_header_widget2.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Providers/provider.dart';

class ChatsPage2 extends StatefulWidget {
  const ChatsPage2({super.key});

  @override
  State<ChatsPage2> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage2> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final doctor = Provider.of<DoctorProvider>(context);
  //   final List<DoctorInformation> doctors = doctor.doctors;
  //   // Create a stream from your list of doctors
  //   // final doctorStream =
  //   //     Stream<List<DoctorInformation>>.fromIterable([doctors]);
  //   return Scaffold(
  //     appBar: AppBar(),
  //     backgroundColor: Colors.blue,
  //     body: SafeArea(
  //       child: ListView.builder(
  //           physics: const BouncingScrollPhysics(),
  //           itemCount: doctors.length,
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 ChatHeaderWidget(users: doctors),
  //                 ChatBodyWidget(users: doctors[index])
  //               ],
  //             );
  //           }),
  //     ),
  //   );
  // child: StreamBuilder<List<DoctorInformation>>(
  //   stream: doctorStream,
  //   builder: (context, snapshot) {
  //     switch (snapshot.connectionState) {
  //       case ConnectionState.waiting:
  //         return const Center(child: CircularProgressIndicator());
  //       default:
  //         if (snapshot.hasError) {
  //           print(snapshot.error);
  //           return buildText('Something Went Wrong Try later');
  //         } else {
  //           final users = snapshot.data;

  //           if (users!.isEmpty) {
  //             return buildText('No Users Found');
  //           } else {
  //             return Column(
  //               children: [
  //                 ChatHeaderWidget(users: users),
  //                 ChatBodyWidget(users: users)
  //               ],
  //             );
  //           }
  //         }
  //     }
  //   },
  // ),
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final List<Users> users = user.getUsers;
    final doctorStream = Stream<List<Users>>.fromIterable([users]);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: StreamBuilder<List<Users>>(
          stream: doctorStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return buildText('Something Went Wrong Try later');
                } else {
                  final users = snapshot.data;

                  if (users!.isEmpty) {
                    return buildText('No Users Found');
                  } else {
                    return Column(
                      children: [
                        ChatHeaderWidget2(users: users),
                        ChatBodyWidget2(users: users)
                      ],
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
