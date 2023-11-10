// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart'
//     as tzdata; // Import the timezone data
// import 'package:timezone/timezone.dart' as tz; // Import the timezone library

// class MyNotification extends StatefulWidget {
//   const MyNotification({super.key});

//   @override
//   State<MyNotification> createState() => _NotificationState();
// }

// class _NotificationState extends State<MyNotification> {
//   late FlutterLocalNotificationsPlugin fltNotification;
//   String _selectedParam = 'Hour';
//   String task = '';
//   int val = 0;
//   TextEditingController paramController = TextEditingController();
//   TextEditingController valController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     var androidInitialize = AndroidInitializationSettings('ic_launcher');
//     var iOSinitialize = DarwinInitializationSettings();
//     var initializationSettings =
//         InitializationSettings(android: androidInitialize);
//     fltNotification = FlutterLocalNotificationsPlugin();
//     fltNotification.initialize(initializationSettings);
//   }

//   Future _showNotification() async {
//     var androidDetails = AndroidNotificationDetails(
//       'Channel Id',
//       'This is my channel',
//       importance: Importance.max,
//     );
//     var generalNotificationDetails =
//         NotificationDetails(android: androidDetails);

//     // await fltNotification.show(
//     //     0, "Task", "You created an appointment", generalNotificationDetails,
//     //     payload: "The Reminder is on the date time");
//     var scheduledTime;
//     if (_selectedParam == "Hour") {
//       scheduledTime =
//           DateTime.now().add(Duration(hours: int.parse(valController.text)));
//     } else if (_selectedParam == "Minute") {
//       scheduledTime =
//           DateTime.now().add(Duration(minutes: int.parse(valController.text)));
//     } else if (_selectedParam == "Seconds") {
//       scheduledTime =
//           DateTime.now().add(Duration(seconds: int.parse(valController.text)));
//     }

//     var scheduleTime = DateTime.now().add(Duration(seconds: 5));
//     var scheduledNotificationDateTime =
//         tz.TZDateTime.from(scheduleTime, tz.local);
//     fltNotification.zonedSchedule(
//       0,
//       "Times Up",
//       task,
//       scheduledNotificationDateTime,
//       generalNotificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.wallClockTime,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.blue,
//       body: Center(
//         widthFactor: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextField(
//                 decoration: InputDecoration(border: OutlineInputBorder()),
//                 onChanged: (_val) {
//                   task = _val;
//                 },
//               ),
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   child: DropdownButton<String>(
//                     value: _selectedParam,
//                     items: const <DropdownMenuItem<String>>[
//                       DropdownMenuItem<String>(
//                         value: 'Hour',
//                         child: Text('Hour'),
//                       ),
//                       DropdownMenuItem<String>(
//                         value: 'Minute',
//                         child: Text('Minute'),
//                       ),
//                       DropdownMenuItem<String>(
//                         value: 'Seconds',
//                         child: Text('Seconds'),
//                       ),
//                     ],
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedParam = newValue!;
//                       });
//                     },
//                     hint: const Text(
//                       "Select Your Field",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 // TextFormField for _selectedParam
//                 // TextFormField(
//                 //   controller: paramController,
//                 //   decoration: InputDecoration(border: OutlineInputBorder()),
//                 //   onChanged: (_val) {
//                 //     setState(() {
//                 //       _selectedParam = _val;
//                 //     });
//                 //   },
//                 // ),
//                 // TextFormField for val
//                 const SizedBox(
//                   height: 2,
//                   width: 2,
//                 ),
//                 Expanded(
//                   //width: 100,
//                   child: TextField(
//                     controller: valController,
//                     decoration:
//                         const InputDecoration(border: OutlineInputBorder()),
//                     onChanged: (_val) {
//                       setState(() {
//                         val = int.parse(_val);
//                       });
//                     },
//                   ),
//                 )
//               ],
//             ),
//             ElevatedButton(
//               onPressed: _showNotification,
//               child: const Text('Set MyNotification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future NotificationSelected(String payload) async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: Text("notification is created $payload"),
//       ),
//     );
//     //return null;
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart'
    as tzdata; // Import the timezone data
import 'package:timezone/timezone.dart' as tz; // Import the timezone library
import 'package:intl/intl.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _NotificationState();
}

class _NotificationState extends State<MyNotification> {
  late FlutterLocalNotificationsPlugin fltNotification;
  String _selectedParam = 'Hour';
  String task = '';
  int val = 0;
  TextEditingController paramController = TextEditingController();
  TextEditingController valController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('ic_launcher');
    var iOSinitialize = DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    if (_selectedDateTime == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text("Please select a date and time."),
        ),
      );
      return;
    }

    var androidDetails = AndroidNotificationDetails(
      'Channel Id',
      'This is my channel',
      importance: Importance.max,
    );
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    var scheduledNotificationDateTime = tz.TZDateTime.from(
      _selectedDateTime!,
      tz.local,
    );
    fltNotification.zonedSchedule(
      0,
      "You have Appointment",
      task,
      scheduledNotificationDateTime,
      generalNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
    String a = '';
    NotificationSelected(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    setState(() {
                      _selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
              child: const Text('Select Date and Time'),
            ),
            if (_selectedDateTime != null)
              Text(
                'Selected Date and Time: ${DateFormat('yyyy-MM-dd hh:mm a').format(_selectedDateTime!)}',
              ),
            ElevatedButton(
              onPressed: _showNotification,
              child: const Text('Set Notification'),
            ),
          ],
        ),
      ),
    );
  }

  Future NotificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("notification is created $payload"),
      ),
    );
    //return null;
  }
}
