import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:newsapp/details_page.dart';
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
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            ElevatedButton(onPressed: () {}, child: Text('Tech')),
            ElevatedButton(onPressed: () {}, child: Text('Sports')),
            ElevatedButton(onPressed: () {}, child: Text('Cinema')),
          ],),
          ),
          SizedBox(height: 10.0),
           Expanded(child:ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index){final user = _data[index];
        final image = user['urlToImage'];
        return Padding(padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child:Material(color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(
                pass : index,
                data : _data
              )),);
            },
             child: Column (
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8.0),
          child: Image.network(image, width: MediaQuery.sizeOf(context).height*0.8, height: 200, fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Text(user['title'],
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w400,
          )),
          SizedBox(height: 10,),
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(user['author'],
          style: TextStyle(fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w200,
          )),
          Text(user['publishedAt'],
          style: TextStyle(fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w200,
          )),
            ],
          )
              ]
             )
        ),
          ),
        );         
      }), 
      ),], ),        
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