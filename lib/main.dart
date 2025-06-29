import 'package:flutter/material.dart';
import 'package:newsapp/login_page.dart';
import 'package:newsapp/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String KEYNAME = "login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  void whereToGo() async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPref.getBool(KEYNAME);

    Timer(const Duration(seconds: 2), () {
      if(isLoggedIn != null){
         if (isLoggedIn == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewsApp()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
      }
     else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Icon(Icons.account_circle, color: Colors.white, size: 100),
        ),
      ),
    );
  }
}
