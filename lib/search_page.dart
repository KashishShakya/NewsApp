import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';

class SearchPage extends StatefulWidget{
const SearchPage({super.key});
@override
SearchPageState createState() => SearchPageState(); 

}
class SearchPageState extends State<SearchPage>{
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
  if (index == 0) { 
    Navigator.push(
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
    body: TextField(decoration: InputDecoration(border: OutlineInputBorder(),
    hintText: 'Search here',
    suffixIcon: Icon(Icons.arrow_forward)
    ),),
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

