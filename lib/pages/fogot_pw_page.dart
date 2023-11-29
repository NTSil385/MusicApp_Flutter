import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/Widget/back_button.dart';
import 'package:login_register/Widget/button_outline.dart';

class FogotPasswordPage extends StatefulWidget {
  const FogotPasswordPage({super.key});

  @override
  State<FogotPasswordPage> createState() => _FogotPasswordPageState();
}

class _FogotPasswordPageState extends State<FogotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
   try {
     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
     showDialog(context: context,
         builder: (context){
           return AlertDialog(
             content: Text('Password reset link sent! Check your email'),
           );
         });
   } on FirebaseAuthException catch(e){
     print(e);
     showDialog(context: context,
         builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
         });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 500,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff1d2846),
                          Color(0xff2c3d5b),
                        ])
                    ),
                    child: backButton(
                        onClick: () {
                          Navigator.of(context).pushNamed(
                              '/back');
                        }),
                  ),
                ],
              ),
            ),
            Container(
              height: 870,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff1d2846),
                    Color(0xff2c3d5b),
                  ])
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 25),
                    child: Text('Enter your email and we will send you a password reset link',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
                  ButtonOutlineWidget(
                      text: 'Send',
                      onClick: () {
                        passwordReset();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
