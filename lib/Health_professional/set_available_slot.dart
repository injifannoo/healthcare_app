import 'package:flutter/material.dart';
import 'package:healthcare_app/Health_professional/health_proffessional.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';
import '../usecases/usecase_import.dart';

class SetAvailableSlot extends StatefulWidget {
  const SetAvailableSlot({
    super.key,
  });
// Step 1: Add the callback function
  @override
  State<SetAvailableSlot> createState() => _SetAvailableSlotState();
}

class DayTimeSlot {
  final String day;
  final List<String> timeSlots;

  DayTimeSlot({required this.day, required this.timeSlots});
}

class _SetAvailableSlotState extends State<SetAvailableSlot> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController timeSlotController = TextEditingController();
  List<DayTimeSlot> dayTimeSlots = [];

  @override
  void dispose() {
    dayController.dispose();
    timeSlotController.dispose();
    super.dispose();
  }

  // Add a function to add the user input to the list
  void addDayTimeSlot() {
    final days = dayController.text;
    final timeSlot = timeSlotController.text;

    if (days.isNotEmpty && timeSlot.isNotEmpty) {
      final newSlot = DayTimeSlot(day: days, timeSlots: [timeSlot]);
      final availableSlotsProvider =
          Provider.of<AvailableSlotsProvider>(context, listen: false);
      availableSlotsProvider.addAvailableSlot(newSlot);
      dayController.clear();
      timeSlotController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableSlotsProvider = Provider.of<AvailableSlotsProvider>(context);
    final availableSlots = availableSlotsProvider.addSlots;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: availableSlots.length,
            itemBuilder: (context, index) {
              final dayTimeSlot = availableSlots[index];
              return ListTile(
                title: Text(dayTimeSlot.day),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dayTimeSlot.timeSlots
                      .map((timeSlot) => Text(timeSlot))
                      .toList(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: dayController,
                  decoration: const InputDecoration(labelText: 'Day'),
                ),
                TextField(
                  controller: timeSlotController,
                  decoration: const InputDecoration(labelText: 'Time Slot'),
                ),
                ElevatedButton(
                  onPressed: addDayTimeSlot,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
