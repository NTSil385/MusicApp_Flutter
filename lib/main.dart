import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_register/pages/SplashScreen.dart';
import 'package:login_register/pages/home_page.dart';
import 'package:login_register/pages/login_page.dart';
import 'package:login_register/pages/main_page.dart';
import 'package:login_register/pages/signup_page.dart';
import 'package:login_register/pages/welcome_page.dart';
import 'package:login_register/transition/transition_page.dart';

import 'firebase_options.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized();

    // This is the last thing you need to add.
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDUYGoZ0SiXxi_xzAswnlEwugklFAh5vgQ",
          appId: "1:1015362527585:android:690d0ac39ca510bb7ca520",
          messagingSenderId: "1015362527585",
          projectId: "crudapp-40e03")
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/welcome',
    onGenerateRoute: (route) => onGenerateRoute(route),
  );

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return CustomPageRoute(
          child: LoginPage(),
          settings: settings,
        );
      case '/register':
        return CustomPageRoute(
          child: signUp(),
          direction: AxisDirection.left,
          settings: settings,
        );

      case '/welcome':
      default:
        return CustomPageRoute(
          child: WelcomePage(),
          settings: settings,
        );
    }
  }
}
