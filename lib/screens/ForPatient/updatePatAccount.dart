import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:healthiee/services/Patients.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';

class UpdatePatAccount extends StatefulWidget {
  @override
  _UpdatePatAccountState createState() => _UpdatePatAccountState();
}

class _UpdatePatAccountState extends State<UpdatePatAccount> {
  String name, age, gender, imgUrl = defaultImgUrl, email, userType = 'Patient';
  File selectedFile;
  Image profileImg = Image(
    image: AssetImage('images/505616.png'),
    height: 100,
    width: 100,
  );

  Future chooseFile() async {
    final file =
        await FilePicker.getFile(type: FileType.image);
    setState(() {
      if (file != null) {
        selectedFile = File(file.path);
        profileImg = Image.file(
          selectedFile,
          height: 100,
          width: 100,
        );
      }
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
      setState(() {
        imgUrl = fileURL;
      });
      print(imgUrl);
    });
  }

  String currentUserEmail;

  void initializeAllParams() async {
    currentUserEmail = FirebaseAuth.instance.currentUser.email.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('Patients');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          name = value['name'];
          email = value['email'];
          age = value['age'];
          gender = value['gender'];
          imgUrl = value['imgUrl'];
          userType = value['userType'];
        });
      }
    });
  }

  void updateEntry() async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(email)
        .update({'name': name, 'age': age, 'gender': gender, 'imgUrl': imgUrl});
  }

  void createNew() async {
    String applNo = email.substring(0, 10);
    Patient patient = new Patient(name, applNo, gender, imgUrl, age, userType);
    await patient.addToCloud();
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
                  key: Key('name'),
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
                  key: Key('age'),
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                TextField(
                  key: Key('gender'),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: normal,
                    focusColor: Colors.purple,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedFile != null) await uploadFile();
                    updateEntry();
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
