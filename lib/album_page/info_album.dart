
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:login_register/album_page/edit_album.dart';
import 'package:login_register/album_page/played_album.dart';
import 'package:login_register/test/playled_album.dart';
import 'package:rxdart/rxdart.dart';

import '../Widget/back_button.dart';
import '../storage/played_page.dart';
import '../storage/played_playlist.dart';






class infoAlbum extends StatefulWidget {
  String? album_name,imageUrl;

  infoAlbum({
    super.key,
    this.album_name,
    this.imageUrl,
  });

  @override
  State<infoAlbum> createState() => _infoAlbumState();
}

class _infoAlbumState extends State<infoAlbum> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }


  Future getdata() async {
    if (currentUser != null && currentUser!.email != null) {
      QuerySnapshot qn = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.email)
          .collection('Albums')
          .doc('${widget.album_name}')
          .collection('${widget.album_name}')
          .get();
      return qn.docs;
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff053B50),
                Color(0xff176B87B1),
                Color(0xff64CCC564),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: backButton(
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                  '/Albums');
                            }),
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text('${widget.album_name}', style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>edit_AlbumPage(
                                  album_name: widget.album_name
                              )
                          )
                          );
                        },
                            icon: const Icon(Icons.edit
                                      ,size: 40,
                                      color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // Sử dụng .data() thay vì .data
                        Map<String, dynamic> songData = snapshot.data[index].data();
                        Map<String, dynamic> DataImage = snapshot.data[index].data();
                        Map<String, dynamic> DataAudio = snapshot.data[index].data();
                        Map<String, dynamic> artisData = snapshot.data[index].data();
                        // for (var key in songData.keys) {
                        //   var value = songData[key];
                        //   print('Key: $key, Value: $value');
                        // }
                        //
                        // List<String> playlist = [];
                        //
                        // for (var key in songData.keys) {
                        //   var value = songData[key];
                        //   if (key == "audioUrl") {
                        //     playlist.add(value);
                        //   }
                        //   if (key == "song_name") {
                        //     playlist.add(value);
                        //   }
                        //   if(key == "artist_name"){
                        //     playlist.add(value);
                        //   }
                        //   if (key == "imageUrl") {
                        //     playlist.add(value);
                        //   }
                        // }value



                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>playedPage(
                                    song_name:songData["song_name"],
                                    imageUrl: DataImage["imageUrl"],
                                    audioUrl: DataAudio["audioUrl"],
                                    artist_name: artisData["artist_name"],
                                  )
                              )
                              );
                            },
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  height: 70,
                                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  decoration:  BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff9BE8D8),
                                          Color(0xff78C1F3),
                                        ],
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 50,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.network(DataImage["imageUrl"], fit: BoxFit.cover),
                                      ),
                                      const SizedBox(width: 15,),
                                      Text(songData["song_name"],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>  playedAlbums(
                              album_name: widget.album_name,
                            ),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), //<-- SEE HERE
                          padding: const EdgeInsets.all(20),
                          backgroundColor: const Color(0xff2c3d5b),
                        ),

                        child: const Icon(Icons.play_arrow_rounded)),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

}

