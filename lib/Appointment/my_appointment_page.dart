import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/provider.dart';
import '../models/model.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({super.key});

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppointmentsProvider>(context, listen: false)
        .fetchAppointment();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
    // AwesomeNotifications().isNotificationAllowed().then(isAllowed){
    // if(!isAllowed){
    // showDialog(context:context,builder:(context)=>AlertDialog(
    // title:Text('Allow Notification'),
    // content:Text('The app would like to send you reminder'),
// actions:[
// TextButton(
// onpressed:(){},
// child: Text(' Don\'t Allow',
// style: TextStyle(
// color:Colors.grey,
// fontsize:18,
// ),
// ),
// ),
// TextButton(oSendNotifications().then((_)=>Navigator.pop(context)),
// child: Text('Allow')
// style: TextStyle(
// color:Colors.teal,
// fontsize:fontWeight.bold,
// ),
// ),
// ],
    // ))}
    // }.;

    //AwesomeNotifications().createStream.listen((event){
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification is created on ${Notification.channelKey}'),))
    //});
    //AwesomeNotifications().actionStream.listen((event){
    //Navigator.pushAndRemoveUntil(
    //context,
    //MaterialPageRoute(
    //builder:(_)=>PlantStatsPage(),),
    //(route)=>route.isFirst);
    //});
  }

  @override
  void dispose() {
    // AwesomeNotification().actionSink.close();
    //     AwesomeNotification().createSink.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<AppointmentsProvider>(context);
    final List<Appointment> app = appointments.appointments;

    final doctors = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doc = doctors.doctors;

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
        ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: app.length,
              itemBuilder: (context, index) {
                // Find the corresponding doctor based on doctorId from the appointment
                DoctorInformation doctor = doc.firstWhere(
                  (doctor) => doctor.doctorId == app[index].doctorId,
                );

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        doctor.docPhotoUrl), // Assuming doctor has imageURL
                  ),
                  title: Text(doctor.name),
                  subtitle: Text(
                      'Date: ${app[index].date}, Time: ${app[index].timeRange}'),
                );
              },
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     NotificationWeekAndTime? pickedSchedule =
            //         await pickSchedule(context);
            //     if (pickedSchedule != null) {
            //       createAppointmentReminder(pickedSchedule);
            //     }
            //   },
            //   child: const Text('Set Reminder'),
            // ),
            // ElevatedButton(
            //   onPressed: cancelScheduledNotifications,
            //   child: const Text('Cancel Reminder'),
            // ),
          ],
        ));
  }
}
