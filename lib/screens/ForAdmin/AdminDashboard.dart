import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text(
          'Admin $name !',
          style: purpleNormalBold,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imgUrl),
              ),
              Text(
                name,
                style: styleBoldBlackMedium,
              ),
              Text(
                email,
                style: elementgray,
              ),
              SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      accID,
                      style: profileText,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Text(
                      'Admin',
                      style: profileText,
                    ),
                  ],
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
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddMeds()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Medicines',
                      )),
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddStaff()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Staffs',
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowPatientList()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Patients',
                      )),
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowDocList()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Doctors',
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateAdminAccount()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Update Profile',
                      )),
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddDonor()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Donors',
                      )),
                ],
              ),
              ElevatedButton(
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
