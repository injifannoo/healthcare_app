import 'package:flutter/material.dart';
import 'package:healthcare_app/Health_professional/set_available_slot.dart';
import 'package:provider/provider.dart';
import '../admin_create_user_select/admin_data_creation_screen.dart';
import '../admin_create_user_select/product.dart';
import '../admin_create_user_select/user_data_selection_screen.dart';
import '../usecases/usecase_import.dart';
import '../models/model.dart';
import 'pages.dart'; // Import the ChatPage

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final a = AppBar(
  backgroundColor: Colors.brown,
  title: const Text('Homepage'),
  leading: GestureDetector(
    child: const Icon(Icons.menu),
    onTap: () {},
  ),
  actions: [
    GestureDetector(
      child: const Icon(Icons.settings),
      onTap: () {
        // handle the press
      },
    ),
  ],
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    final appointmentProvider = Provider.of<PagesProvider>(context);
    String selectedSlot = '';
    return Scaffold(
      appBar: a,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate appointment scheduling
                Appointment appointment = Appointment(
                  patientName: 'John Doe',
                  appointmentDate: DateTime.now().add(const Duration(days: 1)),
                );

                appointmentProvider.setAppointment(appointment);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentPage()),
                );
              },
              child: const Text('Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalHistoryPage()),
                );
              },
              child: const Text('Medical History'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
              child: const Text('Chat'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetAvailableSlot()),
                );
              },
              child: const Text('Set SLot'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminDataCreationScreen()),
                );
              },
              child: const Text('Admin Creation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDataSelectionScreen(
                            user_products: products,
                          )),
                );
              },
              child: const Text('User Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
