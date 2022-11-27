import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

var httpClient = new HttpClient();
Future<File> downloadFile(String url, String filename) async {
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

// url = 'http://10.0.2.2:5000/api?query=' + value.toString();
// data = await downloadFile(url, filename: "speech.wav");