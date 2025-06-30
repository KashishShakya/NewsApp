import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
static final TextEditingController passwordController = TextEditingController();
static final TextEditingController emailController = TextEditingController();
bool isButtonEnabled = false;

@override
void initState(){
  super.initState();
  emailController.addListener(_updateButtonState);
  passwordController.addListener(_updateButtonState);
  
}

Future<void> loginuser () async {
  try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email : emailController.text.trim(),
      password : passwordController.text.trim(),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewsApp()));
  } on FirebaseAuthException catch (e){
    if(e.code == 'user-not-found'){
      print('No user found for that email.');
    } else if(e.code == 'wrong password'){
      print('Wrong password provided for that user.');
    }
  } 
  }




void _updateButtonState(){
  setState(() {
    isButtonEnabled = passwordController.text.trim().isNotEmpty && 
    emailController.text.trim().isNotEmpty;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login for hot news:)'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, color: Colors.blue, size: 90,),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.07),
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width*0.9,
              child: TextField(controller: emailController,
          decoration: InputDecoration(
            label: Text('Email Id'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)
            )
          ),),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width*0.9,
              child: TextField(controller: passwordController,
          decoration: InputDecoration(
            label: Text('Password'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)
            )
          ),),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
          
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
          ElevatedButton(onPressed: isButtonEnabled ? () async{
            loginuser();
          } : null, child: Text('Login'))
        ],
      ),
    );
  }
}