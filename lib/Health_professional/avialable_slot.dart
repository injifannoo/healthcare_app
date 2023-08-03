import 'package:flutter/material.dart';

class AvailableSlot extends StatefulWidget {
  final Function(String) onSlotSelected; // Step 1: Add callback function

  const AvailableSlot({super.key, required this.onSlotSelected});

  @override
  State<AvailableSlot> createState() => _AvailableSlotState();
}

class _AvailableSlotState extends State<AvailableSlot> {
  // Step 1: Create a list of available appointment slots
  List<String> availableSlots = [
    'Monday 09:00 AM - 10:00 AM',
    'Wednesday 11:00 AM - 12:00 PM',
    'Saturday 02:00 PM - 03:00 PM',
    // Add more available slots
  ];
  // Step 2: Create a variable to store the selected appointment slot
  late String selectedSlot;
  @override
  void initState() {
    super.initState();
    selectedSlot = availableSlots[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Step 3: Create a DropdownButton widget
        DropdownButton<String>(
          style: const TextStyle(
            color: Color.fromARGB(255, 86, 244, 54),
          ),
          borderRadius: BorderRadius.circular(10.0),
          value: selectedSlot,
          hint: const Text('Select Appointment Slot'),
          onChanged: (value) {
            setState(() {
              selectedSlot = value.toString();
            });
            widget.onSlotSelected(selectedSlot);
          },
          items: availableSlots.map((slot) {
            return DropdownMenuItem(
              value: slot,
              child: Text(slot),
            );
          }).toList(),
        ),
      ],
    );
  }
}
