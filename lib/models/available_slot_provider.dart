import 'package:flutter/material.dart';

import '../Health_professional/health_proffessional.dart';

class AvailableSlotsProvider with ChangeNotifier {
  List<DayTimeSlot> addSlots = [];

  void addAvailableSlot(DayTimeSlot slot) {
    addSlots.add(slot);
    notifyListeners();
  }
}
