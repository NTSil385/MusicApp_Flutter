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
    late bool check;

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

    Future<String?> getUserAvatar() async {
      if (currentUser != null && currentUser!.email != null) {
        final DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser!.email)
            .get();
        final userAvatar = userData.data();
        if (userAvatar != null) {
            return userAvatar["avt"];
        }
      }
      return null;
    }

    Future<String> getRole() async {
      if (currentUser != null && currentUser!.email != null) {
        final DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser!.email!)
            .get();
        final userRole = userData.data();
        if (userRole != null) {
          print(userRole["role"].runtimeType) ;
          check = userRole["role"];

        }
      }
      return 'null'; // Trả về null nếu không lấy được giá trị "role"
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
          backgroundColor:  const Color(0xff2c3d5b),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child:  FutureBuilder<String?>(
                            future: getUserAvatar(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(snapshot.data ?? '',
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                );
                              } else {
                                return const Text('ERROR');
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          children: [
                            FutureBuilder<String?>(
                              future: getUserName(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  return SizedBox(
                                    width: 100,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      snapshot.data ?? 'Tên người dùng không có',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[100],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Text('Không thể lấy tên người dùng');
                                }
                              },
                            ),

                            const SizedBox(height: 10,),
                            SizedBox(
                              width: 120,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                currentUser!.email ?? 'Người dùng chưa đăng nhập',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[100],
                                ),),
                            )
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
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  height: 2,
                  color: Colors.grey[100],
                ),
                const SizedBox(height: 20,),


                FutureBuilder<String>(
                  future: getRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      final role = snapshot.data;
                      if (check == true) {
                        // Nếu role là true, hiển thị trang Artist
                        return   Container(
                          margin: const EdgeInsets.fromLTRB(50, 20, 0, 0),
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
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                        Navigator.of(context).pushNamed('/addAlbum');
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
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        );
                      } else {
                        // Nếu role không phải true, hiển thị trang User
                        return   Container(
                          margin: const EdgeInsets.fromLTRB(50, 20, 0, 0),
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
                                        child: Image.asset('assets/image/fav_playlist.png'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushNamed('/storage');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                        child: Image.asset('assets/image/fav_artist.png'),
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
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                        child: Image.asset('assets/image/add_playlist.png'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Text('Không thể lấy role');
                    }
                  },
                )
              ],
            ),
          ),

        );
      }else {
        return Scaffold(
          backgroundColor: const Color(0xff2c3d5b),
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
                    child: const Text('Đăng nhập'),
                  ),
                ],
              )
          ),
        );
      }
    }
  }
