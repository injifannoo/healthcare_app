// //TODO to change current user use the required data and hot restart
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Providers/provider.dart';
// import '../models/model.dart';

// class DataInfo {
//   static String myId = '';
//   static String myUsername = '';
//   static String myUrlAvatar = '';
// }

// class Data extends StatefulWidget {
//   const Data({super.key});

//   @override
//   State<Data> createState() => _DataState();
// }

// class _DataState extends State<Data> {
//   @override
//   void initState() {
//     super.initState();
//     final userId = FirebaseAuth.instance.currentUser?.uid;
//     if (userId != null) {
//       Provider.of<DoctorProvider>(context, listen: false)
//           .fetchCurrentDoctor(userId)
//           .then((DoctorInformation? doctor) {
//             if (doctor != null) {
//               setState(() {
//                 DataInfo.myId = doctor.doctorId ?? '';
//                 DataInfo.myUsername = doctor.name ?? '';
//                 DataInfo.myUrlAvatar = doctor.docPhotoUrl ?? '';
//               });
//             }
//           } as FutureOr Function(void value));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // Your widget content here
//         );
//   }
// }

// // Christine
// // String myId = '5oRHGIPx1Z0wJa3z3Y9S';
// // String myUsername = 'Christine Wallace';
// // String myUrlAvatar = 'https://i.imgur.com/GXoYikT.png';

// // Napoleon


