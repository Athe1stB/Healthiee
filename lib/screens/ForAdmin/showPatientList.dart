import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter/material.dart';

class ShowPatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Patients');

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
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

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: Image(
                    height: 50,
                    width: 50,
                    image: NetworkImage(
                        snapshot.data.docs[index].data()['imgUrl']),
                  ),
                  title: Text(snapshot.data.docs[index].data()['name']),
                  subtitle: Text(snapshot.data.docs[index].data()['email']),
                  trailing: IconButton(
                      key: Key(index.toString()),
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
                                  .doc(
                                      snapshot.data.docs[index].data()['email'])
                                  .delete();
                              Navigator.pop(context);
                            },
                            onPressedYes: () {
                              Navigator.pop(context);
                            });
                      }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
