import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsapp/home_page.dart';
import 'package:newsapp/login_page.dart';
import 'firebase_options.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
 
 @override
  void initState() {
    super.initState();
    
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    Timer(const Duration(seconds: 2), () {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
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
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder:(context, snapshot) => snapshot.hasData? NewsApp() : LoginPage() ,
      // );
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
