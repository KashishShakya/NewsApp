import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
   const ProfilePage({super.key});
@override
ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{

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
        child: Text(['name'][0],      
        )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('@user_name',
        style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,
        ),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.04,
        ),
        Text('UserName',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('mailid@gmail.com',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('Mobile No.',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('DD/MM/YYYY',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.3,
        ),
      ],
      ), 
    ),
     
   );
  }
}