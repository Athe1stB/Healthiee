import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendPrescription extends StatefulWidget {
  @override
  _SendPrescriptionState createState() => _SendPrescriptionState();
}

class _SendPrescriptionState extends State<SendPrescription> {
  String appointmentCount = '0';
  var patientList = <Map>[];

  void sendEmail(String patEmail, String patName) async {
    String docEmail = FirebaseAuth.instance.currentUser.email.toString();
    String docName;
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(docEmail)
        .get()
        .then((value) {
          setState(() {
      docName = value['name'];
                    });
    });

    final Email email = Email(
      body:
          'Date: ${DateTime.now()}\n Dear $patName,\n Medicines:\n\n Remarks:\n\n',
      subject: 'Prescription_ Dr.$docName',
      recipients: [patEmail],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  void initializeAllParams() async {
    String currentUserEmail =
        FirebaseAuth.instance.currentUser.email.toString();
    print(currentUserEmail);
    CollectionReference ref = FirebaseFirestore.instance.collection('Doctors');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          patientList = List.from(value['appointments']);
          appointmentCount = patientList.length.toString();
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
        trailing: IconButton(
          icon: Icon(CupertinoIcons.pen, color: Colors.indigo),
          onPressed: () {
            sendEmail(patientList[i]['email'], patientList[i]['name']);
          },
        ),
      ));
      ltList.add(SizedBox(height: 8));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Patients ($appointmentCount)'),
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
