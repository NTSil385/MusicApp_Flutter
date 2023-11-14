import 'package:flutter/material.dart';
import 'package:login_register/Widget/button_outline.dart';
import 'package:login_register/home/home_page.dart';
import '../Widget/button_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Color(0xff1d2846),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(child: Image.asset('assets/image/LOGO_Final.png', width: 300,)),
              const SizedBox(height: 30,),
              const Text('WELCOME TO THE CLOUD', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
              const SizedBox(height: 30,),
              ButtonWidget(
                  text: 'Login',
                  onClick: () {
                    Navigator.of(context).pushNamed(
                        '/login');
                  }),
              const SizedBox(height: 20),
              ButtonOutlineWidget(
                  text: 'Sign Up',
                  onClick: () {
                    Navigator.of(context).pushNamed('/register');
                  }),
              const SizedBox(height: 150,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Text('Continue a guest', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }

}