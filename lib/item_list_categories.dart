import 'package:flutter/material.dart';
import 'package:fondecran/unsplash_categories.dart';

import 'category_image.dart';

class ItemListCat extends StatelessWidget {

  final UnsplashCategories catUrl;
  final UnsplashCategories catTitle;
  
  const ItemListCat (
    { required this.catUrl, required this.catTitle }
  ) : super();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          // MaterialButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => CategoryImg(catUrl: catUrl, catTitle: catTitle)),
          //     );
          //   },
          //   child: 
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(catUrl.coverPhoto),
            ),
          // ),
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
    );
  }
}