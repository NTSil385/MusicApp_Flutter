import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/Widget/back_button.dart';
import 'package:login_register/pages/firebase_auth_implement.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  Future signUp() async {
   String username = _userNameController.text;
   String email = _emailController.text;
   String password = _passwordController.text;
   String phoneNumber = _phoneNumberController.text;

   User? user = await _auth.signUpWithEmailAndPassword(email, password);

   if(user != null ){
     print('User is successfully created!');
     Navigator.pushNamed(context, "/home");
   }else {
     print('ERORR');
   }
  }
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
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
                const SizedBox(height: 30),
                Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        //Hello again!
                        const Text('Register', style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        const SizedBox(
                          height: 55,
                        ),

                        //UserName text
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
                                controller: _userNameController,
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
                          height: 20,
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
                          height: 20,
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
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color:Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Phone Number
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
                                controller: _phoneNumberController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(color:Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //sign in button
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: (){
                              signUp();
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
                          height: 150,
                        ),
                        //link register
                        const Text('If you are an artist!', style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300
                        ),),
                        const SizedBox(height: 10,),
                        const Text('Click here!', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
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
