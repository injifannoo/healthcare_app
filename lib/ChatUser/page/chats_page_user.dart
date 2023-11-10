import 'package:healthcare_app/models/model.dart';
import 'package:provider/provider.dart';
import '../widget/chat_body_widget_user.dart';
import '../widget/chat_header_widget_user.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Providers/provider.dart';

class UserChatsPage extends StatefulWidget {
  const UserChatsPage({super.key});

  @override
  State<UserChatsPage> createState() => _UserChatsPageState();
}

class _UserChatsPageState extends State<UserChatsPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<UserProvider>(context, listen: false).fetchDoctors();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final user = Provider.of<UserProvider>(context);
  //   final List<Users> users = user.users;
  //   // Create a stream from your list of users
  //   // final userStream =
  //   //     Stream<List<Users>>.fromIterable([users]);
  //   return Scaffold(
  //     appBar: AppBar(),
  //     backgroundColor: Colors.blue,
  //     body: SafeArea(
  //       child: ListView.builder(
  //           physics: const BouncingScrollPhysics(),
  //           itemCount: users.length,
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 ChatHeaderWidget(users: users),
  //                 ChatBodyWidget(users: users[index])
  //               ],
  //             );
  //           }),
  //     ),
  //   );
  // child: StreamBuilder<List<Users>>(
  //   stream: userStream,
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
    final userStream = Stream<List<Users>>.fromIterable([users]);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: StreamBuilder<List<Users>>(
          stream: userStream,
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
                        ChatHeaderWidget(users: users),
                        ChatBodyWidget(users: users)
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
