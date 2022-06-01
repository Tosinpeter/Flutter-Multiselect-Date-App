//@dart=2.9

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MSCalender(blankDate: DateTime(2022, 04, 07)));
}

//Add this to Dependency in flutter flow custom widget

// syncfusion_flutter_datepicker: ^19.4.56
// intl: ^0.16.0

/// My app class to display the date range picker
class MSCalender extends StatefulWidget {
  // this will fetch blank date from firestore
  final DateTime blankDate;

  const MSCalender({Key key, @required this.blankDate}) : super(key: key);

  @override
  MSCalenderState createState() => MSCalenderState();
}

/// State for MSCalender
class MSCalenderState extends State<MSCalender> {
  Set<String> selectedDate = {};
  DateTime blankDate;

// function to save the slected date set to db
  void saveSalectedDate() {
    if (selectedDate.contains("2022,04,07")) {
      // user as booked the date so save this to firebase
    } else {}
  }

  // funtion that trigger whenever user select a new date

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is List<DateTime>) {
        for (var item in args.value) {
          selectedDate.add(DateFormat('yyyy,MM,dd').format(item));
        }
      }
    });
  }

  void convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    blankDate = todayDate;
    print(blankDate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
      child: Column(
        children: [
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.multiple,
            monthViewSettings: DateRangePickerMonthViewSettings(
                showTrailingAndLeadingDates: false,
                blackoutDates: [
                  //replace this with the blank date
                  DateTime(2022, 04, 07)
                ]),
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
          ElevatedButton(
              onPressed: () {
                saveSalectedDate();
                convertDateFromString('2018-09-27 13:27:00');
              },
              child: const Text("Submit"))
        ],
      ),
    )));
  }
}
