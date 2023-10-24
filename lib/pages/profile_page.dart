  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';

  class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    State<ProfilePage> createState() => _ProfilePageState();
  }

  class _ProfilePageState extends State<ProfilePage> {

    final User? currentUser = FirebaseAuth.instance.currentUser;

    Future<String?> getUserName() async {
      if (currentUser != null && currentUser!.email != null) {
        final DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser!.email!)
            .get();
        final userDataMap = userData.data();
        if (userDataMap != null) {
          return userDataMap["username"];
        }
      }
      return null; // Trả về null nếu không thể lấy tên người dùng
    }

    Future signOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamed("/welcome");
    }
    @override
    void initState() {
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      if(currentUser != null && currentUser!.email != null){

        return Scaffold(
          backgroundColor:  Color(0xff2c3d5b),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network("https://firebasestorage.googleapis.com/v0/b/crudapp-40e03.appspot.com/o/Images%2F5e16a7dd05f2ccf8ba8881ae01438a52.jpg?alt=media&token=4fcbb1a6-678c-41a4-8b59-00a6b9814799",
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        children: [
                          FutureBuilder<String?>(
                            future: getUserName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data ?? 'Tên người dùng không có',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[100],
                                  ),
                                );
                              } else {
                                return Text('Không thể lấy tên người dùng');
                              }
                            },
                          ),

                          const SizedBox(height: 10,),
                          Text( currentUser!.email ?? 'Người dùng chưa đăng nhập',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[100],
                            ),)
                        ],
                      ),
                      const SizedBox(width: 10,),
                      IconButton(
                          onPressed: ()  {
                            signOut();
                          },
                          icon: Image.asset('assets/image/logout.png', width: 30,height: 30,))
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  height: 2,
                  color: Colors.grey[100],
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/upload');
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffFBC2EB),
                                        Color(0xff78FFB3)
                                      ]),
                                ),
                                child: Image.asset('assets/image/btnupload.png'),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/storage');
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffFBC2EB),
                                        Color(0xff78FFB3)
                                      ]),
                                ),
                                child: Image.asset('assets/image/stogare.png'),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/');
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffA6C1EE),
                                        Color(0xff78FFB3)
                                      ]),
                                ),
                                child: Image.asset('assets/image/add_album.png'),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/');
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffA6C1EE),
                                        Color(0xff78FFB3)
                                      ]),
                                ),
                                child: Image.asset('assets/image/add_playlist.png'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/');
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffA6C1EE),
                                        Color(0xffFFF2F2)
                                      ]),
                                ),
                                child: Image.asset('assets/image/fav_album.png'),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/upload');
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xffA6C1EE),
                                        Color(0xffFFF2F2)
                                      ]),
                                ),
                                child: Image.asset('assets/image/playlist.png'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

        );
      }else {
        return Scaffold(
          backgroundColor: Color(0xff2c3d5b),
          body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Trước tiên bạn cần phải đăng nhập',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text('Đăng nhập'),
                  ),
                ],
              )
          ),
        );
      }
    }
  }
