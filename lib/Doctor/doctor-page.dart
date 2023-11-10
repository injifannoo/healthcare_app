import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';
import '../models/model.dart';
import 'doctor.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  List catNames = [
    'Dental',
    'Heart',
    'Eye',
    'Brain',
    'Ear',
  ];
  List<Icon> catIcons = [
    Icon(
      MdiIcons.toothOutline,
      color: Colors.blue,
      size: 30,
    ),
    Icon(
      MdiIcons.heartPlus,
      color: Colors.blue,
      size: 30,
    ),
    Icon(
      MdiIcons.eye,
      color: Colors.blue,
      size: 30,
    ),
    Icon(
      MdiIcons.brain,
      color: Colors.blue,
      size: 30,
    ),
    Icon(
      MdiIcons.earHearing,
      color: Colors.blue,
      size: 30,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<DoctorProvider>(context);
    final List<DoctorInformation> doctors = doctor.doctors;

    return Material(
      color: Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.5),
                    Colors.blue,
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                'assets/images/inj.jpg',
                              ),
                            ),
                            Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hello Welcome",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your health is our first priority',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search here ...",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 25,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: catNames.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F8FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.deepOrange,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: catIcons[index],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              catNames[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.withOpacity(0.7),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Recommended Doctors',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.withOpacity(0.7),
                      ),
                    ),
                  ),
                  //DoctorsSection
                  const DisplayDoctor(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
