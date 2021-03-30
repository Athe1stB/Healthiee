import 'package:flutter/material.dart';
import 'package:healthiee/screens/Homepage.dart';

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Admin'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage('Admin')));
              },
            ),
            ElevatedButton(
              child: Text('Doctor'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage('Doctor')));
              },
            ),
            ElevatedButton(
              child: Text('Patient'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage('Patient')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
