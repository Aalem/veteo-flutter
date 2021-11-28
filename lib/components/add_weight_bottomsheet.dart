import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:veteo_graph/api/veteo_api.dart';
import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/models/weight.dart';

class AddWeight extends StatelessWidget {
  const AddWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedWeight = 12;
    int selectedDate = DateTime.now().millisecondsSinceEpoch;
    return ListView(
        // color: Colors.cyan,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Add Weight',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Choose a date',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                width: double.maxFinite,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (d) {
                    selectedDate = d.millisecondsSinceEpoch;
                  },
                ),
              ),
              const SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Pick the weight',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: CupertinoPicker(
                    itemExtent: 22,
                    onSelectedItemChanged: (item) {
                      selectedWeight = listOfWeight[item];
                    },
                    children: listOfWeight
                        .map((e) => Text(
                              e.toString(),
                              style: const TextStyle(fontSize: 18),
                            ))
                        .toList()),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        shape: const StadiumBorder(),
                        primary: Colors.blue.shade100,
                        onPrimary: Colors.white),
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20, color: Colors.blue, letterSpacing: 1.5),
                    ),
                    onPressed: () {
                      VeteoAPI().addWeight(
                          Weight(weight: selectedWeight, date: selectedDate));
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          )
        ]);
  }
}
