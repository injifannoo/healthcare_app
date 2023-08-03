import 'package:flutter/foundation.dart';
import 'appointment.dart';

class PagesProvider extends ChangeNotifier {
  Appointment? _appointment;

  Appointment? get appointment => _appointment;

  void setAppointment(Appointment appointment) {
    _appointment = appointment;
    notifyListeners();
  }
}
