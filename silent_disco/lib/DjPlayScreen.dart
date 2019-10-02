import 'package:flutter/material.dart';
import 'package:silent_disco/DJEventsScreen.dart';
import 'package:silent_disco/Song.dart';

class DjPlayScreen extends StatelessWidget {
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
      home: new DjPlay(),
    );
  }
}

class DjPlay extends StatefulWidget {
  DjPlay({Key key}) : super(key: key);

  @override
  _DjPlayState createState() => new _DjPlayState();
}

class _DjPlayState extends State<DjPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
      title: new Text("Dj play screen"),
      automaticallyImplyLeading: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DjEventsScreen()),
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
    List<Song> playlist = new List<Song>();
    List<ListTile> tiles = new List<ListTile>();

    playlist.add(new Song("Brothermanbill", "Bill", true));
    playlist.add(new Song("Hallo", "k3", false));
    playlist.add(new Song("Hoi", "U2", true));
    playlist.add(new Song("Heey", "Coldplay", true));
    playlist.add(new Song("Fontys", "White Lies", true));

    for(Song song in playlist){
      tiles.add(
          ListTile(
            title: Text(song.song),
            trailing: Text(
                song.artist
            ),
          )
      );
    }
    return tiles;
  }

}
