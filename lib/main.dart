import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/login.dart';
import 'Screens/signup.dart';
import 'Screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),
      routes: {
        '/signup':(_)=>signup(),
        '/home':(_)=>home(),
        '/login':(_)=>login(),
      },
    );
  }
}
