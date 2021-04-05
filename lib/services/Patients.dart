import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthiee/constants.dart';

class Patient {
  String name, applNo, age, gender, imgUrl = defaultImgUrl, userType, nextAppointment='none';
  String email = FirebaseAuth.instance.currentUser.email.toString();

  Patient(this.name, this.applNo, this.gender, this.imgUrl, this.age, this.userType);

  Future<bool> addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Patients');

    bool toreturn = true, cond1 = false, cond2 = false;

    await doclist.doc(applNo).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists)
        cond1 = false;
      else
        cond1 = true;
    });

    await doclist.doc(email).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists)
        cond2 = false;
      else
        cond2 = true;
    });

    toreturn = cond1 && cond2;

    if (toreturn) {
      
      if (name == null) name = 'name';
      if (imgUrl == null) imgUrl = defaultImgUrl;
      
      await doclist.doc(email).set({
          'name': name,
          'applNo': applNo,
          'age': age,
          'gender': gender,
          'email': email,
          'imgUrl': imgUrl,
          'userType': userType,
          'nextAppointment':nextAppointment,
        });
    }

    return toreturn;
  }
}