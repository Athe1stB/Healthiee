import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Medicine {
  String name, qty, price, mfd;

  Medicine(this.name, this.price, this.mfd, this.qty);

  Future addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Medicines');

    var medList = [];

    String addedby = FirebaseAuth.instance.currentUser.email.toString();

    await doclist
        .doc('Medicine List')
        .get()
        .then((value) => medList = value['Meds']);

    int index = -1;

    for (int i = 0; i < medList.length; i++) {
      if (medList[i]['name'] == name) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      medList[index]['name'] = name;
      medList[index]['qty'] = qty;
      medList[index]['price'] = price;
      medList[index]['mfd'] = mfd;
    } else {
      medList.add({
        'name': name,
        'mfd': mfd,
        'qty': qty,
        'price': price,
        'added by': addedby,
      });
    }

    await doclist.doc('Medicine List').update({
      'Meds': medList,
    });
  }
}
