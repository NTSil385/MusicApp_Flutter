import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_register/artist_channel/artist_showAlbums.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/profile/showplaylist.dart';

import '../Widget/back_button.dart';

import 'played_page.dart';

String? song_name, image, audio, artist, value,lyric;

class showArtist extends StatefulWidget {
  final String artist_name;
  final String imageUrl;
  final String email;

  const showArtist({
    Key? key,
    required this.artist_name,
    required this.imageUrl,
    required this.email,
  }) : super(key: key);

  @override
  State<showArtist> createState() => _showArtistState();
}

class _showArtistState extends State<showArtist> {

  final User? currentUser = FirebaseAuth.instance.currentUser;


  List<String> _selectedItems = [];
  List<String> albumNames = [];
  Future<List<String>> getPlaylist() async {

    
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .collection('Playlist')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (data.containsKey("playlist_name")) {
        albumNames.add(data["playlist_name"] as String);
      }

    }
    print(albumNames);
    print(currentUser!.email);
    return albumNames;
  }


  void _showPlaylist() async {
    final List<String> items = albumNames;

    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context){
          return MutltSelect(items: items);
        });
    if(results != null){
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPlaylist();

  }

  Future getSongs() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.email)
        .collection('songs').orderBy('song_name', descending: true)
        .get();
    return qn.docs;
  }

  Future getAlbums() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.email)
        .collection('Albums')
        .get();
    return qn.docs;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xff0B1223),
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
                  const TabBar(
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
                              return const Center(
                                child: Text("No songs available."),
                              );
                            } else {
                              return ValueListenableBuilder(
                                valueListenable: Hive.box('favorites').listenable(),
                                builder: (context, box, child){
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
                                      Map<String, dynamic> lyricData = snapshot.data[index].data();
                                      String songId = songData["song_name"];
                                      bool status = songData['status'];
                                      final isFavorite = box.get(songData["song_name"]) != null;
                                      return InkWell(
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
                                                  SizedBox(
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
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        if (isFavorite) {
                                                          await box.delete(songData["song_name"]);
                                                          await FirebaseFirestore.instance
                                                              .collection('Users')
                                                              .doc(currentUser!.email)
                                                              .collection('Favorite')
                                                              .doc(songData["song_name"])
                                                              .delete();

                                                        } else {
                                                          await box.put(songData["song_name"], status);
                                                          await FirebaseFirestore.instance
                                                              .collection('Users')
                                                              .doc(currentUser!.email)
                                                              .collection('Favorite')
                                                              .doc(songData["song_name"])
                                                              .set({
                                                            'song_name': songData["song_name"],
                                                            'imageUrl': DataImage["imageUrl"],
                                                            'audioUrl': DataAudio["audioUrl"],
                                                            'artist_name': artistData["artist_name"],
                                                            'lyrics': lyricData['lyrics'],
                                                            'value': false,
                                                          });
                                                        }
                                                      },
                                                      icon:  isFavorite ?? false
                                                          ? const Icon(Icons.favorite, color:Colors.red)
                                                          : const Icon(Icons.favorite_border),
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: const BoxDecoration(
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
                                                                lyric: lyricData["lyrics"],
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
                                                      song_name = songData["song_name"];
                                                      image =DataImage["imageUrl"];
                                                      audio = DataAudio["audioUrl"];
                                                      artist = artistData["artist_name"];
                                                      lyric =  lyricData["lyrics"];
                                                      _showPlaylist();
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
                              return const Center(
                                child: Text("No songs available."),
                              );
                            } else {
                              return SizedBox(
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
                                            builder: (context)=>artistshowAlbum(
                                              album_name:AlbumName["album_name"],
                                              imageUrl: AlbumImage["url_imgAlbum"],
                                              email: widget.email,
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
                                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                width: 210,
                                                height: 260,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(5),
                                                      child: ClipRRect(
                                                        borderRadius:BorderRadius.circular(10),
                                                        child: Image.network(AlbumImage["url_imgAlbum"], fit: BoxFit.cover, height: 200,
                                                          width: 200.0,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Container(
                                                      padding: const EdgeInsets.all(10),
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
                          child: const Center(
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
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: backButton(
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MutltSelect extends StatefulWidget {
  final List<String> items;
  const MutltSelect({required this.items,super.key});

  @override
  State<MutltSelect> createState() => _MutltSelectState();
}

class _MutltSelectState extends State<MutltSelect> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if(isSelected){
        _selectedItems.add(itemValue);
      }else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() async {
    Navigator.pop(context, _selectedItems);
    print(_selectedItems);
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .collection('Playlist')
        .doc(_selectedItems.toString())
        .collection(_selectedItems.toString())
        .doc(song_name)
        .set(
        {
          'song_name': song_name,
          'imageUrl': image,
          'audioUrl': audio,
          'artist_name': artist,
          'lyrics': lyric
        });

    await FirebaseFirestore.instance
        .collection("Playlist")
        .doc(currentUser!.email)
        .collection(_selectedItems.toString())
        .doc(song_name)
        .set(
        {
          'song_name': song_name,
          'imageUrl': image,
          'audioUrl': audio,
          'artist_name': artist,
          'lyrics': lyric
        });


  }

  void create() async {
    // Navigator.pop(context, _selectedItems);
    print(_selectedItems);
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .collection('Playlist')
        .doc('[$song_name]')
        .set({
        'playlist_name' : song_name,
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .collection('Playlist')
        .doc('[$song_name]')
        .collection('[$song_name]')
        .doc('[$song_name]')
        .set(
        {
          'song_name': song_name,
          'imageUrl': image,
          'audioUrl': audio,
          'artist_name': artist,
          'lyrics': lyric,
        });

    await FirebaseFirestore.instance
        .collection("Playlist")
        .doc(currentUser!.email)
        .collection('[$song_name]')
        .doc(song_name)
        .set({
      'playlist_name' : song_name,
    });

    await FirebaseFirestore.instance
        .collection("Playlist")
        .doc(currentUser!.email)
        .collection('[$song_name]')
        .doc(song_name)
        .set(
        {
          'song_name': song_name,
          'imageUrl': image,
          'audioUrl': audio,
          'artist_name': artist,
          'lyrics':lyric
        }).whenComplete(() =>Navigator.push(context,
        MaterialPageRoute(builder: (context) => const showPlaylist())));

  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Please Choose One'),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.items.map((item) => CheckboxListTile(
                value: _selectedItems.contains(item),
                title: Text(item),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (isChecked) => _itemChange(item, isChecked!)
            )).toList(),
          ),


        ),
        actions: [
          TextButton(onPressed: _cancel, child: const Text('Cancel',
              style: TextStyle(
                color: Colors.red,
              ),)),
          ElevatedButton(onPressed: _submit, child: const Text('Submit')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent
              ),
              onPressed: create, child: const Text('Create',
          style: TextStyle(
            color: Colors.white
          ),
          )),
        ]

    );
  }
}
