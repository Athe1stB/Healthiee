import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForPatient/updatePatAccount.dart';
import 'package:healthiee/screens/ForPatient/uploadTestimonials.dart';
import 'package:healthiee/screens/SelectUser.dart';
import 'package:healthiee/screens/ForPatient/showDocs.dart';

class PatientDashBoard extends StatefulWidget {
  @override
  _PatientDashBoardState createState() => _PatientDashBoardState();
}

class _PatientDashBoardState extends State<PatientDashBoard> {
  String currentUserEmail;
  String name = 'name',
      age = 'age',
      gender = 'gender',
      applNo = 'applNo',
      email = 'email',
      nextAppointment = 'None',
      imgUrl = defaultImgUrl,
      userType = 'Patient';

  void initializeAllParams() async {
    currentUserEmail = FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Patients');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          print(value['name']);
          name = value['name'].toString();
          email = value['email'];
          age = value['age'];
          gender = value['gender'];
          applNo = value['applNo'];
          nextAppointment = value['nextAppointment'];
          imgUrl = value['imgUrl'];
          userType = value['userType'];
        });
      } else
        print('not found');
    });
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hey $name !',
          style: styleBoldBlackMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.lightBlue[900],
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(imgUrl),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        name,
                        style: styleBoldWhiteMedium,
                      ),
                      Text(
                        email,
                        style: profileEmail,
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.lightBlueAccent),
                      SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Patdetails(
                              parameter: 'Application ID',
                              value: applNo,
                            ),
                            VerticalDivider(
                              color: Colors.white24,
                              thickness: 2,
                            ),
                            Patdetails(parameter: 'Age', value: age),
                            VerticalDivider(
                              color: Colors.white24,
                              thickness: 2,
                            ),
                            Patdetails(parameter: 'Gender', value: gender),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.lightBlueAccent),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Next Appointment with : ',
                            style: elementgray,
                          ),
                          Text(
                            nextAppointment,
                            style: elementwhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 36, right: 36),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      key: Key('availableDoctors'),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ShowDocs()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: Icons.supervised_user_circle,
                        parameter: 'Doctors',
                        cardColor: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        key: Key('updateProfile'),
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UpdatePatAccount()));
                          initializeAllParams();
                        },
                        child: DashBoardParamsWidget(
                          icondata: CupertinoIcons.pen,
                          parameter: 'Update Profile',
                          cardColor: Colors.yellow[700],
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UploadTestimonials()));
                      },
                      child: DashBoardParamsWidget(
                        icondata: Icons.send,
                        parameter: 'Send Reports',
                        cardColor: Colors.redAccent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      key: Key('signOut'),
                      onTap: () async {
                        FirebaseAuth.instance.signOut();
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SelectUser()));
                        SystemNavigator.pop();
                      },
                      child: DashBoardParamsWidget(
                        icondata: CupertinoIcons.power,
                        parameter: 'Sign Out',
                        cardColor: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Patdetails extends StatelessWidget {
  final String parameter;
  final String value;
  Patdetails({this.parameter, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: profileTextltblue,
        ),
        SizedBox(height: 5),
        Text(
          parameter,
          style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
        ),
      ],
    );
  }
}

class DashBoardParamsWidget extends StatelessWidget {
  final IconData icondata;
  final String parameter;
  final Color cardColor;

  DashBoardParamsWidget({this.icondata, this.parameter, this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // side: BorderSide(width: 2, color: Colors.black),
      ),
      color: cardColor,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(
              icondata,
              color: Colors.white,
              size: 50,
            ),
            Text(
              parameter,
              style: styleCardParamWhite,
            )
          ],
        ),
      ),
    );
  }
}
