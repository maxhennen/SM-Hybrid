import 'package:flutter/material.dart';
import 'package:silent_disco/Channel.dart';
import 'package:silent_disco/ChannelSoundPage.dart';
import 'package:silent_disco/Event.dart';
import 'package:silent_disco/ListenerEventsPage.dart';
import 'package:silent_disco/Song.dart';

BuildContext buildContext;

class EventChannelsPage extends StatelessWidget {

  Event selectedEvent;

  EventChannelsPage(Event event){
    this.selectedEvent = event;
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyEventChannelsPage(),
    );
  }
}

class MyEventChannelsPage extends StatefulWidget {
  MyEventChannelsPage({Key key}) : super(key: key);
  @override
  _MyEventChannelsPageState createState() => new _MyEventChannelsPageState();
}

class _MyEventChannelsPageState extends State<MyEventChannelsPage> {
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Live channels'),
        ),
          body: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _cardBuilder()
          )
    );
  }

  List<Widget> _cardBuilder(){
    List<GestureDetector> cardList = new List<GestureDetector>();
    List<Channel> channelList = new List<Channel>();
    channelList.add(new Channel(Color.fromARGB(180, 255, 0, 0), "Red Channel", "0", 23, new Song.empty()));
    channelList.add(new Channel(Color.fromARGB(180, 0, 255, 0), "Green Channel", "1", 7, new Song.empty()));
    channelList.add(new Channel(Color.fromARGB(180, 0, 0, 255), "Blue Channel", "2", 13, new Song.empty()));
    for(Channel channel in channelList){
      cardList.add(new GestureDetector(
          child: new Card(
          color: channel.color,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.album, size: 50),
                title: Text(
                  channel.name
                ),
                subtitle: Text(channel.amountOfListeners.toString() + " Listening."),
              ),
            ],
          ),
        ),
          onTap: () => cardTapped(channel),
      )
      );
    }

    return cardList;

  }

  cardTapped(Channel channel){
    if(channel.id != null){
      print('Card tapped: ' + channel.name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChannelSoundPage(channel)),
      );
    }
}

  void listenerReturnButton(context){
    Navigator.pop(context, MaterialPageRoute(builder: (context) => ListenerEventsPage()));
  }
}

