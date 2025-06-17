import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:newsapp/profile_page.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});
  @override
    NewsAppState createState() => NewsAppState();
 
}
class NewsAppState extends State<NewsApp>{
 List<dynamic> _data =[];
 
  
  @override
  void initState() {
    super.initState();
    loadjson();
  }

  Future<void> loadjson() async{
   final String jsonString = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      _data = jsonData['articles'];
    });
  }
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('NewsApp'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()),);
      },
      child: CircleAvatar(
        radius: 18,
        child: Text(['name'][0],      
      )),
      ),
    )]
      ),
      body:ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index){final user = _data[index];
        return ListTile(
          title: Text(user['description']),
          subtitle: Text(user['title']),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
       BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home',),
       BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label:'Search',),
       BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label:'Saved',),

      ]),  
    );
  }



}