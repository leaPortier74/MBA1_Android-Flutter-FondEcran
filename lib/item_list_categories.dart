import 'package:flutter/material.dart';

class ItemListCat extends StatelessWidget {

  final String catUrl;
  final String catTitle;
  
  const ItemListCat (
    { required this.catUrl, required this.catTitle }
  ) : super();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(catUrl),
          ),
          const SizedBox(height: 5,),
          Text(
            catTitle, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            )
          ),
        ]
      )
    );
  }}