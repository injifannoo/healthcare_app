// import 'dart:html';

// import 'package:healthcare_app/Reminder/utilities.dart';

// Future<void> createAppointmentReminder(  NotificationWeekAndTime notificationSchedule
// )
// async{
//   await AwesomeNotification().createNotification(
//     content:NotificationContent(
//       id:createUniqueId(),
//       channelKey:'scheduled_channel',
//       title:'${Emojis.wheater_droplet} Keep eye on your appointment',
//       Body:'Visit your Doctor',
//       bigPicture:'asset://assets/notification.png',
//       notificationLayout:NotificationLayout.BigPicture,
//     ),
//     actionButtons:[
//       NotificationActionButton(
//         key:'MARK_DONE'
//         label:'Mark Done'
//       ),
//     ],
//     schedule:NotificationCalendar(
//       weekday:notificationSchedule.DayOfWeek,
//       hour:notificationSchedule.timeOfDay.hour,
//       minute:notificationSchedule.timeOfDay.minute,
//       second:0,
//       millisecond:0,
//       repeat:true,
//     )
//   );
// } 

// Future<void> createAppointmentReminder(  NotificationWeekAndTime notificationSchedule
// )
// async{
//   await AwesomeNotification().createNotification(
//     content:Notification(
//       id:createUniqueId(),
//       channelKey:'scheduled_channel',
//       title:'${Emojis.wheater_droplet} Keep eye on your appointment',
//       Body:'Visit your Doctor',
//       notificationLayout:NotificationLayout.Default,
//     ),
//     actionButtons:[
//       NotificationActionButton(
//         key:'MARK_DONE'
//         label:'Mark Done'
//       ),
//     ],
//     schedule:NotificationCalendar(
//       weekday:notificationSchedule.DayOfWeek,
//       hour:notificationSchedule.timeOfDay.hour,
//       minute:notificationSchedule.timeOfDay.minute,
//       second:0,
//       millisecond:0,
//       repeat:true,
//     )
//   );
// } 
//  Future<void> cancelScheduledNotifications() async{

//   await AwesomeNotifications().cancelAllSchedule();

// }
