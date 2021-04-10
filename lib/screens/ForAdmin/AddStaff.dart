import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/services/Staff.dart';

class AddStaff extends StatefulWidget {
  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  String name, dept, dst, det;
  var staffList = [];
  List<ListTile> staffs;

  void initializeAllParams() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('Staffs');

    await ref.doc('Staff List').get().then((value) {
      setState(() {
        staffList = value['Staffs'];
      });
    });

    print(staffList);
  }

  void deleteItem(int i) async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Staffs');

    staffList.removeAt(i);

    await doclist.doc('Staff List').update({
      'Staffs': staffList,
    });
    initializeAllParams();
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ltList = <ListTile>[];

    for (int i = 0; i < staffList.length; i++) {
      ltList.add(
        new ListTile(
          contentPadding: EdgeInsets.all(4),
          minLeadingWidth: 10,
          leading: Text((i + 1).toString(), style: purpleNormalBold),
          title: IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  staffList[i]['name'],
                  style: blueNormalBold,
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                Text(
                  staffList[i]['dept'],
                  style: elementgray,
                ),
              ],
            ),
          ),
          subtitle: Row(
            children: [
              Text(staffList[i]['dst']),
              Text(' - '),
              Text(staffList[i]['det']),
            ],
          ),
          trailing: GestureDetector(
            key: Key(i.toString()),
            onTap: () {
              ConfirmAlertBox(
                  context: context,
                  title: 'Delete Entry ?',
                  infoMessage: 'You cant undo this action.',
                  titleTextColor: Colors.purple,
                  buttonTextForYes: 'Back',
                  buttonTextForNo: 'Delete',
                  onPressedNo: () {
                    deleteItem(i);
                    Navigator.pop(context);
                  },
                  onPressedYes: () {
                    Navigator.pop(context);
                  });
            },
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Staffs',
          style: styleBoldWhiteMedium,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  ),
                ),
                TextField(
                  key: Key('dept'),
                  onChanged: (value) {
                    setState(() {
                      dept = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Department',
                    labelStyle: normal,
                  ),
                ),
                TextField(
                  key: Key('dst'),
                  onChanged: (value) {
                    setState(() {
                      dst = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Duty Start Time',
                    labelStyle: normal,
                  ),
                ),
                TextField(
                  key: Key('det'),
                  onChanged: (value) {
                    setState(() {
                      det = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Duty End Time',
                    labelStyle: normal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (name != null &&
                        dept != null &&
                        dst != null &&
                        det != null) {
                      Staff staff = new Staff(name, dept, dst, det);
                      await staff.addToCloud();
                      initializeAllParams();
                    }
                  },
                  child: Text('Add/Update'),
                ),
                Container(
                    height: 500,
                    child: ListView(
                      children: ltList,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
