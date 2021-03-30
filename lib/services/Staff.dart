import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Staff {
  String name, dst, det, dept;

  Staff(this.name, this.dept, this.dst, this.det);

  Future addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Staffs');

    var staffList = [];

    String addedby = FirebaseAuth.instance.currentUser.email.toString();

    await doclist
        .doc('Staff List')
        .get()
        .then((value) => staffList = value['Staffs']);

    int index = -1;

    for (int i = 0; i < staffList.length; i++) {
      if (staffList[i]['name'] == name) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      staffList[index]['name'] = name;
      staffList[index]['dept'] = dept;
      staffList[index]['det'] = det;
      staffList[index]['dst'] = dst;
    } else {
      staffList.add({
        'name': name,
        'dept': dept,
        'det': det,
        'dst': dst,
        'added by': addedby
      });
    }

    await doclist.doc('Staff List').update({
      'Staffs': staffList,
    });
  }
}
