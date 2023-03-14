import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted.';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
  }

  Future startRecording() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = '${appDocDir.path}/flutter_sound.aac';
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: appDocPath, codec: Codec.aacADTS);
  }

  Future stopRecording() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    print('Recorded audio: $audioFile');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: recorder.isRecording
          ? const Icon(
              Ionicons.stop_circle_outline,
              color: Colors.purple,
              size: 70,
            )
          : const Icon(
              Ionicons.mic_circle,
              color: Colors.purple,
              size: 50,
            ),
      onPressed: () async {
        if (recorder.isRecording) {
          await stopRecording();
        } else {
          await startRecording();
        }
        setState(() {});
      },
    );
  }
}
