// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dj-sign-in.dart';

void main() {
  runApp(MaterialApp(
    title: 'Silent Disco',
  ));
}

class HomeScreen extends StatelessWidget {
  //Stateless = immutable = cannot change object's properties
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    //Now we need multiple widgets into a parent = "Container" widget
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(10.0),//Top, Right, Bottom, Left
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new Text("Silent disco",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      )),
                ),
                //Need to add space below this Text ?
              ],
            ),
          ),
        ],
      ),
    );
    Widget buildButton(Icon icon, String buttonTitle, Widget screen) {
      return new FlatButton.icon(onPressed: () {
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>
            screen)
        );      }, icon: icon, label: Text(buttonTitle));
    }
    Widget buttonsSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //build in a separated function
          new Container(child: new Text("Are you a "),),
          buildButton(new Icon(Icons.headset_mic), "DJ", new DjSignIn()),
          new Container(child: new Text("or a "),),
          buildButton(new Icon(Icons.headset), "Listener", null),
        ],
      ),
    );
    //build function returns a "Widget"
    return new MaterialApp(
      title: "",
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Flutter App'),
          ),
          body: new ListView(
            children: <Widget>[
              //You can add more widget bellow
              titleSection,
              buttonsSection,
            ],
          )
      ),
    );//Widget with "Material design"
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }
}

//class RandomWordsState extends State<RandomWords> {
//  // TODO Add build() method
//  final List<WordPair> _suggestions = new List<WordPair>();
//  final Set<WordPair> _saved = Set<WordPair>();
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Startup Name Generator'),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
//        ]
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//
//  void _pushSaved(){
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        builder: (BuildContext context) {
//          final Iterable<ListTile> tiles = _saved.map(
//                  (WordPair pair) {
//                return ListTile(
//                  title: Text(
//                    pair.asPascalCase,
//                    style: _biggerFont,
//                  ),
//                );
//              }
//          );
//          final List<Widget> divided = ListTile
//              .divideTiles(
//            context: context,
//            tiles: tiles,
//          )
//              .toList();
//          return Scaffold(
//            appBar: AppBar(
//              title: Text('Saved Suggestions'),
//            ),
//            body: ListView(children: divided),
//          );
//        },
//      ),
//    );
//  }
//
//  Widget _buildSuggestions() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemBuilder: /*1*/ (context, i) {
//          if (i.isOdd) return Divider(); /*2*/
//
//          final index = i ~/ 2; /*3*/
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final bool alreadySaved = _saved.contains(pair);
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      trailing: Icon(   // Add the lines from here...
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
//      onTap:(){
//        setState(() {
//          if(alreadySaved) {
//            _saved.remove(pair);
//          }else{
//            _saved.add(pair);
//          }
//        });
//      }
//    );
//  }
//}
//
//class RandomWords extends StatefulWidget {
//  @override
//  RandomWordsState createState() => RandomWordsState();
//}
