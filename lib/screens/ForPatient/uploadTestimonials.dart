import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class UploadTestimonials extends StatefulWidget {
  @override
  _UploadTestimonialsState createState() => _UploadTestimonialsState();
}

class _UploadTestimonialsState extends State<UploadTestimonials> {
  String fileName = "none", fileExt = 'pdf';
  String patName,
      patEmail = FirebaseAuth.instance.currentUser.email.toString(),
      nextDoc;
  int fileSize = 0;
  File selectedFile;
  String pdfUrl;

  Future uploadFile() async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('reports/${Path.basename(selectedFile.path)}}');
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(selectedFile);
    await uploadTask.whenComplete(() => null);
    print('File Uploaded');

    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        pdfUrl = fileURL;
      });
      print(pdfUrl);
    });
  }

  Future chooseFile() async {
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    setState(() {
      selectedFile = file;
      fileSize = file.statSync().size;
      //fileName = file.statSync().toString();
    });
  }

  void initialiseParams() async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(patEmail)
        .get()
        .then((value) {
      patName = value['name'];
      nextDoc = value['nextAppointment'];
    });
  }

  @override
  void initState() {
    initialiseParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(fileName),
                Text('.' + fileExt),
                VerticalDivider(),
                Text((fileSize / 1000).toString() + ' KB'),
              ],
            ),
            TextButton(
              onPressed: () async {
                await chooseFile();
              },
              child: Text('choose PDF'),
            ),
            TextButton(
              onPressed: () async {
                if (nextDoc.compareTo('none') != 0) {
                  await uploadFile();
                  await FirebaseFirestore.instance
                      .collection('Patients')
                      .doc(patEmail)
                      .update({'reportUrl': pdfUrl});

                  List reportsDoc;

                  await FirebaseFirestore.instance
                      .collection('Doctors')
                      .doc(nextDoc)
                      .get()
                      .then((value) {
                    reportsDoc = value['reports'];
                  });

                  reportsDoc.add({
                    'name': patName,
                    'email': patEmail,
                    'reportUrl': pdfUrl
                  });
                  await FirebaseFirestore.instance
                      .collection('Doctors')
                      .doc(nextDoc)
                      .update({'reports': reportsDoc});
                  SnackBar(
                    content: Text('Uploaded success'),
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Text('Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
