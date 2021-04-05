import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthiee/constants.dart';

class Doctor {
  String name, dst, det, dept, licno, qual, imgUrl, userType;
  List<String> appointments;
  String email = FirebaseAuth.instance.currentUser.email.toString();

  Doctor(this.name, this.licno, this.dept, this.dst, this.det, this.qual,
      this.imgUrl, this.userType);

  Future<bool> addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Doctors');

    bool toreturn = true, cond1 = false, cond2 = false;

    await doclist.doc(licno).get().then((DocumentSnapshot documentSnapshot) {
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
      if (licno == null) licno = 'licno';
      if (dept == null) dept = 'dept';
      if (det == null) det = 'det';
      if (dst == null) dst = 'dst';
      if (qual == null) qual = 'qual';

      await doclist.doc(email).set({
        'name': name,
        'licno': licno,
        'dept': dept,
        'det': det,
        'dst': dst,
        'qual': qual,
        'email': email,
        'imgUrl': imgUrl,
        'userType': 'Doctor',
        'appointments': [],
      });
    }

    return toreturn;
  }
}
