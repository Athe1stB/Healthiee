import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthiee/screens/ForAdmin/AddDonor.dart';
import 'package:healthiee/screens/ForAdmin/AddMeds.dart';
import 'package:healthiee/screens/ForAdmin/AddStaff.dart';
import 'package:healthiee/screens/ForAdmin/showDocList.dart';
import 'package:healthiee/screens/ForAdmin/showPatientList.dart';
import 'package:healthiee/screens/ForAdmin/updateAdminAccount.dart';
import 'package:healthiee/screens/SelectUser.dart';

import '../../constants.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String currentUserEmail;
  String name = 'name',
      accID = 'accID',
      email = 'email',
      imgUrl = defaultImgUrl,
      userType = 'Admin';

  void initializeAllParams() async {
    currentUserEmail = FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Admins');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          print(value['name']);
          name = value['name'].toString();
          email = value['email'];
          accID = value['accID'];
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
          'Admin $name !',
          style: purpleNormalBold,
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
                            Admindetails(
                              parameter: 'Admin ID',
                              value: accID,
                            ),
                            VerticalDivider(
                              color: Colors.white24,
                              thickness: 2,
                            ),
                            Admindetails(parameter: 'Mode', value: 'Admin'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 36, right: 36),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      key: Key('addMeds'),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddMeds()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: Icons.medical_services,
                        parameter: 'Medicines',
                        cardColor: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      key: Key('addStaff'),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddStaff()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: Icons.person,
                        parameter: 'Staffs',
                        cardColor: Colors.yellow[700],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    key: Key('patientList'),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowPatientList()));
                      initializeAllParams();
                    },
                    child: DashBoardParamsWidget(
                      icondata: CupertinoIcons.person,
                      parameter: 'Patients',
                      cardColor: Colors.amber[800],
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      key: Key('doctorList'),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowDocList()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: Icons.supervised_user_circle_rounded,
                        parameter: 'Doctors',
                        cardColor: Colors.cyan,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    key: Key('updateProfile'),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UpdateAdminAccount()));
                      initializeAllParams();
                    },
                    child: DashBoardParamsWidget(
                      icondata: CupertinoIcons.pen,
                      parameter: 'Update Profile',
                      cardColor: Colors.lime[900],
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      key: Key('addDonor'),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddDonor()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: CupertinoIcons.person_circle_fill,
                        parameter: 'Donors',
                        cardColor: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  key: Key('signOut'),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SelectUser()));
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Sign Out',
                  )),
            ],
          ),
        ),
      ),
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

class Admindetails extends StatelessWidget {
  final String parameter;
  final String value;
  Admindetails({this.parameter, this.value});

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
