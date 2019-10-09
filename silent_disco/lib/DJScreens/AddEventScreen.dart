import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:silent_disco/DJScreens/DJEventsScreen.dart';
import 'package:silent_disco/DJScreens/DateTimePicker.dart';

class AddEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new AddEvent(),
    );
  }
}

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => new _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String formattedDate;

  @override
  void initState() {
    super.initState();
  }

  String _date = "Not set";
  String _time = "Not set";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          HomeScreen()
        ],
      ),
    );
  }


}
