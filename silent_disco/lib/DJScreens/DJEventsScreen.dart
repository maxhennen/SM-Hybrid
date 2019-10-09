import 'package:flutter/material.dart';
import 'package:silent_disco/DJScreens/AddEventScreen.dart';

import 'DjPlaylistScreen.dart';
import 'DjSignInScreen.dart';
import '../DJScreens/DjEvent.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
              onPressed: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEventScreen()),
              )
          )
        ],
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

    List<DjEvent> eventList = new List<DjEvent>();
    List<ListTile> tiles = new List<ListTile>();

    List<String> djs = new List<String>();
    djs.add("max@max.nl");
    djs.add("jan@jan.nl");

    eventList.add(new DjEvent("Solar", "09-08-2020", "13:00", djs));
    eventList.add(new DjEvent("Pinkpop", "01-07-2020", "15:00", djs));
    eventList.add(new DjEvent("Pukkelpop", "01-06-2020", "17:00", djs));

    for(DjEvent event in eventList){
      tiles.add(
          ListTile(
            title: Text(event.name),
              trailing: Text(
                "Date: " + event.date + " time: " + event.time
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
