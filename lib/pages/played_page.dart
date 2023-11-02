
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../Widget/back_button.dart';



class PositionData{

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class playedPage extends StatefulWidget {
  String? song_name, artist_name, imageUrl, audioUrl;

  playedPage({super.key, 
    this.song_name,
    this.artist_name,
    this.imageUrl,
    this.audioUrl,
  });



  @override
  State<playedPage> createState() => _songPlayedState();
}

class _songPlayedState extends State<playedPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    initNotification();
    _audioPlayer = AudioPlayer()..setUrl(widget.audioUrl!);
    _init();
    // _audioPlayer.positionStream;
    // _audioPlayer.bufferedPositionStream;
    // _audioPlayer.durationStream;
  }

  Future<void> initNotification() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.myapp.channel.audio', // Thay đổi channel ID
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }


  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_audioPlayer as AudioSource);
  }



  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
              (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero));



  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  // Future<void> playAudioFromUrl(String url) async {
  //   await player.play(UrlSource(url));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d2846),
              Color(0xff2c3d5b),
            ])
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50.0,),
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  backButton(
                      onClick: () {
                        Navigator.of(context).pushNamed(
                            '/storage');
                      }),
                  const SizedBox(width: 100,),
                  const Text('Now Playing',
                    style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Text(widget.song_name!,
                style: const TextStyle(
                    fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),

              Text(widget.artist_name!,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
          const SizedBox(height: 50,),
          Container(
            decoration: BoxDecoration(
              border:Border.all(color: Colors.grey, width: 2),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Image.network(
                  widget.imageUrl!, fit: BoxFit.cover, width: 300,height: 300,
              )),
          ),
              const SizedBox(height: 10,),
              SizedBox(
                width: 300,
                child: StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot){
                      final positionData = snapshot.data;
                      return ProgressBar(
                        barHeight: 8,
                        baseBarColor: Colors.white,
                        bufferedBarColor: Colors.grey[300],
                        progressBarColor: const Color(0xff69AFF5),
                        thumbColor:  const Color(0xff69AFF5),
                        timeLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        buffered: positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,);
                    }),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: 300,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Controls(audioPlayer: _audioPlayer)
            ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer
  });
  final AudioPlayer audioPlayer;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children:[
          const SizedBox(height: 20,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: audioPlayer.seekToPrevious,
                iconSize: 60,
                color: Colors.black,
                icon: const Icon(Icons.skip_previous_rounded)),
            StreamBuilder(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot){
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if(!(playing ?? false)){
                    return IconButton(
                        onPressed: audioPlayer.play,
                        iconSize: 80,
                        color: Colors.black,
                        icon: const Icon(Icons.play_arrow_rounded));
                  }else if(processingState != ProcessingState.completed){
                    return IconButton(
                        onPressed: audioPlayer.pause,
                        iconSize: 80,
                        color: Colors.black,
                        icon: const Icon(Icons.pause_rounded)
                    );
                  }
                  return const Icon(
                    Icons.play_arrow_rounded,
                    size: 80,
                    color: Colors.black,
                  );
                }),
            IconButton(
                onPressed: audioPlayer.seekToNext,
                iconSize: 60,
                color: Colors.black,
                icon: const Icon(Icons.skip_next_rounded)),

          ],
        ),]
      ),
    );
  }
}