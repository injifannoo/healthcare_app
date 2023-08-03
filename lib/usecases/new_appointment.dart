import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare_app/usecases/usecase_import.dart';
import '../Health_professional/health_proffessional.dart';
import '../models/model.dart';
import '../models/navigation_model.dart';

class NewAppointment extends StatefulWidget {
  final List<DayTimeSlot> selectedSlots;

  const NewAppointment({
    Key? key,
    required this.selectedSlots,
  }) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  @override
  void initState() {
    super.initState();
    // You can access the selectedSlots from widget.selectedSlots
    print('Selected Slots: ${widget.selectedSlots}');
  }

  final TextEditingController textEditingController = TextEditingController();
  String result = '';
  String selectedSlot = '';
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<PagesProvider>(context);

    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: const TextStyle(
                color: Colors.yellow,
                backgroundColor: Colors.red,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              'You booked for $result slots. The doctor will send confirmation for you!',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AvailableSlot(
                onSlotSelected:
                    _onSlotSelected, // Step 3: Pass the callback function
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  result = selectedSlot.toString();
                });
                debugPrint('submited');
              },
              style: TextButton.styleFrom(
                backgroundColor: (Colors.black),
                foregroundColor: (Colors.white70),
                fixedSize: const Size(350, 50),
                //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSlotSelected(String slot) {
    setState(() {
      selectedSlot = slot;
    });
  }
}
