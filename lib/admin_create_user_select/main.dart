// main.dart

import 'package:flutter/material.dart';
import 'admin_data_creation_screen.dart';
import 'user_data_selection_screen.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/admin_data_creation',
      routes: {
        '/admin_data_creation': (context) => const AdminDataCreationScreen(),
        '/user_data_selection': (context) => UserDataSelectionScreen(
              user_products: products,
            ),
      },
    );
  }
}
