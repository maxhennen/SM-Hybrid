import 'package:flutter/material.dart';
import 'package:silent_disco/Channel.dart';
import 'package:silent_disco/Event.dart';
import 'package:silent_disco/EventChannelsPage.dart';
import 'package:silent_disco/ListenerEventsPage.dart';

BuildContext buildContext;
Channel selectedChannel;
Event selectedEvent;
double _sliderValue = 10.0;

class ChannelSoundPage extends StatelessWidget {


  ChannelSoundPage(Channel channel, Event event){
    selectedChannel = channel;
    selectedEvent = event;
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
      home: new MyChannelSoundPage(),
    );
  }
}

class MyChannelSoundPage extends StatefulWidget {
  MyChannelSoundPage({Key key}) : super(key: key);
  @override
  _MyChannelSoundPageState createState() => new _MyChannelSoundPageState();
}

class _MyChannelSoundPageState extends State<MyChannelSoundPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: selectedChannel.color,
          appBar: new AppBar(
            title: new Text(selectedChannel.name),
            automaticallyImplyLeading: true,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () =>  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventChannelsPage(selectedEvent)),
                  ))
          ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Icon(
                  Icons.disc_full,
                  color: const Color(0xFF000000),
                  size: 48.0
              ),
            ),
            new Center(
              child: new Text(
                selectedChannel.currentlyPlayingSong.name!=null?selectedChannel.currentlyPlayingSong.name:'Song name not found.',
              ),
            ),
            new Center(
              child: new Slider(min: 0.0,
                max: 15.0,
                key: null,
                onChanged: (newRating) {
                  setState(() => _sliderValue = newRating);
                },
                value: _sliderValue,
              )
            )
          ]
      ),
    );
  }

  void listenerReturnButton(context){
    Navigator.pop(context, MaterialPageRoute(builder: (context) => ListenerEventsPage()));
  }

  sliderChanged(){

  }
}

