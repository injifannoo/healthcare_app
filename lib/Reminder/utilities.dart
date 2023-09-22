// import 'package:flutter/material.dart';

// int createUniqueId() {
//   return DateTime.now().millisecondsSinceEpoch.remainder(10000);
// }

// class NotificationWeekAndTime {
//   final int DayOfWeek;
//   final TimeOfDay timeOfDay;
//   NotificationWeekAndTime({
//     required this.DayOfWeek,
//     required this.timeOfDay,
//   });
// }

// Future<NotificationWeekAndTime?> pickSchedule(
//   BuildContext context,
// ) async {
//   List<String> weekdays = ['Mon', 'Tue', 'wed', 'Thur', 'Friday', 'Sat', 'Sun'];
//   TimeOfDay? timeDay;
//   DateTime now = DateTime.now();
//   int? selectedDay;
//   await showDialog(
//       context: context,
//       builder: (context) {
//         return  AlertDialog(
//             title: const Text(
//               'Your Schedule:',
//               textAlign: TextAlign.center,
//             ),
//             content: Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 3,
//               children: [
//                 for (int index = 0; index < weekdays.length; index++)
//                   ElevatedButton(
//                     onPressed: () {
//                       selectedDay = index + 1;
//                       Navigator.pop(context);
//                     },
//                     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(.all(Colors.teal))),
//                      child: Text(weekdays[index]),
//                   ),
//               ],
//             ),
//             );
//       });
// }
