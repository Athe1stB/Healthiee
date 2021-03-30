import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowDocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Doctors');

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
                    subtitle: Text(document.data()['dept']),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: () async {
                          String curemail = FirebaseAuth
                              .instance.currentUser.email
                              .toString();

                          //update patients next appointment    
                          await FirebaseFirestore.instance
                              .collection('Patients')
                              .doc(curemail)
                              .update(
                                  {'nextAppointment': document.data()['name']});

                          //update docs list
                          String doctorEmail = document.data()['email'];
                          String name,imgUrl;
                          List ap = document.data()['appointments'];
                          await users.doc(doctorEmail).get().then((value){
                            name = value['name'];
                            imgUrl = value['imgUrl'];
                          });

                          ap.add({
                            'Application No': curemail.substring(0,10),
                            'imgUrl': imgUrl,
                            'name': name,
                          });
                          
                          users.doc(doctorEmail).update({
                            'appointments': ap,
                          });
                          Navigator.pop(context);
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
