import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter/material.dart';

class ShowPatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Patients');

    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: users.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    leading: Image(
                      image: NetworkImage(document.data()['imgUrl']),
                    ),
                    title: Text(document.data()['name']),
                    subtitle: Text(document.data()['email']),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          ConfirmAlertBox(
                              context: context,
                              title: 'Delete Entry ?',
                              infoMessage: 'You cant undo this action.',
                              titleTextColor: Colors.purple,
                              buttonTextForYes: 'Back',
                              buttonTextForNo: 'Delete',
                              onPressedNo: () async {
                                await users
                                    .doc(document.data()['email'])
                                    .delete();
                                Navigator.pop(context);
                              },
                              onPressedYes: () {
                                Navigator.pop(context);
                              });
                        }),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
