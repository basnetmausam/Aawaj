import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import 'package:major_try/data/globals.dart' as globals;

Future sendData() async {
  var audioFile = File(globals.asr_file_path);
  var url = Uri.parse("${globals.url}/asr");
  var request = http.MultipartRequest("POST", url);
  print("yaa chuuu");
  if (audioFile != null) {
    print("true");
    print(audioFile.path);
    request.files.add(
      http.MultipartFile(
        'file',
        audioFile.readAsBytes().asStream(),
        audioFile.lengthSync(),
        filename: "audio.mp4",
        contentType: MediaType.parse("audio/mp4"),
      ),
    );
  }
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);

  final resJson = jsonDecode(res.body);
  var message = resJson["message"];
  print(message);
  // setState(() {});
}
