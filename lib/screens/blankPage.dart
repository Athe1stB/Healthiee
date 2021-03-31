import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/screens/ForPatient/showDocs.dart';

class BlankPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Logged in successfully!!',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ShowDocs()));
                },
                child: Text('List Of Doctors')),
            ElevatedButton(
              style: ButtonStyle(),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
