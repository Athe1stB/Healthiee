import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthiee/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthiee/screens/ForAdmin/AdminDashboard.dart';
import 'package:healthiee/screens/ForDoctor/DocDashboard.dart';
import 'package:healthiee/screens/ForPatient/PatientDashboard.dart';
import 'package:healthiee/screens/SelectUser.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        theme: defaultAppTheme,
        home: SafeArea(
          child: Scaffold(
            body: Center(child: Loading()),
          ),
        ),
      ),
    );
  });
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void initialisefire() async {
    await Firebase.initializeApp();

    FirebaseAuth mAuth = FirebaseAuth.instance;
    if (mAuth.currentUser != null) {
      String emailCurrent = FirebaseAuth.instance.currentUser.email.toString();
      String userType;
      
      //FirebaseAuth.instance.signOut();

      CollectionReference docref =
          FirebaseFirestore.instance.collection('Doctors');
      CollectionReference patref =
          FirebaseFirestore.instance.collection('Patients');
      CollectionReference adminref =
          FirebaseFirestore.instance.collection('Admins');

      await docref.doc(emailCurrent).get().then((value) {
        if (value.exists) userType = 'Doctor';
      });
      await patref.doc(emailCurrent).get().then((value) {
        if (value.exists) userType = 'Patient';
      });
      await adminref.doc(emailCurrent).get().then((value) {
        if (value.exists) userType = 'Admin';
      });

      if (userType.compareTo('Doctor') == 0)
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DocDashboard()));
      else if (userType.compareTo('Patient') == 0)
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PatientDashBoard()));
      else
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AdminDashboard()));

      SystemNavigator.pop();
    } else {
      await Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SelectUser()));
      SystemNavigator.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    initialisefire();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitRotatingCircle(
      color: Colors.red,
      size: 80,
    );
  }
}
