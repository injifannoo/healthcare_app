//import 'dart:html';
class DoctorField {
  static const String lastMessageTime = 'lastMessageTime';
}

class DoctorInformation {
  final String email;
  final String password;
  final String name;
  final String speciality;
  // final String experience;
  final String docPhotoUrl;
  final String doctorId;
  // final String location;
  final String language;
  // final bool telemedicineAvailable;
  // final List<String> servicesOffered;
  // final String education;
  final String contact;
  // final bool available;
  // final String pricing;
  final String gender;
  final String doctorDoc;

  final String role;
  List<dynamic> availableDates;
  List<dynamic> availableTimeRanges;
  String? lastMessageTime;
  late final bool approved;

  DoctorInformation({
    required this.email,
    required this.password,
    required this.name,
    required this.speciality,
    required this.language,
    required this.contact,
    required this.gender,
    // required this.education,
    // required this.experience,
    required this.docPhotoUrl,
    required this.doctorId,
    required this.doctorDoc,
    required this.availableDates,
    required this.availableTimeRanges,
    this.lastMessageTime,
    required this.role,
    required this.approved,
    // required this.location,
    // required this.telemedicineAvailable,
    // required this.servicesOffered,

    // required this.available,
    // required this.pricing,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'speciality': speciality,
        // 'exerience': experience,
        'docPhotoUrl': docPhotoUrl,
        'doctorDoc': doctorDoc,
        // 'location': location,
        'language': language,
        // 'telemed': telemedicineAvailable,
        // 'service': servicesOffered,
        // 'education': education,
        'contact': contact,
        // 'available': available,
        // 'price': pricing,
        'gender': gender,
        'doctorId': doctorId,
        'availableDates': availableDates,
        'availableTimeRanges':
            availableTimeRanges.map((range) => range).toList(),
        'lastMessageTime': lastMessageTime,
        'role': role,
        'approved': approved,
      };
  static DoctorInformation fromSnap(snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    Map<String, dynamic> userData = snapshot;
    String name = userData['name'] ?? '';
    String email = userData['email'] ?? '';
    String password = userData['password'] ?? '';
    List<String> availableDates =
        (userData['availableDates'] ?? []).cast<String>();
    List<String> availableTimeRanges =
        (userData['availableTimeRanges'] ?? []).cast<String>();
    String contact = userData['contact'] ?? '';
    String docPhotoUrl = userData['docPhotoUrl'] ?? '';
    String doctorDoc = userData['doctorDoc'] ?? '';
    String doctorId = userData['doctorId'] ?? '';
    String gender = userData['gender'] ?? '';
    String language = userData['language'] ?? '';
    String speciality = userData['speciality'] ?? '';
    String lastMessageTime = userData['lastMessageTime'];
    String role = userData['role'];
    bool approved = userData['approved'];

    return DoctorInformation(
      name: name,
      email: email,
      password: password,
      availableDates: availableDates,
      availableTimeRanges: availableTimeRanges,
      contact: contact,
      docPhotoUrl: docPhotoUrl,
      doctorDoc: doctorDoc,
      doctorId: doctorId,
      gender: gender,
      language: language,
      speciality: speciality,
      lastMessageTime: lastMessageTime,
      role: role,
      approved: approved,
    );
    // return DoctorInformation(
    //   email: snapshot['email'],
    //   password: snapshot['password'],
    //   name: snapshot['name'],
    //   speciality: snapshot['speciality'],
    //   // experience: snapshot['experience'],
    //   // location: snapshot['location'],
    //   language: snapshot['language'],
    //   // telemedicineAvailable: snapshot['telemedicineAvailable'],
    //   // servicesOffered: snapshot['servicesOffered'],
    //   // education: snapshot['education'],
    //   contact: snapshot['contactInformation'],
    //   // available: snapshot['available'],
    //   // pricing: snapshot['pricing'],
    //   gender: snapshot['gender'],
    //   docPhotoUrl: snapshot['docPhotoUrl'],
    //   doctorDoc: snapshot['doctorDoc'],
    //   doctorId: snapshot['doctorId'],
    //   availableDates: snapshot['availableDates'],
    //   availableTimeRanges: snapshot['availableTimesRanges'],
    // );
  }
}
