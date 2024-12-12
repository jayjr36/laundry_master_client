import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry_master/firebase_options.dart';
import 'package:laundry_master/login.dart';
import 'package:laundry_master/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),

       theme: ThemeData(
    primaryColor: Colors.blueAccent,
    hintColor: Colors.teal,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  ),
      home: const SplashScreen(),
    );
  }
}
