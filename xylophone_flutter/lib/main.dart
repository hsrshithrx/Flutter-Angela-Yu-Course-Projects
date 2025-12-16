import 'package:flutter/material.dart';

import 'package:assets_audio_player_updated/assets_audio_player.dart';

void main() {
  runApp(XylophoneApp());
}


class XylophoneApp extends StatelessWidget {


  void playSound(int soundNumber){
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/audio/note$soundNumber.wav"),
    );

  }

  Expanded buildKey(Color color, int soundNumber){
    return Expanded(
      child : TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color, // Sets the background color
            foregroundColor: color,

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),// Sets the text (foreground) color
          ),

          onPressed: (){
            playSound(soundNumber);
          },
          child: Text('TextButton')
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildKey(Colors.red, 1),
            buildKey(Colors.orange, 2),
            buildKey(Colors.yellow, 3),
            buildKey(Colors.green, 4),
            buildKey(Colors.blue, 5),
            buildKey(Colors.indigo, 6),
            buildKey(Colors.purple, 7),



          ]
        ),
        ),
      ),
    );
  }
}