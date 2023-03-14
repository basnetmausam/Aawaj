// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:major_try/widgets/recording.dart';
import 'package:major_try/widgets/seekbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/routes.dart';
import 'package:major_try/data/globals.dart' as globals;

import 'package:flutter_sound/flutter_sound.dart' hide PlayerState;
import 'package:path_provider/path_provider.dart';

class MyPlayer extends StatefulWidget {
  String _sentence = "";

  MyPlayer(String sentence, {super.key}) {
    _sentence = sentence.trim();
  }

  @override
  _MyPlayerState createState() => _MyPlayerState(_sentence);
}

class _MyPlayerState extends State<MyPlayer> with WidgetsBindingObserver {
  // final recorder = FlutterSoundRecorder();
  String _audioFilePath = '';

  String _sentence = "";

  _MyPlayerState(String sentence) {
    _sentence = sentence;
  }

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // initRecorder();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permission not granted.';
  //   }
  //   await recorder.openRecorder();
  // }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    // Try to load audio from a source and catch any errors.
    try {
      //bypassing the ngrok warning with header
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse('${globals.url}/api?query=$_sentence')));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // recorder.closeRecorder();
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  Future startRecording() async {
    // await recorder.startRecorder();

    // try {
    //   await _recorder.openRecorder();
    //   await _recorder.startRecorder(toFile: _audioFilePath);
    //   setState(() {
    //     _isRecording = true;
    //   });
    // } catch (e) {
    //   print('Error starting recording: $e');
    // }
  }

  Future stopRecording() async {
    // await recorder.stopRecorder();
    // try {
    //   await _recorder.stopRecorder();
    //   await _recorder.closeRecorder();
    //   setState(() {
    //     _isRecording = false;
    //   });
    //   print('Audio file saved to: $_audioFilePath');
    // } catch (e) {
    //   print('Error stopping recording: $e');
    // }
  }

  // Future<void> _saveAudioFile() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   String fileName = 'voice_temp`.m4a';
  //   String filePath = '$appDocPath/$fileName';
  //   File audioFile = File(_audioFilePath);
  //   await audioFile.copy(filePath);
  //   setState(() {
  //     _audioFilePath = filePath;
  //   });
  //   print('Audio file saved to: $_audioFilePath');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display play/pause button and volume/speed sliders.
              ControlButtons(_player),
              // Display seek bar. Using StreamBuilder, this widget rebuilds
              // each time the position, buffered position or duration changes.
              Text(
                _sentence,
                style: context.textTheme.bodyLarge,
              ).py12(),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
              const SizedBox(
                height: 300,
              ),
              const Recorder(),
              // ElevatedButton(
              //     onPressed: () async {
              //       if (recorder.isRecording) {
              //         await stopRecording();
              //       } else {
              //         await startRecording();
              //       }
              //       setState(() {});
              //     },
              //     child: Icon(
              //       recorder.isRecording ? Icons.stop : Icons.mic,
              //       size: 80,
              //     )),

              // GestureDetector(
              //   onLongPressStart: (details) async {
              //     if (_isRecording) {
              //       return;
              //     }
              //     Directory appDocDir =
              //         await getApplicationDocumentsDirectory();
              //     String appDocPath = appDocDir.path;
              //     String fileName =
              //         'record_temp.m4a';
              //     String filePath = '$appDocPath/$fileName';
              //     setState(() {
              //       _audioFilePath = filePath;
              //     });
              //     _startRecording();
              //   },
              //   onLongPressEnd: (details) {
              //     if (!_isRecording) {
              //       return;
              //     }
              //     _stopRecording();
              //     _saveAudioFile();
              //   },
              //   child: Icon(
              //     Icons.mic,
              //     size: 50.0,
              //     color: _isRecording ? Colors.red : Colors.grey,
              //   ),
              // ),
              const SizedBox(
                height: 100,
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.handsRoute);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(190, 50),
                    backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                child: const Text('Speak Again !'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.

        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Ionicons.play_outline),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Ionicons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Ionicons.arrow_redo_outline),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
      ],
    );
  }
}
