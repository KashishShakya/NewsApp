import 'package:flutter/material.dart';
import 'package:newsapp/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
 TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


Future<void> registerusers() async{
  try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email : emailController.text.trim(),
      password : passwordController.text.trim(),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  } on FirebaseAuthException catch (e){
    if(e.code == 'weak-password'){
      print('The password provided is too weak.');
    } else if(e.code == 'email-already-in-use'){
      print('The account already exists for that email.');
    }
  } catch(e){
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Create your Account'), centerTitle: true,),
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          ElevatedButton(onPressed: (){ registerusers();
          }, child:Text('Sign Up')),
          Text('Already have an account?'),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          }, child:Text('Login')),
      ],
     ),
    );
  }
}