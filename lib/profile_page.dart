import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
   const ProfilePage({super.key});
@override
ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{
String username = 'Guest';
  String email = 'No Email';
  String uid = '';
final user = FirebaseAuth.instance.currentUser;


@override
void initState(){
  super.initState();
  loadDetails();
}

Future<void> loadDetails()async{
final u = user; // local alias
    final e = u?.email;
    final id = u?.uid;
    
    String name = 'Guest';
    if (e != null && e.contains('@')) {
      name = e.split('@')[0];
    }
    
    setState(() {
      username = name;
      email = e ?? 'No Email';
      uid = id ?? '';
    });
}

Future<void> logout() async{
  await FirebaseAuth.instance.signOut();
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