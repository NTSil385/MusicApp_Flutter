import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login_register/home/searchPage.dart';
import 'package:login_register/profile/profile_page.dart';

import 'home_page.dart';

class indexPage extends StatefulWidget {
  const indexPage({super.key});

  @override
  State<indexPage> createState() => _indexPageState();
}

class _indexPageState extends State<indexPage> {
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
