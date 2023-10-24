import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/Widget/back_button.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  Future signUp() async {
   String username = _userNameController.text;
   String email = _emailController.text;
   String password = _passwordController.text;
   String phoneNumber = _phoneNumberController.text;

    UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

   if(userCredential != null ){
     createUserDocumnet(userCredential);
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
                       Text('User is successfully created!',
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
     Navigator.pushNamed(context, "/home");
   }else {
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
                       Text('Create Failed!',
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
  Future<void> createUserDocumnet(UserCredential userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).
            set({
            'email': userCredential.user!.email,
            'username': _userNameController.text,
            'phoneNumber' : _phoneNumberController.text,
      });
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
      resizeToAvoidBottomInset: false,
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
