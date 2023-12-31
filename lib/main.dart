import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_register/album_page/add_album.dart';
import 'package:login_register/album_page/album.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:login_register/pages/artist_signup.dart';
import 'package:login_register/home/home_page.dart';
import 'package:login_register/home/index_page.dart';
import 'package:login_register/pages/fogot_pw_page.dart';
import 'package:login_register/pages/index_profile.dart';
import 'package:login_register/pages/login_page.dart';
import 'package:login_register/pages/signup_page.dart';
import 'package:login_register/storage/storage_page.dart';
import 'package:login_register/profile/upload.dart';
import 'package:login_register/pages/welcome_page.dart';
import 'package:login_register/transition/transition_page.dart';
import 'package:just_audio_background/just_audio_background.dart';


Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();


    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBBS5BFwlnU4pK_8_SlE-07SXmYSONoEE8",
        appId: "1:60269194876:android:74ad600d37b6d7a58563f9",
        messagingSenderId: "60269194876",
        projectId: "music-3ab6b",
        storageBucket: "music-3ab6b.appspot.com",
      ),
    );
    // Kích hoạt Firebase App Check
    await FirebaseAppCheck.instance.activate();
    await Hive.initFlutter();
    await Hive.openBox('favorites');
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
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
          child: const indexPageHome(),
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
