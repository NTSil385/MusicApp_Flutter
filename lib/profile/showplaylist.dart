import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_register/album_page/info_album.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/profile/info_playlist.dart';
import 'package:login_register/storage/played_playlist.dart';
import '../Widget/back_button.dart';



class showPlaylist extends StatefulWidget {
  const showPlaylist({super.key});

  @override
  State<showPlaylist> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<showPlaylist> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future getdata() async {
    if (currentUser != null && currentUser!.email != null) {
      QuerySnapshot qn = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.email)
          .collection('Playlist')
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
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: backButton(
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => indexPageHome()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text('Playlist',style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                      ),
                      IconButton(
                          onPressed: () async {
                          },
                          iconSize: 40,
                          icon: Image.asset('assets/image/Sort_icon.png')
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // Sử dụng .data() thay vì .data
                        Map<String, dynamic> playlist_name = snapshot.data[index].data();


                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(

                                    onPressed: ((context) async {
                                      if(currentUser != null && currentUser!.email != null){


                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(currentUser!.email)
                                            .collection('Playlist')
                                            .doc('[${playlist_name["playlist_name"]}]')
                                            .delete();


                                        final collectionRef = FirebaseFirestore.instance
                                            .collection("Playlist")
                                            .doc(currentUser!.email)
                                            .collection('[${playlist_name["playlist_name"]}]');

                                        // Xóa tất cả các tài liệu trong subcollection
                                        QuerySnapshot querySnapshot = await collectionRef.get();
                                        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                          await documentSnapshot.reference.delete();
                                        }

                                        // Xóa subcollection chính nó
                                        await collectionRef.parent!.delete();
                                        setState(() {});
                                      }
                                    }),
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.delete_outline,
                                  ),]
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>infoPlaylist(
                                      playlist_name:playlist_name["playlist_name"],


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
                                    height: 90,
                                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    decoration:  BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xffF9CEEE),
                                        Color(0xffF9F3EE),
                                      ],
                                          begin: AlignmentDirectional.topCenter,
                                          end: Alignment.bottomCenter
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                        ),
                                        const SizedBox(width: 15,),
                                        Text(playlist_name["playlist_name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500
                                          ),),

                                      ],
                                    ),

                                  ),
                                ],
                              ),
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

