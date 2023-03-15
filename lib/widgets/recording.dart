// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:major_try/data/globals.dart' as globals;
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

// class Recorder extends StatefulWidget {
//   const Recorder({super.key});

//   @override
//   State<Recorder> createState() => _RecorderState();
// }

// class _RecorderState extends State<Recorder> {
//   final recorder = FlutterSoundRecorder();
//   bool isRecorderReady = false;

//   String audioFilePath = "";

//   @override
//   void initState() {
//     super.initState();
//     initRecorder();
//   }

//   @override
//   void dispose() {
//     recorder.closeRecorder();
//     super.dispose();
//   }

//   Future initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted.';
//     }
//     await recorder.openRecorder();
//     isRecorderReady = true;
//   }

//   Future startRecording() async {
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final appDocPath = '${appDocDir.path}/flutter_sound.mp4';
//     if (!isRecorderReady) return;
//     await recorder.startRecorder(toFile: appDocPath, codec: Codec.aacMP4);
//   }

//   Future stopRecording() async {
//     if (!isRecorderReady) return;
//     final path = await recorder.stopRecorder();
//     final audioFile = File(path!);
//     audioFilePath = audioFile.path;
//     print('Recorded audio: $audioFile');
//     globals.asr_file_path = audioFilePath;
//   }

//   Future sendData() async {}

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: recorder.isRecording
//           ? const Icon(
//               Ionicons.stop_circle_outline,
//               color: Colors.purple,
//               size: 70,
//             )
//           : const Icon(
//               Ionicons.mic_circle,
//               color: Colors.purple,
//               size: 50,
//             ),
//       onPressed: () async {
//         if (recorder.isRecording) {
//           await stopRecording();
//           setState(() {});
//           await sendData();
//         } else {
//           await startRecording();
//         }
//         setState(() {});
//       },
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:major_try/data/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/functions.dart';

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;

  String _audioFilePath = "";

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted.';
    }
    // await _recorder.openRecorder();
    // _isRecording = true;
  }

  Future _startRecording() async {
    await _recorder.openRecorder();
    await _recorder.startRecorder(toFile: _audioFilePath, codec: Codec.aacMP4);
    setState(() {
      _isRecording = true;
    });
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final appDocPath = '${appDocDir.path}/flutter_sound.mp4';
    // if (!_isRecording) return;
    // await recorder.startRecorder(toFile: appDocPath, codec: Codec.aacMP4);
  }

  Future _stopRecording() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    setState(() {
      _isRecording = false;
    });

    globals.asr_file_path = _audioFilePath;

    // if (!isRecording) return;
    // final path = await recorder.stopRecorder();
    // final audioFile = File(path!);
    // audioFilePath = audioFile.path;
    // print('Recorded audio: $audioFile');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) async {
        if (_isRecording) {
          return;
        }
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        String fileName = 'flutter_sound.mp4';
        String filePath = '$appDocPath/$fileName';
        setState(() {
          _audioFilePath = filePath;
        });
        _startRecording();
      },
      onLongPressEnd: (details) {
        if (!_isRecording) {
          return;
        }
        _stopRecording();
        globals.need_transcription = true;
      },
      child: Icon(
        Icons.mic,
        size: 50.0,
        color: _isRecording ? Colors.red : Colors.grey,
      ),
    );

    // IconButton(
    //   icon: recorder.isRecording
    //       ? const Icon(
    //           Ionicons.stop_circle_outline,
    //           color: Colors.purple,
    //           size: 70,
    //         )
    //       : const Icon(
    //           Ionicons.mic_circle,
    //           color: Colors.purple,
    //           size: 50,
    //         ),
    //   onPressed: () async {
    //     if (recorder.isRecording) {
    //       await stopRecording();
    //       setState(() {});
    //       await sendData();
    //     } else {
    //       await startRecording();
    //     }
    //     setState(() {});
    //   },
    // );
  }
}
