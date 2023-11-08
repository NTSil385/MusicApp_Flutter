import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:login_register/album_page/add_album.dart';
import 'package:login_register/album_page/album.dart';
import 'package:login_register/pages/artist_signup.dart';
import 'package:login_register/pages/home_page.dart';
import 'package:login_register/pages/index_page.dart';
import 'package:login_register/pages/index_profile.dart';
import 'package:login_register/pages/login_page.dart';
import 'package:login_register/pages/signup_page.dart';
import 'package:login_register/storage/storage_page.dart';
import 'package:login_register/pages/upload.dart';
import 'package:login_register/pages/welcome_page.dart';
import 'package:login_register/test/album.dart';
import 'package:login_register/transition/transition_page.dart';


Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();


    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDUYGoZ0SiXxi_xzAswnlEwugklFAh5vgQ",
          appId: "1:1015362527585:android:690d0ac39ca510bb7ca520",
          messagingSenderId: "1015362527585",
          projectId: "crudapp-40e03",
        storageBucket: "crudapp-40e03.appspot.com",
      ),
    );
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
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
          child: const LoginPage(),
          settings: settings,
        );
      case '/register':
        return CustomPageRoute(
          child: const signUp(),
          direction: AxisDirection.left,
          settings: settings,
        );
      case '/artist':
        return CustomPageRoute(
          child: const ArtistSignUp(),
          settings: settings,
        );
      case '/home':
        return CustomPageRoute(
          child: const HomePage(),
          direction: AxisDirection.up,
          settings: settings,
        );
      case '/index':
        return CustomPageRoute(
          child: const indexPage(),
          direction: AxisDirection.up,
          settings: settings,
        );
      case '/index_profile':
        return CustomPageRoute(
          child: const indexProfilePage(),
          direction: AxisDirection.up,
          settings: settings,
        );
      case '/back':
        return CustomPageRoute(
          child: const WelcomePage(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case '/upload':
        return CustomPageRoute(
          child: const UploadPage(),

          settings: settings,
        );
      case '/storage':
        return CustomPageRoute(
          child: const stogragePage(),

          settings: settings,
        );
      case '/profile':
        return CustomPageRoute(
          child: const indexPage(),
          direction: AxisDirection.left,
          settings: settings,
        );
      case '/addAlbum':
        return CustomPageRoute(
          child: const add_AlbumPage(),
          direction: AxisDirection.left,
          settings: settings,
        );
      case '/Albums':
        return CustomPageRoute(
          child: const Album(),
          direction: AxisDirection.left,
          settings: settings,
        );
      case '/welcome':
      default:
        return CustomPageRoute(
          child: const WelcomePage(),
          settings: settings,
        );
    }
  }
}
