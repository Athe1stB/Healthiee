import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:healthiee/constants.dart';
import 'package:healthiee/services/Medicine.dart';

class AddMeds extends StatefulWidget {
  @override
  _AddMedsState createState() => _AddMedsState();
}

class _AddMedsState extends State<AddMeds> {
  String name, qty, price, mfd, addedby;
  var medList = [];
  List<ListTile> meds;

  void initializeAllParams() async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('Medicines');

    await ref.doc('Medicine List').get().then((value) {
      setState(() {
        medList = value['Meds'];
      });
    });

    print(medList);
  }

  void deleteItem(int i) async {
    CollectionReference doclist =
        FirebaseFirestore.instance.collection('Medicines');

    medList.removeAt(i);

    await doclist.doc('Medicine List').update({
      'Meds': medList,
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

    for (int i = 0; i < medList.length; i++) {
      ltList.add(
        new ListTile(
          contentPadding: EdgeInsets.all(4),
          minLeadingWidth: 10,
          leading: Text((i + 1).toString(), style: purpleNormalBold),
          title: IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  medList[i]['name'],
                  style: blueNormalBold,
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                Text(
                  medList[i]['mfd'],
                  style: elementgray,
                ),
              ],
            ),
          ),
          subtitle: Row(
            children: [
              Text(medList[i]['qty'] + 'pcs'),
              VerticalDivider(),
              Text('Rs.' + medList[i]['price'] + ' each'),
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
          'Medicines',
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
                  key: Key('quantity'),
                  onChanged: (value) {
                    setState(() {
                      qty = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: normal,
                  ),
                ),
                TextField(
                  key: Key('price'),
                  onChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Price Each',
                    labelStyle: normal,
                  ),
                ),
                TextField(
                  key: Key('date'),
                  onChanged: (value) {
                    setState(() {
                      mfd = value;
                    });
                  },
                  style: purpleNormalBold,
                  decoration: InputDecoration(
                    labelText: 'Manufacturing Date',
                    labelStyle: normal,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (name != null &&
                        price != null &&
                        mfd != null &&
                        qty != null) {
                      Medicine medicine = new Medicine(name, price, mfd, qty);
                      await medicine.addToCloud();
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
