import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:silent_disco/DJScreens/AudioProvider.dart';
import 'package:silent_disco/DJScreens/DJEventsScreen.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'dart:async';

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
  static List<AudioTrack> playlist = getPlaylist();
  List<Widget> tiles = buildList(playlist);
  static AudioTrack isNowPlaying = playlist.first;

  static AudioPlayer player = new AudioPlayer();
  static TextEditingController txtController = new TextEditingController();
  static Text text = new Text(isNowPlaying.title + " - " + isNowPlaying.artist);

  @override
  Widget build(BuildContext context) {
    txtController.text = isNowPlaying.title + " - " + isNowPlaying.artist;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dj playlist"),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
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
          children: tiles),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          children: <Widget>[
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
            new IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  playBtn(isNowPlaying);
                }),
            new IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  stopBtn();
                }),
            new IconButton(icon: Icon(Icons.arrow_forward), onPressed: null),
            new Flexible(
                child: new TextField(
              controller: txtController,
              decoration: const InputDecoration(),
            ))
          ],
        ),
      ),
    );
  }

  static List<Widget> buildList(List<AudioTrack> playlist) {
    List<ListTile> tiles = new List<ListTile>();

    for (AudioTrack track in playlist) {
      tiles.add(ListTile(
        title: Text(track.title),
        trailing: Text(track.artist),
        onTap: () => tapListTile(track),
        onLongPress: () => removeSong(track),
      ));
    }
    return tiles;
  }

  static List<AudioTrack> getPlaylist() {
    List<AudioTrack> tracks = new List<AudioTrack>();
    tracks.add(new AudioTrack(
        album: "Friends",
        artist: "Bon Jovi",
        assetUrl:
            "https://www.soundboard.com/mediafiles/22/223554-d1826dea-bfc3-477b-a316-20ded5e63e08.mp3",
        title: "I'll be there for you"));
    tracks.add(new AudioTrack(
        album: "Friends",
        artist: "Ross",
        assetUrl:
            "https://www.soundboard.com/mediafiles/22/223554-fea5dfff-6c80-4e13-b0cf-9926198f50f3.mp3",
        title: "The Sound"));
    tracks.add(new AudioTrack(
        album: "Friends",
        artist: "Friends",
        assetUrl:
            "https://www.soundboard.com/mediafiles/22/223554-3943c7cb-46e0-48b1-a954-057b71140e49.mp3",
        title: "F.R.I.E.N.D.S"));

    return tracks;
  }

  static void tapListTile(AudioTrack track) {
    player.stop();
    playBtn(track);
  }

  static void removeSong(AudioTrack track) {}

  static void addSong() {}

  static void playBtn(AudioTrack track) async {
    isNowPlaying = track;
    txtController.text = isNowPlaying.title + " - " + isNowPlaying.artist;
    AudioProvider provider = new AudioProvider(track.assetUrl);
    String localUrl = await provider.load();
    final Uint8List bytes = await provider.loadFileBytes(track.assetUrl);
    await startStreaming(bytes);
    player.play(localUrl, isLocal: true);
  }

  void stopBtn() {
    player.pause();
  }

  static Future<void> startStreaming(Uint8List bytes) async {
    try {
      Socket socket = await Socket.connect("http://10.0.2.2", 50005);
      socket.add(bytes);

    } catch (e) {
      rethrow;
    }
  }
}
