import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/services/Donor.dart';

class AddDonor extends StatefulWidget {
  @override
  _AddDonorState createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  String name, organ, addedby;
  var donorList = [];
  List<ListTile> donors;

  void initializeAllParams() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('Donors');

    await ref.doc('Donor List').get().then((value) {
      setState(() {
        donorList = value['Donors'];
      });
    });

    print(donorList);
  }

  void deleteItem(int i) async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Donors');

    donorList.removeAt(i);

    await doclist.doc('Donor List').update({
      'Donors': donorList,
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

    for (int i = 0; i < donorList.length; i++) {
      ltList.add(
        new ListTile(
          contentPadding: EdgeInsets.all(4),
          minLeadingWidth: 10,
          leading: Text((i + 1).toString(), style: purpleNormalBold),
          title: IntrinsicHeight(
            child: Text(
              donorList[i]['name'],
              style: blueNormalBold,
            ),
          ),
          subtitle: Text(donorList[i]['organ']),
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
          'Donor',
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
                  key: Key('organ'),
                  onChanged: (value) {
                    setState(() {
                      organ = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Organ',
                    labelStyle: normal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (name != null && organ != null) {
                      Donor donor = new Donor(name, organ);
                      await donor.addToCloud();
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
