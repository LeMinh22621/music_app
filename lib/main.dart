import 'package:flutter/material.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/model/song_repository.dart';
import 'package:music_app/view/screens/detail_screen.dart';
import 'package:music_app/view/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_app/view_model/media_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
