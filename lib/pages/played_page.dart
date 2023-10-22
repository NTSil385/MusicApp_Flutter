
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../Widget/back_button.dart';

class playedPage extends StatefulWidget {
  String? song_name, artist_name, imageUrl, audioUrl;

  playedPage({
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
    _audioPlayer = AudioPlayer()..setUrl(widget.audioUrl!);

    // _audioPlayer.positionStream;
    // _audioPlayer.bufferedPositionStream;
    // _audioPlayer.durationStream;
  }



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
              SizedBox(height: 50.0,),
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
              SizedBox(height: 20.0,),
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Image.network(
                  widget.imageUrl!, fit: BoxFit.cover, width: 300,height: 300,
              )),
          ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: 300,
                height: 100,
                decoration: BoxDecoration(
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
                icon: Icon(Icons.skip_previous_rounded)),
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
                        icon: Icon(Icons.play_arrow_rounded));
                  }else if(processingState != ProcessingState.completed){
                    return IconButton(
                        onPressed: audioPlayer.pause,
                        iconSize: 80,
                        color: Colors.black,
                        icon: Icon(Icons.pause_rounded)
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
                icon: Icon(Icons.skip_next_rounded)),
          ],
        ),]
      ),
    );
  }
}