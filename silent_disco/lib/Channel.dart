import 'package:flutter/cupertino.dart';
import 'package:silent_disco/Song.dart';

class Channel {
  Color color;
  String name;
  String id;
  int amountOfListeners;
  Song currentlyPlayingSong;


  Channel(this.color, this.name, this.id, this.amountOfListeners, this.currentlyPlayingSong);

  Channel.empty();
}
