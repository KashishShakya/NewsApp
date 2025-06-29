import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget{
   const ProfilePage({super.key});
@override
ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{
String? username;
String? email;
String? phone;
String? date;


@override
void initState(){
  super.initState();
  loadDetails();
}

Future<void> loadDetails()async{
final prefs = await SharedPreferences.getInstance();
setState(() {
    username = prefs.getString('username') ?? 'Guest';
  email = prefs.getString('email') ?? 'Not available';
  phone = prefs.getString('phone') ?? 'Not available';
  date = prefs.getString('date') ?? 'Not available';

  });
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
        child: Text('$username'[0],      
        )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        // Text(LoginPageState.uNameController.text,
        // style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        // fontWeight: FontWeight.w500,
        // ),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.04,
        ),
        Text('$username',  style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('$email',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('$phone',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        Text('$date',style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,
        fontWeight: FontWeight.w500,),),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.02,
        ),
        ElevatedButton(onPressed: () async{
          
            var sharedPref = await SharedPreferences.getInstance();
            sharedPref.setBool(SplashPageState.KEYNAME, false);
        
        }, child: Text('Logout'))
      ],
      ), 
    ),
     
   );
  }
}