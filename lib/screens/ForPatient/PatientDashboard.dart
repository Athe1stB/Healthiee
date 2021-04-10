import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text(
          'Hey $name !',
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
                      applNo,
                      style: profileText,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Text(
                      age+'yrs',
                      style: profileText,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Text(
                      gender,
                      style: profileText,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Next Appointment : ',
                    style: elementgray,
                  ),
                  Text(
                    nextAppointment,
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
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ShowDocs()));
                    initializeAllParams();
                  },
                  child: Text(
                    'Show Available Doctors',
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
                                    UpdatePatAccount()));
                        initializeAllParams();
                      },
                      child: Text(
                        'Update Profile',
                      )),
                  VerticalDivider(),
                  ElevatedButton(onPressed: () async{
                    await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UploadTestimonials()));
                  }, child: Text('Send Reports')),
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
