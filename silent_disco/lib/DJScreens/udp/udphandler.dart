import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'nanoid.dart';

class UDPHandler {
  static RawDatagramSocket socket;
  static String id;

  static void connect(String address, int port, Uint8List bytes, Function callback,
      Function callbackForGrid) async{
    id = nanoid();
    var codec = new Utf8Codec();
    List<int> dataToSend = codec.encode(jsonEncode(bytes.sublist(0, 63999)));
    print(dataToSend.length);
    var addressesIListenFrom = InternetAddress.anyIPv4;
    int portIListenOn = 0; //0 is random
    RawDatagramSocket.bind(addressesIListenFrom, portIListenOn)
        .then((RawDatagramSocket udpSocket) {
      socket = udpSocket;
      udpSocket.send(dataToSend, new InternetAddress(address), port);
      print('Did send data on the stream..');
    });

  }

//  static bool isReset(List<List<int>> grid) {
//    bool isReset = true;
//    for (int i = 0; i < 3; i++) {
//      for (int j = 0; j < 3; j++) {
//        if(grid[i][j]!=0){
//          isReset=false;
//        }
//      }
//    }
//    return isReset;
//  }
//
//  static sendGrid(Map dataRw) {
//    var data = dataRw;
//    data["id"] = id;
//    print("sending id ${id}");
//    var codec = new Utf8Codec();
//    List<int> dataToSend = codec.encode(jsonEncode(data));
//    socket.send(dataToSend, new InternetAddress(address), port);
//  }
}