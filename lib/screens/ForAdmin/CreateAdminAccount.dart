import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/screens/ForAdmin/AdminDashboard.dart';
import 'package:healthiee/services/Admin.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';

class CreateAdminAccount extends StatefulWidget {
  @override
  _CreateAdminAccountState createState() => _CreateAdminAccountState();
}

class _CreateAdminAccountState extends State<CreateAdminAccount> {
  String name;
  String accID =
      (FirebaseAuth.instance.currentUser.email.toString()).substring(0, 10);
  bool isUnique = true;
  File selectedFile;
  Image profileImg = Image(image: AssetImage('images/505616.png'),height: 100, width: 100,);
  String uploadURL = defaultImgUrl;
  
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
        uploadURL = fileURL;
      });
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
                ElevatedButton(
                  onPressed: () async {
                    if(selectedFile!=null)
                      await uploadFile();
                      
                    Admin admin = new Admin(name, accID, uploadURL, 'Admin');
                    bool got = await admin.addToCloud();
                    setState(() {
                      isUnique = got;
                    });
                    if (isUnique) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AdminDashboard()));
                      SystemNavigator.pop();
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
