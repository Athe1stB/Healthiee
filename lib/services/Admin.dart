import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthiee/constants.dart';

class Admin {
  String name, accID, imgUrl, userType;
  String email = FirebaseAuth.instance.currentUser.email.toString();

  Admin(this.name, this.accID, this.imgUrl, this.userType);

  Future<bool> addToCloud() async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Admins');

    bool toreturn = true, cond1 = false, cond2 = false;

    await doclist.doc(accID).get().then((DocumentSnapshot documentSnapshot) {
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
      
      if (name == null) name = 'Admin';
      if (accID == null) accID = 'accID';
      if (email == null) email = 'email';
      if (imgUrl == null) imgUrl = defaultImgUrl;
      if (userType == null) userType = 'Admin';

      await doclist.doc(email).set({
          'name': name,
          'accID': accID,
          'email': email,
          'imgUrl': imgUrl,
          'userType': userType,
        });
    }

    return toreturn;
  }
}