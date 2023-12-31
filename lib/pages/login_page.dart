import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/pages/fogot_pw_page.dart';
import 'package:login_register/service/auth_sevice_google.dart';

import '../Widget/back_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    Future sigIn() async {
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        if(credential.user != null ){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Stack(
              children: [
                Container(
                  width: 330,
                  height: 80,
                  decoration: const BoxDecoration(
                      color:  Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20))

                  ),
                  child: const Row(

                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Congratulation!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('Login Successfully',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
          Navigator.of(context).pushNamed('/index');
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Stack(
            children: [
              Container(
                width: 330,
                height: 80,
                decoration: const BoxDecoration(
                    color:  Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20))

                ),
                child: const Row(

                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ERROR!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Login Failed!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }


}
 @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              Container(
                height: 870,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xff1d2846),
                      Color(0xff2c3d5b),
                    ])
                ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      backButton(
                          onClick: () {
                            Navigator.of(context).pushNamed(
                                '/back');
                          }),
                      const SizedBox(height: 80),
                      Container(
                        child: Center(
                            child: Column(
                                children:
                            [
                              //Hello again!
                              const SizedBox(
                                height: 55,
                              ),
                              const Text('Login', style:TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                              const SizedBox(
                                height: 40,
                              ),
                              //Email text
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff1d2846),
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                      style: const TextStyle(
                                          color: Colors.white
                                      ),
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Email',
                                        hintStyle: TextStyle(color:Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ), //Password text
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff1d2846),
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                      obscureText: true,
                                      style: const TextStyle(
                                          color: Colors.white
                                      ),
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color:Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //sign in button
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: GestureDetector(
                                  onTap: (){
                                    sigIn();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: const Center(
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //link register
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Forgot Password? ',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return FogotPasswordPage();
                                      }));
                                    },
                                    child: const Text(
                                      'Click here!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 200),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      UserCredential gg = await AuthService().signInWithGoogle();
                                      if (gg != null && gg.user != null) {

                                        var data = {
                                          'email': gg.user!.email,
                                          'username': "Guest",
                                          'phoneNumber' : '123456789',
                                          "role": false,
                                          "avt": "https://firebasestorage.googleapis.com/v0/b/music-3ab6b.appspot.com/o/Avatars%2FFB_IMG_1697286654747.jpg?alt=media&token=cfd3cbec-5040-4312-ac35-dbaa6f261bb5",
                                        };
                                        await FirebaseFirestore.instance.collection("Users").doc(gg.user!.email).
                                        set(data);
                                        // Đăng nhập thành công
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Stack(
                                            children: [
                                              Container(
                                                width: 330,
                                                height: 80,
                                                decoration: const BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Congratulation!',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 24,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(
                                                            'Login Successfully',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        ));
                                        Navigator.of(context).pushNamed('/index');
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Image.asset('assets/image/google.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  const Text('Or',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),),
                                  const SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const HomePage()));
                                    },
                                    child:  Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white, width: 2),
                                          color: Color(0xff1d2846),
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                      child: Text('Continue a guest', style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                        ),
                      ),
                    ],
                  ),

              ),
            ],
          ),
      ),

    );
  }
}
