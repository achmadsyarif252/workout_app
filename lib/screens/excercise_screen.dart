import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../screens/excersize_hub.dart';

class ExcerciseScreen extends StatefulWidget {
  final Exercises? exercises;
  final int? seconds;

  ExcerciseScreen({this.exercises, this.seconds});
  @override
  _ExcerciseScreenState createState() => _ExcerciseScreenState();
}

class _ExcerciseScreenState extends State<ExcerciseScreen> {
  bool? _isCompleted;
  int _elapsedSeconds = 0;

  Timer? timer;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  void playAudio() {
    audioCache.play('cheering.wav');
  }

  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          t.cancel();
          setState(() {
            _isCompleted = true;
          });
          playAudio();
        }
        setState(() {
          _elapsedSeconds = t.tick;
        });
      },
    );
    super.initState();
  }

  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.exercises!.gif,
              placeholder: (context, url) => Image(
                image: AssetImage("assets/logo_foreground.png"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.topCenter,
                    child: Text('$_elapsedSeconds/${widget.seconds} S'),
                  ),
                )
              : Container(),
          SafeArea(
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ],
      ),
    );
  }
}
