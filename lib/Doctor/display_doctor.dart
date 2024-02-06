import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'doctor.dart';

class DisplayDoctor extends StatefulWidget {
  const DisplayDoctor({super.key});

  @override
  State<DisplayDoctor> createState() => _DisplayDoctorState();
}

class _DisplayDoctorState extends State<DisplayDoctor> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doctors = doctor.doctors;

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Doctors List'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         const Text('Wel Come to Doctor\'s List'),
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: doctors.length,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 //Displaying Image from firestore database
    //                 // leading: CircleAvatar(
    //                 //     child: Image.network('doctors[index].docPhotoUrl')),
    //                 title: Text(
    //                   doctors[index].name,
    //                   style: Theme.of(context).textTheme.headlineMedium,
    //                 ),

    //                 subtitle: Text(
    //                   doctors[index].speciality,
    //                   style: Theme.of(context).textTheme.headlineSmall,
    //                 ),
    //                 // You can navigate to user details screen on tap
    //                 onTap: () {
    //                   // Navigate to user details screen and pass the selected user
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => DoctorDetailsScreen(
    //                               doctor: doctors[index],
    //                             )),
    //                   );
    //                 },
    //               );
    //             },
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 200,
    //         )
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      height: 800,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 300,
                width: 200,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.yellow,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigate to user details screen and pass the selected user
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorDetailsScreen(
                                        doctor: doctors[index],
                                      )),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            // child: Image.asset(
                            //   'assets/images/health.jpg',
                            //   height: 140,
                            //   width: 200,
                            //   fit: BoxFit.cover,
                            // ),
                            child: Image.network(
                              doctors[index].docPhotoUrl,
                              width: 200,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.yellow,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.blue,
                                size: 28,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image(
                          //   image: NetworkImage(doctors[index].docPhotoUrl),
                          // ),
                          Text(doctors[index].name,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue.withOpacity(0.6))),
                          Text(
                            doctors[index].speciality,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue.withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '4.5',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.withOpacity(0.6)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
