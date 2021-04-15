import 'package:flutter/material.dart';
import 'package:healthiee/screens/Homepage.dart';


class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 80, bottom: 30, left: 16, right: 16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/doc.jpg'), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Healthiee',
                    style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 60,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuckiestGuy'),
                  ),
                  Text(
                    'An All in One Hospital Management app!',
                    style: TextStyle(
                        color: Colors.cyan[900],
                        fontSize: 14,
                        letterSpacing: 1,
                        fontFamily: 'Pacifico'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.teal[800],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6))),
                    margin: EdgeInsets.all(0),
                    child: Text(
                      'Get Started as:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.teal[700]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              key: Key('admin'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage('Admin')));
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                      width: 2, color: Colors.cyanAccent[700]),
                                ),
                              )),
                              child: Text(
                                'Admin',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[900]),
                              )),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                              key: Key('doctor'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage('Doctor')));
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                      width: 2, color: Colors.cyanAccent[700]),
                                ),
                              )),
                              child: Text(
                                'Doctor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[900]),
                              )),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                              key: Key('patient'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage('Patient')));
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                      width: 2, color: Colors.cyanAccent[700]),
                                ),
                              )),
                              child: Text(
                                'Patient',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[900]),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            HomePageQualWidget(
              heading: 'Easy To Use',
              subHeading: 'Simple UI and easy to use!',
              iconData: Icons.thumb_up,
            ),
            Divider(color: Colors.white),
            HomePageQualWidget(
              heading: 'Extensive Functionalities',
              subHeading: 'App provides numerous actions!',
              iconData: Icons.card_giftcard,
            ),
            Divider(color: Colors.white),
            HomePageQualWidget(
              heading: 'Amazing Services',
              subHeading: 'Hassle-free and quick services!',
              iconData: Icons.settings,
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/loginBgjpg.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    color: Colors.white,
                  ),
                  Text(
                    'Great Facilities',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Testimonials',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '\"The app UI is smooth, and it functions extremely well. It has so many features for all of the User groups. Being an admin I can manage a vast number of parameters\"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '- BISWA (Admin)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageQualWidget extends StatelessWidget {
  final IconData iconData;
  final String heading;
  final String subHeading;

  HomePageQualWidget({this.heading, this.iconData, this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.cyanAccent,
          ),
          SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                heading,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
              Text(
                subHeading,
                style: TextStyle(color: Colors.white54),
              ),
            ],
          )
        ],
      ),
    );
  }
}
