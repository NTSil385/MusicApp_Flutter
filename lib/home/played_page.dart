
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  String? song_name, artist_name, imageUrl, audioUrl, lyric;

  playedPage({
    super.key,
    this.song_name,
    this.artist_name,
    this.imageUrl,
    this.audioUrl,
    this.lyric
  });

  @override
  State<playedPage> createState() => _songPlayedState();
}

class _songPlayedState extends State<playedPage> {
  AudioPlayer _audioPlayer = AudioPlayer();




  @override
  void initState() {
    super.initState();
    _init();
    // initNotification();
    _audioPlayer = AudioPlayer();
    final List<AudioSource> myPlaylist = [
      AudioSource.uri(
        Uri.parse(widget.audioUrl.toString()),
        tag: MediaItem(
          id: "1",
          album: "Songs",
          title: widget.song_name.toString(),
          artist: widget.artist_name.toString(),
          artUri: Uri.parse(widget.imageUrl.toString()),
        ),
      ),
      // Thêm các đối tượng AudioSource khác tương tự
    ];
    _audioPlayer.setLoopMode(LoopMode.all);
     _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: myPlaylist,
      ),
      initialIndex: 0,
      preload: true,
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
              (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration ?? Duration.zero));

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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50.0,),
                Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    backButton(
                        onClick: () {
                          Navigator.pop(context);
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
                ),
                SizedBox(
                  width: 300,
                  child: StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return LyricsWidget(lyrics: widget.lyric.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class MediaMetadata extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;

  const MediaMetadata({super.key,
    required this.imageUrl,
    required this.title,
    required this.artist
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              boxShadow:const [ BoxShadow(
                color:  Colors.black12,
                offset: Offset(2,  4),
                blurRadius: 4,
              ),
              ],
              borderRadius:  BorderRadius.circular(10)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 8,),
        Text(
          artist,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )
      ],
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
class LyricsWidget extends StatelessWidget {
  final String lyrics;

  LyricsWidget({required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Text(
          lyrics,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}