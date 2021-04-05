import 'package:flutter/material.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForDoctor/DocDashboard.dart';
import 'package:healthiee/services/Doctor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';

class CreateDocAccount extends StatefulWidget {
  @override
  _CreateDocAccountState createState() => _CreateDocAccountState();
}

class _CreateDocAccountState extends State<CreateDocAccount> {
  String name, dst, det, dept, licno, qual;
  bool isUnique = true;
  File selectedFile;
  Image profileImg = Image(image: AssetImage('images/505616.png'),height: 100, width: 100,);
  String uploadURL = defaultImgUrl;

  Future chooseFile() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        selectedFile = File(pickedFile.path);
        profileImg = Image.file(selectedFile,height: 100, width: 100,);
      }
    });
  }

  void makedef(String fileurl) {
    setState(() {
      uploadURL = fileurl;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Create Account',
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
                    if(selectedFile!=null)
                      await uploadFile();
                    Doctor newAcc = new Doctor(
                        name, licno, dept, dst, det, qual, uploadURL, 'Doctor');
                    bool got = await newAcc.addToCloud();
                    setState(() {
                      isUnique = got;
                    });
                    if (isUnique) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DocDashboard()));
                    }
                  },
                  child: Text(
                    'Create Profile',
                    style: elementwhite,
                  ),
                ),
                Visibility(
                    visible: !isUnique,
                    child: Text('ID with licNo. or Email Already Present')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
