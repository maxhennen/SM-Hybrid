import 'package:flutter/cupertino.dart';

class Song {
  String name;
  String id;
  int volume;
  double songLength;
  double transpiredTime;


  Song(this.name, this.id, this.volume, this.songLength, this.transpiredTime);

  Song.empty();
}
