import 'package:flutter/material.dart';
import 'package:healthcare_app/Doctor/add_doctor.dart';

import 'Screens/screen.dart';

class RegistrationChoice extends StatelessWidget {
  const RegistrationChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Choice'),
      ),
      body: Center(
        child: Column(
          children: [
            const Card(
              child: Text('WEL COME TO OUR FAYYAA'),
            ),
            Flexible(flex: 1, child: Container()),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text('Continue as Doctor')),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text('Continue as Other User')),
            Flexible(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}
