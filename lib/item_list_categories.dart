import 'package:flutter/material.dart';
import 'package:fondecran/unsplash_categories.dart';

class ItemListCat extends StatelessWidget {

  final UnsplashCategories catUrl;
  final UnsplashCategories catTitle;
  final VoidCallback fun;
  
  const ItemListCat (
    { required this.catUrl, required this.catTitle, required this.fun }
  ) : super();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fun();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(catUrl.coverPhoto),
            ),
            const SizedBox(height: 5,),
            Text(
              catTitle.title, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              )
            ),
          ]
        )
      )
    );
  }
}