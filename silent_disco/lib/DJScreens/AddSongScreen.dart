import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'package:silent_disco/DJScreens/DjPlaylistScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:silent_disco/DJScreens/FirebaseAuth.dart';
import 'package:uuid/uuid.dart';



class AddSongScreen extends StatelessWidget {
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
      home: new AddSong(),
    );
  }
}

class AddSong extends StatefulWidget {
  AddSong({Key key}) : super(key: key);
  @override
  _AddSongState createState() => new _AddSongState();
}

class _AddSongState extends State<AddSong> {

  final _formKey = new GlobalKey<FormState>();
  String _artist;
  String _title;
  String _album;
  String _assetUrl;

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Add song'),
          leading: new IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DjPlaylist())
                  )
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSongScreen()),
                )
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
          ],
        ));
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showArtistInput(),
              _showTitleInput(),
              _showAlbumInput(),
              _showAssetUrlInput(),
              _showAddButton(),
            ],
          ),
        ));
  }

  Widget _showArtistInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Artist',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Artist can\'t be empty' : null,
        onSaved: (value) => _artist = value.trim(),
      ),
    );
  }

  Widget _showTitleInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Title',
            icon: new Icon(
              Icons.title,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
        onSaved: (value) => _title = value.trim(),
      ),
    );
  }

  Widget _showAlbumInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Album',
            icon: new Icon(
              Icons.album,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Album can\'t be empty' : null,
        onSaved: (value) => _album = value.trim(),
      ),
    );
  }

  Widget _showAssetUrlInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Url',
            icon: new Icon(
              Icons.web,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Url can\'t be empty' : null,
        onSaved: (value) => _assetUrl = value.trim(),
      ),
    );
  }

  Widget _showAddButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Add',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      try {
        AudioTrack audioTrack = new AudioTrack(
            album: _album, artist: _artist, assetUrl: _assetUrl, title: _title);

        final databaseReference = FirebaseDatabase.instance.reference();
        BaseAuth auth = new Auth();

        FirebaseUser user = await auth.getCurrentUser();
        String userId = user.uid;
        var uuid = new Uuid();

        await databaseReference.child(userId).child(uuid.v1()).set(audioTrack.toJson());
        print(audioTrack.toString() + " is added to firebase");
      }catch(e){
        print(e.toString());
      }
    }
  }

}
