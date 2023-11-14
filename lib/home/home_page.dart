import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login_register/home/searchPage.dart';
import 'package:login_register/home/show_artist.dart';
import 'package:login_register/profile/profile_page.dart';
import 'package:login_register/home/show_album.dart';

import 'played_page.dart';




class indexPageHome extends StatefulWidget {
  const indexPageHome({super.key});

  @override
  State<indexPageHome> createState() => _indexPageHometate();
}

class _indexPageHometate extends State<indexPageHome> {
  int currenrIndex = 0;
  List tabs = [
    const HomePage(),
    const searchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor:  const Color(0xff2c3d5b),
        animationDuration: const Duration(milliseconds: 300),
        items:const [
          ImageIcon(
            AssetImage('assets/image/Home.png'),
          ),
          Icon(Icons.search),
          Icon(Icons.person)
        ],
        onTap: (index){
          setState(() {
            currenrIndex = index;
          });
        },
      ),
      body: tabs[currenrIndex],
    );
  }
}





class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int myCurrentIndex = 0;


  Future getdata() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('songs')
        .get();
    return qn.docs;
  }

  Future getArtist() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .get();
    return qn.docs;
  }

  Future getAlbum() async {

    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Albums')
        .get();
    return qn.docs;

  }



  @override
  Widget build(BuildContext context) {
    int index = 1;
    final items = <Widget>[
      const ImageIcon(
        AssetImage('assets/image/Home.png'),
      ),
      const Icon(Icons.search),
      const Icon(Icons.person)
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff1d2846),
                Color(0xff2c3d5b),
              ])
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child:const  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(AssetImage('assets/image/LOGO.png'), size: 100, color: Colors.white,),
                      Row(
                        children: [
                          Icon(Icons.notifications, size: 30,color: Colors.white,),
                          SizedBox(width: 10),
                          Icon(Icons.settings, size: 30,color: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20,),
                              Text('Recenty played',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.hasData ? min(10, snapshot.data.length) : 0,
                              itemBuilder: (context, index) {
                                // Sử dụng .data() thay vì .data
                                Map<String, dynamic> songData = snapshot.data[index].data();
                                Map<String, dynamic> DataImage = snapshot.data[index].data();
                                Map<String, dynamic> DataAudio = snapshot.data[index].data();
                                Map<String, dynamic> artisData = snapshot.data[index].data();
                                return
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => playedPage(
                                              song_name: songData["song_name"],
                                              imageUrl: DataImage["imageUrl"],
                                              audioUrl: DataAudio["audioUrl"],
                                              artist_name: artisData["artist_name"],
                                            ),
                                          ));
                                        },
                                        child: Container(
                                          width: 300,
                                          height: 70,
                                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: ClipOval(
                                                  child: Image.network(DataImage["imageUrl"], fit: BoxFit.cover, height: 60,
                                                    width: 60.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              SizedBox(
                                                width: 200,
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
                                        ),
                                      ),
                                    ],
                                  );
                              },
                            ),
                          ),

                        ],
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: getArtist(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20,),
                              Text('Popular Artists',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.hasData ? min(10, snapshot.data.length) : 0,
                              itemBuilder: (context, index) {
                                // Sử dụng .data() thay vì .data
                                Map<String, dynamic> avtData = snapshot.data[index].data();
                                Map<String, dynamic> username = snapshot.data[index].data();
                                Map<String, dynamic> email = snapshot.data[index].data();
                                Map<String, dynamic> role = snapshot.data[index].data();
                                bool checkrole = role['role'];
                                if(checkrole == true){
                                  return
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>showArtist(
                                                  artist_name:username["username"],
                                                  imageUrl: avtData["avt"],
                                                  email: email['email']
                                                )
                                            )
                                            );
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  child: ClipOval(
                                                    child: Image.network(avtData["avt"], fit: BoxFit.cover, height: 150,
                                                      width: 150.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                }else {
                                  return Container();
                                }

                              },
                            ),
                          ),

                        ],
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: getAlbum(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20,),
                              Text('Trending Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.hasData ? min(10, snapshot.data.length) : 0,
                              itemBuilder: (context, index) {
                                // Sử dụng .data() thay vì .data
                                Map<String, dynamic> albumName = snapshot.data[index].data();
                                Map<String, dynamic> urlImgalbum = snapshot.data[index].data();
                                return
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>showAlbum(
                                                album_name:albumName["album_name"],
                                                imageUrl: urlImgalbum["url_imgAlbum"],

                                              )
                                          )
                                          );
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 250,
                                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            border:Border.all(color: Colors.grey, width: 2),
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: ClipRRect(
                                                  borderRadius:BorderRadius.circular(10),
                                                  child: Image.network(urlImgalbum["url_imgAlbum"], fit: BoxFit.cover, height: 200,
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
                                                    albumName["album_name"],
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
                                      ),
                                    ],
                                  );
                              },
                            ),
                          ),

                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

}