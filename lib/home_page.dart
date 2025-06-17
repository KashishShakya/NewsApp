import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:newsapp/profile_page.dart';
import 'package:newsapp/search_page.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});
  @override
    NewsAppState createState() => NewsAppState();
 
}
class NewsAppState extends State<NewsApp>{
 List<dynamic> _data =[];
 int _selectedIndex =0;
 
  
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

  void _onItemTapped(int index) {
  if (index == 1) { 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  } 
   else {
    setState(() {
      _selectedIndex = index;
    });
  }
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
       BottomNavigationBarItem(icon: Icon( _selectedIndex == 0 ? Icons.home : Icons.home_outlined), label:'Home',),
       BottomNavigationBarItem(icon: Icon(_selectedIndex == 1 ? Icons.search : Icons.search_outlined), label:'Search',),
       BottomNavigationBarItem(icon: Icon(_selectedIndex == 2 ? Icons.favorite_border : Icons.favorite_border_outlined), label:'Saved',),

      ]),  
    );
  }



}