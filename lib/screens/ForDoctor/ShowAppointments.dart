import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowDocAppointments extends StatefulWidget {
  @override
  _ShowDocAppointmentsState createState() => _ShowDocAppointmentsState();
}

class _ShowDocAppointmentsState extends State<ShowDocAppointments> {
  String appointmentCount = '0';
  var patientList = <Map>[];

  void initializeAllParams() async {
    String currentUserEmail =
        FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Doctors');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          patientList = List.from(value['appointments']);
          appointmentCount = patientList.length.toString();
          print(patientList);
        });
      }
    });
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ltList = <Widget>[];

    for (int i = 0; i < patientList.length; i++) {
      ltList.add(new ListTile(
        tileColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 2, color: Colors.black),
        ),
        title: Text(patientList[i]['name']),
        subtitle: Text(patientList[i]['Application No']),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(patientList[i]['imgUrl']),
        ),
      ));
      ltList.add(SizedBox(height: 8));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments ($appointmentCount)'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                children: ltList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
