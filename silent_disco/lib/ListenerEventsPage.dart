import 'package:flutter/material.dart';
import 'package:silent_disco/Event.dart';

void main() {
  runApp(new ListenerEventsPage());
}
class ListenerEventsPage extends StatelessWidget {

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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Events'),

        ),
        body:
          new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRow()
          ),

    );
  }

  List<Widget> _buildRow(){
    //Todo: Remove mock code:
    List<ListTile> listTiles = new List<ListTile>();
    List<Event> events = new List<Event>();
    events.add(new Event(2300, "Summer Jam", false));
    events.add(new Event(400, "Library Concert", false));
    events.add(new Event(5400, "Public Bar", true));
    //Todo: Generate events here.
    for(int i = 0; i < events.length; i++){
      ListTile(
          title: Text(
              events[i].eventName
          ),
          trailing: Text(
              "Distance to Event: " +
                  events[i].distanceFromUserInMeters.round().toString() + "m"
          )
      );
    }
    return listTiles;
  }

  void listenerReturnButton(){
    Navigator.pop(context);
  }

  void listenerButtonPressed(){

  }

  void djButtonPressed(){

  }

}