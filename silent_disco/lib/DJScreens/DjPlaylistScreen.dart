import 'package:flutter/material.dart';
import 'package:silent_disco/DJScreens/DJEventsScreen.dart';
import 'Song.dart';


class DjPlaylistScreen extends StatelessWidget {
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
      home: new DjPlaylist(),
    );
  }
}

class DjPlaylist extends StatefulWidget {
  DjPlaylist({Key key}) : super(key: key);
  @override
  _DjPlaylistScreenState createState() => new _DjPlaylistScreenState();
}



class _DjPlaylistScreenState extends State<DjPlaylist> {

  static List<Song> playlist = buildPlaylist();
  List<Widget> tiles = buildList(playlist);
  Song isNowPlaying = playlist.first;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dj playlist"),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DjEventsScreen()),
                )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addSong(),
          )
        ],

      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tiles
      ),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          children: <Widget>[
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
            new IconButton(icon: Icon(Icons.play_arrow), onPressed: null),
            new IconButton(icon: Icon(Icons.arrow_forward), onPressed: null),
            new Text("Song: " + isNowPlaying.title+ ". Artist: " + isNowPlaying.artist)
          ],
        ),
      ),
    );
  }

  static List<Widget> buildList(List<Song> playlist) {
    List<ListTile> tiles = new List<ListTile>();

    for (Song song in playlist) {
      tiles.add(
          ListTile(
            title: Text(song.title),
            trailing: Text(
                song.artist
            ),
            onTap: () => tapListTile(song),
            onLongPress: () => removeSong(song),
          )
      );
    }
    return tiles;
  }

  static List<Song> buildPlaylist(){
    List<Song> playlist = new List<Song>();
    playlist.add(new Song("ACDC", "Thunder"));
    playlist.add(new Song("Abba", "Mama mia"));
    playlist.add(new Song("Greenday", "Basket case"));
    return playlist;
  }

  static void tapListTile(Song song) {

  }

  static void removeSong(Song song) {

  }

  static void addSong() {

  }
}