import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> with TickerProviderStateMixin {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  Duration duration;
  Duration position;
  AnimationController animationController;

  void initState() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    duration = Duration();
    position = Duration();

    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Column(
        children: [
          Text(
            'Busy P',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 15),
          Text(
            'Dance And Ressurection',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15),
          Image.asset(
            'assets/images/home.jpg',
            height: 300,
          ),
          SizedBox(height: 25),
          Slider(
            onChanged: (value) {},
            value: 10,
            max: 100,
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 50,
                icon: Icon(
                  Icons.fast_rewind,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await audioPlayer.play(
                    'assets/audio/music.mp3',
                    isLocal: true,
                  );
                },
                iconSize: 50,
                icon: Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 50,
                icon: Icon(
                  Icons.fast_forward,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
