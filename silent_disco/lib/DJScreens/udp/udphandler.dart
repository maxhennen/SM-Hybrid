import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:silent_disco/ChannelSoundPage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:dio/dio.dart';

import 'nanoid.dart';

class UDPHandler {
  static String id;

  static void connect(Uint8List bytes) async {
//    id = nanoid();
//    var codec = new Utf8Codec();
//    List<int> dataToSend = codec.encode(jsonEncode(bytes.sublist(0, 63999)));
//    print(dataToSend.length);
//    var addressesIListenFrom = InternetAddress.anyIPv4;
//    int portIListenOn = 0; //0 is random
//
//
//    RawDatagramSocket.bind(addressesIListenFrom, portIListenOn)
//        .then((RawDatagramSocket udpSocket) {
//      udpSocket.broadcastEnabled = true;
//      udpSocket.send(dataToSend, new InternetAddress("localhost"), 50005);
//      print('Did send data on the stream..');
//    });

    var DESTINATION_ADDRESS = InternetAddress("145.93.33.77");

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
      udpSocket.listen((e) {
        Datagram dg = udpSocket.receive();
        if (dg != null) {
          print("received ${dg.data}");
        }
      });
      var codec = new Utf8Codec();
      var data = List<int>.from(bytes);

      while (data.isNotEmpty) {
        int maxlength = 10000;
        if(data.length > maxlength) {
          List<int> dataToSend = codec.encode(
              jsonEncode(data.sublist(0, maxlength)));
          data.removeRange(0, maxlength);
          udpSocket.send(dataToSend, DESTINATION_ADDRESS, 50005);
          print(data.length);
        } else {
          List<int> dataToSend = codec.encode(
              jsonEncode(data));
          udpSocket.send(dataToSend, DESTINATION_ADDRESS, 50005);
          data.clear();
        }
      }
      if (data.isEmpty) {
        udpSocket.send(codec.encode("STOP!"), DESTINATION_ADDRESS, 50005);
        print("Finish!");
      }
    });
  }
}
