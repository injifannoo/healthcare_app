import 'package:flutter/material.dart';
import 'package:healthcare_app/Admin/approve_doctor.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';

class ApproveDoc extends StatefulWidget {
  const ApproveDoc({super.key});

  @override
  State<ApproveDoc> createState() => _DisplayDoctorState();
}

class _DisplayDoctorState extends State<ApproveDoc> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doctors = doctor.doctors;

    return Container(
      height: 800,
      color: Colors.brown,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  height: 630,
                  width: 360,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                    mainAxisSize: MainAxisSize.max,
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
                                    builder: (context) => ApproveDoctor(
                                          doctor: doctors[index],
                                        )),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                doctors[index].docPhotoUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.all(8),
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
                            Row(
                              children: [
                                const Icon(Icons.person),
                                Text(
                                  ' ${doctors[index].name}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.email),
                                Text(
                                  ' ${doctors[index].email}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                            ClipRect(
                              child: Row(
                                children: [
                                  const Icon(Icons.health_and_safety),
                                  Text(
                                    ' Specialist of ${doctors[index].speciality}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRect(
                              child: Row(
                                children: [
                                  const Icon(Icons.call),
                                  Text(
                                    ' ${doctors[index].contact}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(Icons.person_2),
                                Text(
                                  'Approved: ${doctors[index].approved}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Check the following document'),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                doctors[index].doctorDoc,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Available Dates',
                            //       style:
                            //           Theme.of(context).textTheme.headlineSmall,
                            //     ),
                            //     Column(
                            //       children: doctors[index]
                            //           .availableDates
                            //           .map((dateTime) {
                            //         String extractedDate =
                            //             dateTime.toString().split(" ")[0];
                            //         return Text(
                            //           extractedDate,
                            //           style:
                            //               Theme.of(context).textTheme.labelMedium,
                            //         );
                            //       }).toList(),
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Available Times',
                            //       style:
                            //           Theme.of(context).textTheme.headlineSmall,
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: doctors[index]
                            //           .availableTimeRanges
                            //           .map<Widget>((timeRange) {
                            //         final startTime = timeRange
                            //             .substring(timeRange.indexOf("(") + 1,
                            //                 timeRange.indexOf(")"))
                            //             .trim();
                            //         final endTime = timeRange
                            //             .substring(timeRange.lastIndexOf("(") + 1,
                            //                 timeRange.lastIndexOf(")"))
                            //             .trim();

                            //         final formattedTimeRange =
                            //             '$startTime - $endTime';

                            //         return Text(
                            //           formattedTimeRange,
                            //           style:
                            //               Theme.of(context).textTheme.labelMedium,
                            //         );
                            //       }).toList(),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ApproveDoctor(
                      //                 doctor: doctors[index],
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Approve The Doctor'),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditDoctorProfile(doctor: doctors[index]),
                            ),
                          ).then((updatedProfile) {
                            if (updatedProfile != null) {
                              setState(() {
                                doctors[index].approved =
                                    updatedProfile['approved'];
                              });
                            }
                          });
                        },
                        child: const Text('Approve The Doctor'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
