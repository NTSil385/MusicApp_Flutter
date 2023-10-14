import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widget/back_button.dart';
import 'firebase_auth_implement.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

    Future sigIn() async {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if(user != null ){
        print('User is successfully login!');
        Navigator.pushNamed(context, "/home");
      }else {
        print('ERORR');
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
      backgroundColor: Colors.grey[300],
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d2846),
              Color(0xff2c3d5b),
            ])
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              backButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(
                        '/back');
                  }),
              const SizedBox(height: 100),
              Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column( children: [
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
                        height: 10,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      //Email text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff1d2846),
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
                              color: Color(0xff1d2846),
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
                                hintText: 'Full Name',
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot Password? ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
                          ),
                          Text(
                            'Click here!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
