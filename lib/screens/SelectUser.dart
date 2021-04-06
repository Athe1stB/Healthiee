import 'package:flutter/material.dart';
import 'package:healthiee/screens/Homepage.dart';

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                key: Key('admin'),
                child: Text('Admin'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage('Admin')));
                },
              ),
              ElevatedButton(
                key: Key('doctor'),
                child: Text('Doctor'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage('Doctor')));
                },
              ),
              ElevatedButton(
                key: Key('patient'),
                child: Text('Patient'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage('Patient')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
