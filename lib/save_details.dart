import 'package:flutter/material.dart';
import 'package:newsapp/search_page.dart';
import 'package:newsapp/save_page.dart';

class SaveDetails extends StatefulWidget {
  final String url;
  final String title;
  final String description;
  final String author;
  final String publishedAt;
  const SaveDetails({super.key,
  required this.url,
  required this.title,
  required this.description,
  required this.author,
  required this.publishedAt,
  });

  @override
  State<SaveDetails> createState() => _SaveDetailsState();
}

class _SaveDetailsState extends State<SaveDetails> {

  int _selectedIndex =0;

  void _onItemTapped(int index) {
  if (index == 1) { 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  } 
  else if(index==2){
   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SavePage()),
    );
  }
   else {
    setState(() {
      _selectedIndex = index;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('NewsApp'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8.0),
          child: Image.network(widget.url, width: MediaQuery.sizeOf(context).height*0.8, height: 200, fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Text(widget.title,
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w400,
          )),
           SizedBox(height: 10,),
          Text(widget.description,
          style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.w200,
          )),
           SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Padding(padding: EdgeInsets.all(8.0),
              child: Text(widget.author,
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Text(widget.publishedAt,
          style: TextStyle(fontSize: 15,
           color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),)
            ],
          ),
        ],
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