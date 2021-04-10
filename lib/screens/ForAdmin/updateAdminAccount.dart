import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';

class UpdateAdminAccount extends StatefulWidget {
  @override
  _UpdateAdminAccountState createState() => _UpdateAdminAccountState();
}

class _UpdateAdminAccountState extends State<UpdateAdminAccount> {
  String name, email, imgUrl = defaultImgUrl;
  String accID =
      (FirebaseAuth.instance.currentUser.email.toString()).substring(0, 10);
  File selectedFile;
  String uploadURL = defaultImgUrl;

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
    CollectionReference ref = FirebaseFirestore.instance.collection('Admins');

    await ref.doc(currentUserEmail).get().then((value) {
      if (value.exists) {
        setState(() {
          name = value['name'];
          email = value['email'];
          accID = value['accID'];
          imgUrl = value['imgUrl'];
        });
      }
    });
  }

  void updateEntry() async {
    await FirebaseFirestore.instance.collection('Admins').doc(email).update({
      'name': name,
      'accID':
          (FirebaseAuth.instance.currentUser.email.toString()).substring(0, 10),
      'imgUrl': imgUrl,
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
