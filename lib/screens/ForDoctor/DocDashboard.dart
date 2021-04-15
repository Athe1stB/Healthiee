import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForDoctor/SeeReports.dart';
import 'package:healthiee/screens/ForDoctor/SendPrescription.dart';
import 'package:healthiee/screens/ForDoctor/ShowAppointments.dart';
import 'package:healthiee/screens/ForDoctor/updateDocAccount.dart';
import 'package:healthiee/screens/SelectUser.dart';

class DocDashboard extends StatefulWidget {
  @override
  _DocDashboardState createState() => _DocDashboardState();
}

class _DocDashboardState extends State<DocDashboard> {
  String currentUserEmail;
  String name = 'name',
      licno = 'licno',
      dst = 'dst',
      det = 'det',
      dept = 'dept',
      email = 'email',
      imgUrl = defaultImgUrl,
      qual = 'qual',
      userType = 'Doctor';

  void initializeAllParams() async {
    currentUserEmail = FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Doctors');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          print(value['name']);
          name = value['name'].toString();
          email = value['email'];
          licno = value['licno'];
          dst = value['dst'];
          det = value['det'];
          dept = value['dept'];
          imgUrl = value['imgUrl'];
          qual = value['qual'];
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
          'Hey Doctor !',
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
                        'Dr. ' + name,
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
                            Docdetails(
                              parameter: 'License',
                              value: licno,
                            ),
                            VerticalDivider(
                              color: Colors.white24,
                              thickness: 2,
                            ),
                            Docdetails(parameter: 'Qualification', value: qual),
                            VerticalDivider(
                              color: Colors.white24,
                              thickness: 2,
                            ),
                            Docdetails(parameter: 'Department', value: dept),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.lightBlueAccent),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.clock_fill,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 6),
                          Text(
                            dst,
                            style: profileTextTime,
                          ),
                          Text(
                            ' - ',
                            style: profileTextTime,
                          ),
                          Text(
                            det,
                            style: profileTextTime,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      key: Key('appointments'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowDocAppointments()));
                      },
                      child: DashBoardParamsWidget(
                        icondata: CupertinoIcons.calendar_today,
                        parameter: 'Appointments',
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
                                    UpdateDocAccount()));
                        initializeAllParams();
                      },
                      child: DashBoardParamsWidget(
                        icondata: CupertinoIcons.pen,
                        parameter: 'Update Profile',
                        cardColor: Colors.yellow[700],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SeeReports()));
                      },
                      child: DashBoardParamsWidget(
                        icondata: CupertinoIcons.doc_text,
                        parameter: 'Reports',
                        cardColor: Colors.redAccent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SendPrescription()));
                      },
                      child: DashBoardParamsWidget(
                          icondata: CupertinoIcons.square_pencil,
                          parameter: 'Prescribe',
                          cardColor: Colors.blueGrey),
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
                                builder: (BuildContext context) =>
                                    SelectUser()));
                        SystemNavigator.pop();
                      },
                      child: Text('Sign Out'),
              
              ),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   style: dashBoardParams,
              //
              // ),
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

class Docdetails extends StatelessWidget {
  final String parameter;
  final String value;
  Docdetails({this.parameter, this.value});

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
