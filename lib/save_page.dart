import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/home_page.dart';
import 'package:newsapp/save_details.dart';
import 'package:newsapp/search_page.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
int _selectedIndex = 2;

void _onItemTapped(int index) {
  if (index == 0) { 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NewsApp()),
    );
  } 
  else if(index==1){
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved articles'),),
      body: StreamBuilder<List<News>>(
  stream: readNews(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      final news = snapshot.data!;
      return ListView(
        children: news.map(buildnews).toList(),
      );
    } else {
      return const Center(child: Text('No data found'));
    }
  },
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

  Widget buildnews(News news) => Padding(padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child:Material(color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveDetails(
                url : news.url,
                title : news.title,
                description: news.description,
                author : news.author,
                publishedAt : news.publishedAt.toString().split(' ')[0]
              )),);
            },
             child: Column (
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8.0),
          child: Image.network(news.url, width: MediaQuery.sizeOf(context).height*0.8, height: 300, fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Text(news.title,
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w400,
          )),
          SizedBox(height: 10,),
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(news.author,
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),
          Text(news.publishedAt.toString().split(' ')[0],
          style: TextStyle(fontSize: 15,
          color: Color(0xFF696969),
          fontWeight: FontWeight.w200,
          )),
            ],
          ),
          ElevatedButton(onPressed: (){
            final newstoDelete = FirebaseFirestore.instance.collection('newsArticles').doc(news.id);
            newstoDelete.delete();
          }, child:Text('Delete'))
              ]
             )
        ),
          ),
        );    

Stream<List<News>> readNews() => FirebaseFirestore.instance.collection('newsArticles').snapshots().map(
  (snapshot) {
      for (var doc in snapshot.docs) {
        print(doc.data());  
      }
      return snapshot.docs.map((doc) => News.fromJson(doc.data(), doc.id)).toList();
});

}

class News {
  String id;
  final String title;
  final String description;
  final String url;
  final String author;
  final DateTime publishedAt;

  News({
this.id ='',
required this.title ,
required this.description,
required this.author,
required this.publishedAt ,
required this.url ,
});

static News fromJson(Map<String, dynamic> json, String id) => News(
  id: id,
  title: json['title'],
  description: json['description'],
  url: json['url'],
  author: json['author'],
  publishedAt: (json['publishedAt'] as Timestamp).toDate(),
);

}