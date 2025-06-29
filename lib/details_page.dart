import 'package:flutter/material.dart';
import 'package:newsapp/search_page.dart';

class DetailsPage extends StatefulWidget {
  final int pass;
  final List<dynamic> data;
  const DetailsPage({super.key,
  required this.pass,
  required this.data,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
 
 int _selectedIndex =0;

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
  Widget build(BuildContext context) {
    final user = widget.data[widget.pass];
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(title: Text('NewsApp'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8.0),
          child: Image.network(user['urlToImage'], width: MediaQuery.sizeOf(context).height*0.8, height: 200, fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Text(user['title'],
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w400,
          )),
           SizedBox(height: 10,),
          Text(user['description']?? 'Description of news.',
          style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.w200,
          )),
           SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Padding(padding: EdgeInsets.all(8.0),
              child: Text(user['author']?? 'Author',
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Text(user['publishedAt'] ?? 'Published Date',
          style: TextStyle(fontSize: 15,
           color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),)
            ],
          ),
          ElevatedButton(onPressed: (){
           showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saved to your lovely and spicy news lib.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white), child: Text('Save'))
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