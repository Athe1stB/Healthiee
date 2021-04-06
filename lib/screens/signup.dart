import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForAdmin/AdminDashboard.dart';
import 'package:healthiee/screens/ForDoctor/DocDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthiee/screens/ForPatient/PatientDashboard.dart';
import 'package:healthiee/services/Admin.dart';
import 'package:healthiee/services/Doctor.dart';
import 'package:healthiee/services/Patients.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  final String userType;
  SignUpPage(this.userType);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email, password;
  FirebaseAuth mAuth;

  @override
  void initState() {
    mAuth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = widget.userType;

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "SignUp",
              style: styleBoldWhite,
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                TextField(
                  key: Key('signUp_email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffix: Icon(
                      Icons.edit,
                      color: Colors.red,
                      size: 20,
                    ),
                    icon: Icon(
                      Icons.mail_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                    hintText: "Enter Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  key: Key('signUp_password'),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffix: Icon(
                      Icons.edit,
                      color: Colors.red,
                      size: 20,
                    ),
                    icon: Icon(
                      Icons.lock_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                    hintText: "Enter Password",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.pinkAccent),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      textStyle: MaterialStateProperty.resolveWith(
                          (states) => elementwhite),
                    ),
                    onPressed: () async {
                      await mAuth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (userType.compareTo('Doctor') == 0) {
                        Doctor doctor = new Doctor('name', 'licno', 'dept',
                            'dst', 'det', 'qual', defaultImgUrl, userType);
                        await doctor.addToCloud();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DocDashboard()));
                      } else if (userType.compareTo('Patient') == 0) {
                        Patient patient = Patient('name', 'applNo', 'gender',
                            defaultImgUrl, 'age', userType);
                        await patient.addToCloud();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PatientDashBoard()));
                      } else {
                        Admin admin =
                            Admin('name', 'accID', defaultImgUrl, userType);
                        await admin.addToCloud();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AdminDashboard()));
                      }
                    },
                    child: Text('SignUp')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
