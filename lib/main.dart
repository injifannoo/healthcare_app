import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Appointment/my_appointment_page.dart';
import 'package:healthcare_app/Doctor/doctor.dart';
import 'package:healthcare_app/Providers/provider.dart';
import 'package:healthcare_app/Screens/screen.dart';
import 'package:healthcare_app/registeration_choice.dart';
import 'package:healthcare_app/responsive/responsive.dart';
import 'package:healthcare_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Post/post.dart';
import 'Screens/display_current_user.dart';
import 'Screens/display_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB4Cu_e1VtMn6InoQKctVDkQQGYVbMVz9g',
        appId: '1:994264266102:web:aedbdeb7fb1eee81aa7657',
        messagingSenderId: '994264266102',
        projectId: 'healthcare-app-6417',
        storageBucket: 'healthcare-app-6417.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AppointmentsProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthcare App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveScreenLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return MyAppointmentPage();
          },
        ),
      ),
    );
  }
}
