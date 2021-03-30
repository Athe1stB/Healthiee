import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class HomePage extends StatelessWidget {
  final String userType;

  HomePage(this.userType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userType),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(userType)));
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage(userType)));
              },
              child: Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}