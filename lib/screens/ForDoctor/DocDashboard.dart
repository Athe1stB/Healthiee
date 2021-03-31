import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthiee/constants.dart';
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
        title: Text(
          'Hey Doctor !',
          style: styleBoldBlackMedium,
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
                'Dr. ' + name,
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
                      licno,
                      style: profileText,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Text(
                      qual,
                      style: profileText,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Text(
                      dept,
                      style: profileText,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dst,
                    style: profileTextBlue,
                  ),
                  Text(
                    ' - ',
                    style: profileTextBlue,
                  ),
                  Text(
                    det,
                    style: profileTextBlue,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 36, right: 36),
                child: Divider(
                  thickness: 2,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowDocAppointments()));
                  },
                  child: Text(
                    'Show Upcoming Appointments',
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateDocAccount()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Update Profile',
                      )),
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SelectUser()));
                        SystemNavigator.pop();
                      },
                      child: Text(
                        'Sign Out',
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
