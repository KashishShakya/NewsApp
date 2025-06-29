import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';
import 'package:newsapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
static final TextEditingController dateController = TextEditingController();
static final TextEditingController emailController = TextEditingController();
static final TextEditingController phoneController = TextEditingController();
static final TextEditingController uNameController = TextEditingController();
bool isButtonEnabled = false;

@override
void initState(){
  super.initState();
  dateController.addListener(_updateButtonState);
  phoneController.addListener(_updateButtonState);
  emailController.addListener(_updateButtonState);
  uNameController.addListener(_updateButtonState);
}

void _updateButtonState(){
  setState(() {
    isButtonEnabled = dateController.text.trim().isNotEmpty && 
    phoneController.text.trim().isNotEmpty && uNameController.text.trim().isNotEmpty
    && emailController.text.trim().isNotEmpty;
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
              child: TextField(controller: uNameController,
          decoration: InputDecoration(
            label: Text('Username'),
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
              child: TextField(controller: phoneController,
          decoration: InputDecoration(
            label: Text('Phone No.'),
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
              child: TextField(controller: dateController,
          decoration: InputDecoration(
            label: Text('Date'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)
            )
          ),),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
          ElevatedButton(onPressed: isButtonEnabled ? () async{
            var sharedPref = await SharedPreferences.getInstance();
            sharedPref.setBool(SplashPageState.KEYNAME, true);
            await sharedPref.setString('username', uNameController.text);
            await sharedPref.setString('email', emailController.text);
            await sharedPref.setString('phone', phoneController.text);
            await sharedPref.setString('date', dateController.text);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewsApp()));
          } : null, child: Text('Login'))
        ],
      ),
    );
  }
}