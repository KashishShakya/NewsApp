import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/login_page.dart';

class ProfilePage extends StatefulWidget{
   const ProfilePage({super.key});
@override
ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{
String? name;
  String? email;
  String? imgurl;


@override
void initState(){
  super.initState();
  loadDetails();
}

void loadDetails(){
  final user = FirebaseAuth.instance.currentUser;
 setState(() {
      name = user?.displayName ?? "Guest";
      email = user?.email ?? "No Email";
      imgurl = user?.photoURL ?? "";
    });

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
          backgroundImage: NetworkImage(imgurl ?? ""),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.04,
        ),
        Text("Username : $name",  style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text("Email : $email",style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
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