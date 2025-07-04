import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/login_page.dart';

class ProfilePage extends StatefulWidget{
   const ProfilePage({super.key});
@override
ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{
String username = 'Guest';
  String email = 'No Email';
  String uid = '';


@override
void initState(){
  super.initState();
  loadDetails();
}

Future<void> loadDetails()async{

}

Future<void> logout() async{
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
}

  @override
  Widget build(BuildContext context){
   return Scaffold(
    appBar: AppBar(title: Text('NewsApp', style: TextStyle(fontWeight: FontWeight.bold),),
    centerTitle: true,
    actions: [
      Icon(Icons.edit),
    ],
    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: MediaQuery.sizeOf(context).height*0.09,
        child: Text(username.isNotEmpty ? username[0].toUpperCase() : 'G',      
        )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.04,
        ),
        Text(username,  style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text(email,style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
         Text('UID : $uid',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        ElevatedButton(onPressed: () async{
        logout();
        }, child: Text('Logout'))
      ],
      ), 
    ),
     
   );
  }
}