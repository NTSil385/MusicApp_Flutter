import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register/pages/profile_page.dart';
import 'package:login_register/pages/storage_page.dart';
import 'package:login_register/pages/upload.dart';




class indexPageHome extends StatefulWidget {
  const indexPageHome({super.key});

  @override
  State<indexPageHome> createState() => _indexPageHometate();
}

class _indexPageHometate extends State<indexPageHome> {
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





class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final images = [
    Image.asset('assets/image/pic-6.png'),
    Image.asset('assets/image/pic-7.png'),
    Image.asset('assets/image/pic-8.png'),
    Image.asset('assets/image/pic-9.png'),
    Image.asset('assets/image/pic-10.png'),
];

  int myCurrentIndex = 0;



  @override
  Widget build(BuildContext context) {
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: const Row(
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
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          height: 70,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 70,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 70,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 70,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text('Popular Artist',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  // Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: CarouselSlider(
                  //       items: images,
                  //       options: CarouselOptions(
                  //         autoPlay: true,
                  //         height: 200,
                  //         onPageChanged: (index, reason){
                  //           setState(() {
                  //             myCurrentIndex = index;
                  //           });
                  //         }
                  //       )
                  //   ),
                  // )
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                height: 140.0,
                                width: 140.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/billie.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          height: 140.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            //set border radius to 50% of square height and width
                            image:  const DecorationImage(
                              image: AssetImage("assets/image/bp.jpg"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          height: 140.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            //set border radius to 50% of square height and width
                            image:  const DecorationImage(
                              image: AssetImage("assets/image/taylor.jpg"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          height: 140.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            //set border radius to 50% of square height and width
                            image:  const DecorationImage(
                              image: AssetImage("assets/image/after.jpg"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          height: 140.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            //set border radius to 50% of square height and width
                            image:  const DecorationImage(
                              image: AssetImage("assets/image/3.jpg"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text('Popular new releases',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text('Your top mixes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 205,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius to 50% of square height and width
                                  image:  const DecorationImage(
                                    image: AssetImage("assets/image/bornpink.jpg"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Born Pink',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        ),
      );
  }

}