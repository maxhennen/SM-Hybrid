import 'package:flutter/cupertino.dart';

class Channel {
  Color color;
  String name;
  String id;
  int amountOfListeners;


  Channel(this.color, this.name, this.id, this.amountOfListeners);

  Channel.empty();
}
