import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register/pages/profile_page.dart';
import 'package:login_register/pages/storage_page.dart';
import 'package:login_register/pages/upload.dart';

import 'home_page.dart';

class indexPage extends StatefulWidget {
  const indexPage({super.key});

  @override
  State<indexPage> createState() => _indexPageState();
}

class _indexPageState extends State<indexPage> {
  int currenrIndex = 0;
  List tabs = [
    HomePage(),
    stogragePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor:  Color(0xff2c3d5b),
        animationDuration: Duration(milliseconds: 300),
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
