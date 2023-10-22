import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register/pages/played_page.dart';
import 'package:login_register/test/songplayed.dart';

import '../Widget/back_button.dart';

class stogragePage extends StatefulWidget {
  const stogragePage({super.key});

  @override
  State<stogragePage> createState() => _stogragePageState();
}

class _stogragePageState extends State<stogragePage> {

  Future getdata() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('songs').get();
    return qn.docs;
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
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // Sử dụng .data() thay vì .data
                  Map<String, dynamic> songData = snapshot.data[index].data();
                  Map<String, dynamic> DataImage = snapshot.data[index].data();
                  Map<String, dynamic> DataAudio = snapshot.data[index].data();
                  Map<String, dynamic> artisData = snapshot.data[index].data();
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
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
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
              );
            }
          },
        ),
      ),
    );
  }

}

