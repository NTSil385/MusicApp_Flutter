import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/album_page/info_album.dart';
import 'package:login_register/pages/home_page.dart';
import 'package:login_register/storage/played_playlist.dart';
import '../Widget/back_button.dart';



class Album extends StatefulWidget {
  const Album({super.key});

  @override
  State<Album> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<Album> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future getdata() async {
    if (currentUser != null && currentUser!.email != null) {
      QuerySnapshot qn = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.email)
          .collection('Albums')
          .get();
      return qn.docs;
    }
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
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: backButton(
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => indexPageHome()));
                            }),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // Sử dụng .data() thay vì .data
                        Map<String, dynamic> AlbumName = snapshot.data[index].data();
                        Map<String, dynamic> AlbumImage = snapshot.data[index].data();

                        for (var key in AlbumName.keys) {
                          var value = AlbumName[key];
                          print('Key: $key, Value: $value');
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>infoAlbum(
                                    album_name:AlbumName["album_name"],
                                    imageUrl: AlbumImage["url_imgAlbum"],

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
                                    borderRadius: BorderRadius.circular(4),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff69AFF5),
                                          Color(0xffFFC7E0),
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
                                        child: Image.network(AlbumImage["url_imgAlbum"], fit: BoxFit.cover),
                                      ),
                                      const SizedBox(width: 15,),
                                      Text(AlbumName["album_name"],
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
                ],
              );
            }
          },
        ),
      ),
    );
  }

}

