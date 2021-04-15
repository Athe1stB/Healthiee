import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ext_storage/ext_storage.dart';

class SeeReports extends StatefulWidget {
  @override
  _SeeReportsState createState() => _SeeReportsState();
}

class _SeeReportsState extends State<SeeReports> {
  bool downloading = false;
  String reportCount = '0';
  var patients = [];

  void make(var list) {
    setState(() {
      patients = list;
      reportCount = list.length.toString();
    });
    print(patients);
  }

  Future getPatList() async {
    String email = FirebaseAuth.instance.currentUser.email.toString();
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(email)
        .get()
        .then((value) {
      make(value['reports']);
    });
    return patients;
  }

  void getPermission() async {
    print("getPermission");
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print('access granted');
    }
  }

  void initParams() async {
    // await PermissionHandler;
    getPermission();
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  void downloadTask(String reportUrl, String email) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String fileName = email.substring(0, 10) + '.pdf';
    String fullPath = "$path/$fileName.pdf";

    var dio = Dio();
    try {
      Response response = await dio.get(
        reportUrl,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print('error');
      print(e);
    }
  }

  void downloadTask2(String reportUrl, String email) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String filen = email.substring(0, 9) + '.pdf';

    final taskId = await FlutterDownloader.enqueue(
      url: reportUrl,
      fileName: filen,
      savedDir: path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
    FlutterDownloader.open(taskId: taskId);
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  void initState() {
    initParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports ($reportCount)'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getPatList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(patients);
              var lt = <Widget>[];
              for (int i = 0; i < patients.length; i++) {
                lt.add(new ListTile(
                  tileColor: Colors.yellow,
                  leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(patients[i]['email']),
                  subtitle: Text(patients[i]['name']),
                  trailing: GestureDetector(
                    onTap: () {
                      downloadTask2(
                          patients[i]['reportUrl'], patients[i]['email']);
                    },
                    child: Icon(Icons.file_download),
                  ),
                ));
                lt.add(SizedBox(height: 8));
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: lt,
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
