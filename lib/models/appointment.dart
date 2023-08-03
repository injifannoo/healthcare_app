/*  Use Case ID: UC1
Use Case Name: Appointment Scheduling
Goal: To enable patients to schedule appointments through the mobile app
Actor: Patient

Flow of Events:
    1. The patient opens the mobile app.
    2. The app displays the home page.
    3. The patient selects the "Appointments" option from the menu.
    4. The app displays the available appointment slots.
    5. The patient selects a preferred appointment slot.
    6. The app prompts the patient to confirm the appointment booking.
    7. The patient confirms the booking.
    8. The app sends a confirmation notification to the patient.
    9. The app updates the appointment schedule.
    10. End of the use case.

 */
// appointment.dart

class Appointment {
  final String patientName;
  final DateTime appointmentDate;

  Appointment({required this.patientName, required this.appointmentDate});
}
