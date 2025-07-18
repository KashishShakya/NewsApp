import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/signup_page.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
static final TextEditingController passwordController = TextEditingController();
static final TextEditingController emailController = TextEditingController();
bool isButtonEnabled = false;
String? name;
String? imageUrl;
String? email;



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
    // if(e.code == 'user-not-found'){
    //   print('No user found for that email.');
    // } else if(e.code == 'wrong password'){
    //   print('Wrong password provided for that user.');
    // }
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed'),),);
  } 

  }

Future<void> googleSignIn(BuildContext context) async {
   
  try {
    // 1. Initialize with your client ID
    await GoogleSignIn.instance.initialize(
      clientId: DefaultFirebaseOptions.android.androidClientId,
      // clientId: '396490676726-i2db1jcqu9p3vuc61q11onvvtlkefp27.apps.googleusercontent.com', // Get from Firebase Console
    );

    // 2. Start interactive auth
    final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();

    // 3. Get authorization tokens
    final GoogleSignInAuthorizationClient authClient = account.authorizationClient;
    final authTokens = await authClient.authorizationForScopes(['email', 'profile']);

    if (authTokens != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: authTokens.accessToken,
        idToken: account.authentication.idToken, // May be null, check in Firebase console
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Store details
      name = account.displayName;
      imageUrl = account.photoUrl;
      email = account.email;
       
        if (!context.mounted) return; 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  NewsApp()),
      );
    } else {
      print("Authorization failed. No tokens returned.");
    }
  } catch (e) {
    print("Google Sign-In failed: $e");
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
          SizedBox(height: MediaQuery.sizeOf(context).height*0.04),
          ElevatedButton(onPressed: (){
          googleSignIn(context);
          }, child: Text('Sign In with Google')),
          SizedBox(height: 25,),
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
              obscureText: true,
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
          } : null, child: Text('Login')),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create an account?'),
              SizedBox(width: 10,),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
          }, child: Text('Sign Up'))
            ],
          )
        ],
      ),
    );
  }
}