import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/details_page.dart';

class SearchPage extends StatefulWidget{
const SearchPage({super.key});
@override
SearchPageState createState() => SearchPageState(); 

}
class SearchPageState extends State<SearchPage>{
  int _selectedIndex = 1;
  final TextEditingController searchController = TextEditingController();
  List<dynamic> _data =[];


void fetchdata() async{
  // print('fetchdata called');
  try{
    final query = searchController.text.trim();
    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=391521530f6147efa81202969109ea89'));
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

  void _onItemTapped(int index) {
  if (index == 0) { 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NewsApp()),
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
      appBar: AppBar(title: Text('NewsApp', style: TextStyle(fontWeight: FontWeight.bold),),
    centerTitle: true,
    actions: [Icon(Icons.search_off_outlined)],),
    body:Padding(padding: EdgeInsets.all(16.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
       SizedBox(
      width: MediaQuery.sizeOf(context).width*0.9,
      child: TextField(controller: searchController,
      decoration:  InputDecoration(border: OutlineInputBorder(),
    hintText: 'Search here',
    suffixIcon: IconButton(onPressed: (){fetchdata();}, icon: Icon(Icons.arrow_forward)),
    ),),
    ),
    Expanded(child:ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index){final user = _data[index];
        final image = user['urlToImage'];
        final right = image ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1024px-React-icon.svg.png';
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
      ),
    ],
    ),
    ),
   
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

