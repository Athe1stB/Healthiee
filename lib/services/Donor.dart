import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Donor {
  String name, organ;

  Donor(
    this.name,
    this.organ,
  );

  Future addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Donors');

    var donorList = [];

    // String addedby = FirebaseAuth.instance.currentUser.email.toString();

    await doclist
        .doc('Donor List')
        .get()
        .then((value) => donorList = value['Donors']);

    int index = -1;

    for (int i = 0; i < donorList.length; i++) {
      if (donorList[i]['name'] == name) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      donorList[index]['name'] = name;
      donorList[index]['organ'] = organ;
    } else {
      donorList.add({
        'name': name,
        'organ': organ,
      });
    }

    await doclist.doc('Donor List').update({
      'Donors': donorList,
    });
  }
}
