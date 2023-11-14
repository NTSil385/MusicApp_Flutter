import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/home/index_page.dart';
import 'package:login_register/home/played_ablumHome.dart';
import 'package:login_register/pages/index_profile.dart';
import 'package:login_register/home/played_page.dart';
import 'package:login_register/storage/played_playlist.dart';

import '../Widget/back_button.dart';



class showlistFav extends StatefulWidget {
  const showlistFav({super.key});

  @override
  State<showlistFav> createState() => _showlistFavPageState();
}

class _showlistFavPageState extends State<showlistFav> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future getdata() async {
  if(currentUser!=null && currentUser!.email !=null) {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('Favorite')
        .get();
    return qn.docs;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d2846),
              Color(0xff2c3d5b),
            ])
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
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: backButton(
                            onClick: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                       child: const Text('Library',style: TextStyle(
                         fontSize: 30,
                         fontWeight: FontWeight.bold,
                         color: Colors.white
                       ),),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  playedAlbumsHome(
                                  album_name: currentUser!.email,
                                  collection: 'Users',
                                  collection2: 'Favorite',
                                ),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(), //<-- SEE HERE
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.black,
                            ),

                            child: const Icon(Icons.play_arrow_rounded)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // Sử dụng .data() thay vì .data
                        Map<String, dynamic> songData = snapshot.data[index].data();
                        Map<String, dynamic> DataImage = snapshot.data[index].data();
                        Map<String, dynamic> DataAudio = snapshot.data[index].data();
                        Map<String, dynamic> artisData = snapshot.data[index].data();


                        return InkWell(
                          child: Container(
                            width: 400,
                            height: 90,
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            decoration:  BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xff78C1F3),
                                  Color(0xff574ADD),
                                ],
                                  begin: AlignmentDirectional.topCenter,
                                  end: Alignment.bottomCenter
                                ),
                              borderRadius: BorderRadius.circular(20),
                              ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          DataImage["imageUrl"],
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 150,
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
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            artisData["artist_name"],
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
                                  ],
                                ),
                                Row(
                                  children: [


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
                                                  artist_name: artisData["artist_name"],
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(), //<-- SEE HERE
                                            backgroundColor: Colors.white,
                                            shadowColor: const Color(0xff00000040)
                                          ),

                                          child: const Icon(Icons.play_arrow_rounded, color: Color(0xff78C1F3),)),
                                    ),


                                  ],
                                )
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

