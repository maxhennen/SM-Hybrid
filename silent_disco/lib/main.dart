import 'package:flutter/material.dart';
import 'package:silent_disco/DjSignInScreen.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),

      ),
      body:
            new Center(
              child:
              new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Are you a DJ?"
                    ),
                    new IconButton(
                      icon: const Icon(Icons.insert_emoticon),
                      onPressed:djButtonPressed,
                      iconSize: 48.0,
                      color: const Color(0xFF000000),
                    ),
                    new Divider(color: Colors.black),
                    new Text(
                        "Or a Listener?"
                    ),
                    new IconButton(
                      icon: const Icon(Icons.insert_emoticon),
                      onPressed:listenerButtonPressed,
                      iconSize: 48.0,
                      color: const Color(0xFF000000),
                    )
                  ]

              ),

            )

      );
  }

  void listenerButtonPressed(){

  }

  void djButtonPressed(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DjSignInScreen()),
    );
  }

}