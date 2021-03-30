import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';

class ShowDocAppointments extends StatefulWidget {
  @override
  _ShowDocAppointmentsState createState() => _ShowDocAppointmentsState();
}

class _ShowDocAppointmentsState extends State<ShowDocAppointments> {
  var patientList = <Map>[];

  void initializeAllParams() async {
    String currentUserEmail =
        FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Doctors');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          patientList = List.from(value['appointments']);
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
    var ltList = <ListTile>[];

    for (int i = 0; i < patientList.length; i++) {
      ltList.add(new ListTile(
        title: Text(patientList[i]['name']),
        subtitle: Text(patientList[i]['Application No']),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(patientList[i]['imgUrl']),
        ),
      ));
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Upcoming Appointments: ',
                style: purpleNormalBold,
              ),
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
