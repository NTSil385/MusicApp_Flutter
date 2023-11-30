import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/home/played_page.dart';
import 'package:login_register/home/show_artist.dart';

import '../Widget/back_button.dart';



class stogragePage extends StatefulWidget {
  const stogragePage({super.key});

  @override
  State<stogragePage> createState() => _stogragePageState();
}

class _stogragePageState extends State<stogragePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future getdata() async {
    if (currentUser != null && currentUser!.email != null) {
      QuerySnapshot qn = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.email)
          .collection('songs')
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
            color: Color(0xff0B1223
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
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: backButton(
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const indexPageHome()));
                            }),
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
                    Map<String, dynamic> lyricData = snapshot.data[index].data();



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
                                lyric: lyricData["lyrics"],
                              )
                          )
                          );
                        },
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(

                                      onPressed: ((context) async {
                                        if(currentUser != null && currentUser!.email != null){


                                          await FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(currentUser!.email)
                                              .collection('songs')
                                              .doc(songData["song_name"])
                                              .delete();


                                          await FirebaseFirestore.instance
                                              .collection('songs')
                                              .doc(songData["song_name"])
                                              .delete();


                                          setState(() {});
                                        }
                                      }),
                                      backgroundColor: Colors.redAccent,
                                      icon: Icons.delete_outline,
                                    ),



                                  ]
                              ),
                              child: Container(
                                width: 400,
                                height: 70,
                                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(4),
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
                                    Container(
                                      width: 250,
                                      child: Text(songData["song_name"],
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis
                                        ),),
                                    ),
                                  ],
                                ),
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

