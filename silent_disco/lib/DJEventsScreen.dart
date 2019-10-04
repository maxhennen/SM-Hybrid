import 'package:flutter/material.dart';

import 'DjPlaylistScreen.dart';
import 'DjSignInScreen.dart';
import 'Event.dart';

class DjEventsScreen extends StatelessWidget {

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
      home: new DjEvents(),
    );
  }
}

class DjEvents extends StatefulWidget {
  DjEvents({Key key}) : super(key: key);
  @override
  _DjEventsState createState() => new _DjEventsState();
}

class _DjEventsState extends State<DjEvents> {


  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dj events"),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DjSignInScreen()),
            )),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildList()
      ),
    );
  }

  List<Widget> buildList(){

    List<Event> eventList = new List<Event>();
    List<ListTile> tiles = new List<ListTile>();

    eventList.add(new Event(2300, "School", false));
    eventList.add(new Event(400, "Thuis", true));
    eventList.add(new Event(1000, "Werk", false));

    for(Event event in eventList){
      tiles.add(
          ListTile(
            title: Text(event.eventName),
              trailing: Text(
                "Distance to Event: " + event.distanceFromUserInMeters.round().toString() + "m"
              ),
            onTap: () => tapListTile(),
          )
        );
    }
    return tiles;
  }

  void tapListTile(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DjPlaylistScreen()),
    );
  }

}
