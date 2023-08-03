import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_create_user_select/admin_data_creation_screen.dart';
import 'admin_create_user_select/product.dart';
import 'admin_create_user_select/user_data_selection_screen.dart';
import 'pages/pages.dart';
import '../models/model.dart';
import 'home.dart';
import 'usecases/usecase_import.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PagesProvider()),
        ChangeNotifierProvider(create: (_) => AvailableSlotsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
