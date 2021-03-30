import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';

class ShowDocProfile extends StatefulWidget {
  @override
  _ShowDocProfileState createState() => _ShowDocProfileState();
}

class _ShowDocProfileState extends State<ShowDocProfile> {
  String currentUserEmail;
  String name = 'name',
      licno = 'licno',
      dst = 'dst',
      det = 'det',
      dept = 'dept',
      email = 'email',
      imgUrl =
          'https://firebasestorage.googleapis.com/v0/b/healthiee.appspot.com/o/profileImg%2Fimage_picker7515264438939594916.jpg%7D?alt=media&token=a278804a-949e-44d0-8264-7657c1f4a27e',
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
                    style: profileText,
                  ),
                  Text(
                    ' - ',
                    style: profileText,
                  ),
                  Text(
                    det,
                    style: profileText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
