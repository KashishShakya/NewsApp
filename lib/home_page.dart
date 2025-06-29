import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:newsapp/details_page.dart';
import 'package:newsapp/profile_page.dart';
import 'package:newsapp/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import  'package:cached_network_image/cached_network_image.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});
  @override
    NewsAppState createState() => NewsAppState();
 
}
class NewsAppState extends State<NewsApp>{
 List<dynamic> _data =[];
 int _selectedIndex =0;
 int _selectedButton = 0;
  String link='https://newsapi.org/v2/top-headlines?country=us&apiKey=391521530f6147efa81202969109ea89';
 String? username;
  
  @override
  void initState() {
    super.initState();
    fetchdata();
    loadDetails();
  }

  // Future<void> loadjson() async{
  //  final String jsonString = await rootBundle.loadString('assets/data.json');
  //   final Map<String, dynamic> jsonData = jsonDecode(jsonString);
  //   setState(() {
  //     _data = jsonData['articles'];
  //   });
  // }

  void fetchdata() async{
  // print('fetchdata called');
  try{
    final response = await http.get(Uri.parse(link));
    if(response.statusCode==200){
      final body = response.body;
  final json = jsonDecode(body);
  if(json!=null && json['articles']!=null){
    setState(() {
    _data = json['articles'];
  });
  }
  else{ // Handle missing 'articles' key or empty data
    setState(() {
      _data = [];
    });
  }
    }
    else{ // Server responded with an error
    throw Exception('Failed to load data: ${response.statusCode}');
    }
  }catch(e){// Catch network errors, JSON parse errors, etc.
    setState(() {
      _data=[];
    });
  }
  }

  Future<void> loadDetails()async{
final prefs = await SharedPreferences.getInstance();
setState(() {
    username = prefs.getString('username') ?? 'Guest';
  });
}


  void _onItemTapped(int index) {
  if (index == 1) { 
    Navigator.pushReplacement(
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
        child: Text('$username'[0]     
      )),
      ),
    )]
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox( height: 50,
          child: ListView(
           scrollDirection: Axis.horizontal,
            children: [
              ElevatedButton(onPressed: () {setState(() { _selectedButton =0;
                link = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=391521530f6147efa81202969109ea89';
              }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==0 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 0 ? Colors.white : Colors.black,
              ) ,child: Text('All')),
                SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =1;
              link = 'https://newsapi.org/v2/top-headlines?category=technology&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==1 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 1 ? Colors.white : Colors.black,
              ) , child: Text('Technology')),
                SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =2;
              link = 'https://newsapi.org/v2/top-headlines?category=sports&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==2 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 2 ? Colors.white : Colors.black,
              ) , child: Text('Sports')),
                SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =3;
              link = 'https://newsapi.org/v2/top-headlines?category=business&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==3 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 3 ? Colors.white : Colors.black,
              ) , child: Text('Business')),
                SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =4;
              link = 'https://newsapi.org/v2/top-headlines?category=entertainment&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==4 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 4 ? Colors.white : Colors.black,
              ) , child: Text('Entertainment')),
              SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =5;
              link = 'https://newsapi.org/v2/top-headlines?category=health&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==5 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 5 ? Colors.white : Colors.black,
              ) , child: Text('Health')),
                SizedBox(width: 35),
            ElevatedButton(onPressed: () {setState(() {_selectedButton =6;
              link = 'https://newsapi.org/v2/top-headlines?category=Science&country=us&apiKey=391521530f6147efa81202969109ea89';
            }); fetchdata();},style: ElevatedButton.styleFrom(
              backgroundColor: _selectedButton ==6 ? Colors.blue : Colors.white,
              foregroundColor: _selectedButton == 6 ? Colors.white : Colors.black,
              ) , child: Text('Science')),
          ],),
          ),
          SizedBox(height: 15.0),
           Expanded(child:ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index){final user = _data[index];
        final image = user['urlToImage'];
        final right = image ?? 'https://via.placeholder.com/150';
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
          child: Image.network(right, width: MediaQuery.sizeOf(context).height*0.8, height: 300, fit: BoxFit.cover,),
          ),
  //         CachedNetworkImage(
  // imageUrl: user['urlToImage'] ?? 'https://via.placeholder.com/150',
  // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
  // errorWidget: (context, url, error) => Icon(Icons.broken_image),
  // width: double.infinity,
  // height: 200,
  // fit: BoxFit.cover,
//),
          SizedBox(height: 10,),
          Text(user['title'],
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w400,
          )),
          SizedBox(height: 10,),
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(user['author'] ?? 'Author',
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),
          Text(user['publishedAt'] ?? 'Published Date',
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
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