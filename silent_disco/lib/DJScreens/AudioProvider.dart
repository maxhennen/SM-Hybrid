
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

typedef void OnError(Exception exception);

class AudioProvider {
  String url;

  AudioProvider(String url) {
    this.url = url;
  }

  Future<Uint8List> loadFileBytes() async {
    Uint8List bytes;
    try {
      bytes = await readBytes(this.url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future<String> load(Uint8List bytes) async {

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');


    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      return file.path;
    }
    return '';
  }
}