import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:login_register/album_page/album.dart';
import 'package:login_register/album_page/edit_album.dart';
import 'package:login_register/album_page/played_album.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/home/played_ablumHome.dart';
import 'package:login_register/home/show_album.dart';
import 'package:rxdart/rxdart.dart';

import '../Widget/back_button.dart';
import '../storage/played_page.dart';
import '../storage/played_playlist.dart';

class showArtist extends StatefulWidget {
  final String artist_name;
  final String imageUrl;
  final String email;

  showArtist({
    Key? key,
    required this.artist_name,
    required this.imageUrl,
    required this.email,
  }) : super(key: key);

  @override
  State<showArtist> createState() => _showArtistState();
}

class _showArtistState extends State<showArtist> {
  @override
  void initState() {
    super.initState();
  }

  Future getSongs() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${widget.email}')
        .collection('songs')
        .get();
    return qn.docs;
  }

  Future getAlbums() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${widget.email}')
        .collection('Albums')
        .get();
    return qn.docs;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xff0B1223),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: ClipRRect(
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        width: 400,
                        height: 300,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Text(
                          widget.artist_name,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.music_note,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.album,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        FutureBuilder(
                          future: getSongs(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return Center(
                                child: Text("No songs available."),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> songData =
                                  snapshot.data[index].data() as Map<String, dynamic>;
                                  Map<String, dynamic> DataImage =
                                  snapshot.data[index].data() as Map<String, dynamic>;
                                  Map<String, dynamic> DataAudio =
                                  snapshot.data[index].data() as Map<String, dynamic>;
                                  Map<String, dynamic> artistData =
                                  snapshot.data[index].data() as Map<String, dynamic>;

                                  return InkWell(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => playedPage(
                                    //         song_name: songData["song_name"],
                                    //         imageUrl: DataImage["imageUrl"],
                                    //         audioUrl: DataAudio["audioUrl"],
                                    //         artist_name: artistData["artist_name"],
                                    //       ),
                                    //     ),
                                    //   );
                                    // },
                                    child: Container(
                                      width: 407,
                                      height: 70,
                                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[600],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(10),
                                                height: 50,
                                                width: 50.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Image.network(
                                                  DataImage["imageUrl"],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  songData["song_name"],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(

                                                child: IconButton(onPressed: (){
                                                },
                                                    icon: const Icon(Icons.favorite_outline
                                                      ,size: 30,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                ),
                                                child: ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => playedPage(
                                                            song_name: songData["song_name"],
                                                            imageUrl: DataImage["imageUrl"],
                                                            audioUrl: DataAudio["audioUrl"],
                                                            artist_name: artistData["artist_name"],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      shape: const CircleBorder(), //<-- SEE HERE
                                                      backgroundColor: Colors.black,
                                                    ),

                                                    child: const Icon(Icons.play_arrow_rounded)),
                                              ),
                                              Container(
                                                child: IconButton(onPressed: (){
                                                },
                                                    icon: const Icon(Icons.add_box_outlined
                                                      ,size: 25,
                                                      color: Colors.white,
                                                    )),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        FutureBuilder(
                          future: getAlbums(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return Center(
                                child: Text("No songs available."),
                              );
                            } else {
                              return Container(
                                height: 500,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> AlbumName = snapshot.data[index].data();
                                    Map<String, dynamic> AlbumImage = snapshot.data[index].data();

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>showAlbum(
                                              album_name:AlbumName["album_name"],
                                              imageUrl: AlbumImage["url_imgAlbum"],

                                            )
                                        )
                                        );
                                      },

                                      child:  Column(
                                        children: [
                                          const SizedBox(height: 30,),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                width: 210,
                                                height: 260,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: ClipRRect(
                                                        borderRadius:BorderRadius.circular(10),
                                                        child: Image.network(AlbumImage["url_imgAlbum"], fit: BoxFit.cover, height: 200,
                                                          width: 200.0,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      width: 200,
                                                      child: Center(
                                                        child: Text(
                                                          AlbumName["album_name"],
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          child: Center(
                            child: Text("Artist information goes here"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              child:   Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: backButton(
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
