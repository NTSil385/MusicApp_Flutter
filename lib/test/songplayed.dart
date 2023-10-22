
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class songPlayed extends StatefulWidget {
   String? song_name, artist_name, imageUrl, audioUrl;

  songPlayed({
      this.song_name,
      this.artist_name,
      this.imageUrl,
      this.audioUrl,
  });



  @override
  State<songPlayed> createState() => _songPlayedState();
}

class _songPlayedState extends State<songPlayed> {
  final player = AudioPlayer();


  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Played App'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Text(widget.song_name!,
            style: TextStyle(
              fontSize: 30
            ),
            ),
            SizedBox(height: 20,),
            Text(widget.artist_name!,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Card(
              child: Image.network(widget.imageUrl!,height: 300.0, width: 300,),
              elevation: 10.0,
            ),
            Row(
              children: [
                SizedBox(width: 100,),
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        playAudioFromUrl(widget.audioUrl!);
                      },
                      child: Icon(Icons.play_arrow),
                    )),
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        player.stop();
                      },
                      child: Icon(Icons.stop_rounded),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

