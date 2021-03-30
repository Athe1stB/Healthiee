import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForAdmin/CreateAdminAccount.dart';
import 'package:healthiee/screens/ForDoctor/createDocAccount.dart';
import 'package:healthiee/screens/ForPatient/CreatePatAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      if(userType.compareTo('Doctor')==0)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateDocAccount()));
                      else if(userType.compareTo('Patient')==0)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePatAccount()));
                      else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateAdminAccount()));
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
