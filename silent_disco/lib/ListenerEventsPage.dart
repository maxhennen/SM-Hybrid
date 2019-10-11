import 'package:flutter/material.dart';
import 'package:silent_disco/Event.dart';
import 'package:silent_disco/EventChannelsPage.dart';

void main() {
  runApp(new ListenerEventsPage());
}

List<Event> events = new List<Event>();

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
      home: new MyListenerEventsPage(),
    );
  }
}

class MyListenerEventsPage extends StatefulWidget {
  MyListenerEventsPage({Key key}) : super(key: key);
  @override
  _MyListenerEventsPageState createState() => new _MyListenerEventsPageState();
}

class _MyListenerEventsPageState extends State<MyListenerEventsPage> {
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
    events.clear();
    events.add(new Event(2300, "Summer Jam", "0"));
    events.add(new Event(400, "Library Concert", "1"));
    events.add(new Event(5400, "Public Bar", "2"));
    //Todo: Generate events here.
    for(Event event in events){
      listTiles.add(new ListTile(
          title: Text(
              event.name
          ),
          trailing: Text(
              "Distance to Event: " +
                  event.distanceFromUserInMeters.round().toString() + "m"
          ),
          onTap: () => eventPressed(events.indexOf(event)),
      )
    );
  }
    return listTiles;
  }

  void listenerReturnButton(){
    Navigator.pop(context);
  }

  void eventPressed(int index){
    if(events[index].withinRange){
      //Todo: Switch pages.
      print('Event within range. Navigating...');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventChannelsPage(events[index])),
      );
    }
  }

}