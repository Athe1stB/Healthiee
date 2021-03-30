import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';

class UpdateDocAccount extends StatefulWidget {
  @override
  _UpdateDocAccountState createState() => _UpdateDocAccountState();
}

class _UpdateDocAccountState extends State<UpdateDocAccount> {
  String name, dst, det, dept, licno, qual, imgUrl, email, userType;
  File selectedFile;
  Image profileImg = Image(image: AssetImage('images/505616.png'));

  Future chooseFile() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        selectedFile = File(pickedFile.path);
        profileImg = Image.file(selectedFile);
      }
    });
  }

  void makedef(String fileurl) {
    setState(() {
      imgUrl = fileurl;
    });
  }

  Future uploadFile() async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profileImg/${Path.basename(selectedFile.path)}}');
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(selectedFile);
    await uploadTask.whenComplete(() => null);
    print('File Uploaded');

    await storageReference.getDownloadURL().then((fileURL) {
      makedef(fileURL);
      print(fileURL);
    });
  }

  String currentUserEmail;

  void initializeAllParams() async {
    currentUserEmail = FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Doctors');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          name = value['name'];
          email = value['email'];
          licno = value['licno'];
          dst = value['dst'];
          det = value['det'];
          dept = value['dept'];
          imgUrl = value['imgUrl'];
          qual = value['qual'];
          userType = value['userType'];
        });
      }
    });
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Update Account',
          style: styleBoldBlackMedium,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileImg,
                TextButton(
                    onPressed: () async {
                      await chooseFile();
                    },
                    child: Text('Choose image from gallery')),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      licno = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'License No.',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      dept = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Department',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      qual = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Qualifications',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      dst = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Duty Start Time',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      det = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Duty End Time',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await uploadFile();
                    CollectionReference user =
                        FirebaseFirestore.instance.collection('Doctors');
                    await user.doc(email).update({
                      'name': name,
                      'licno': licno,
                      'dept': dept,
                      'dst': dst,
                      'det': det,
                      'qual': qual,
                      'imgUrl': imgUrl
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update Profile',
                    style: elementwhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
