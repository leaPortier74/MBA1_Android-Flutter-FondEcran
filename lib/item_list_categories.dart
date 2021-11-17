import 'package:flutter/material.dart';

class ItemListCat extends StatelessWidget {

  final String catUrl;
  
  const ItemListCat (
    { required this.catUrl }
  ) : super();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 10),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(catUrl),
      ),
    );
  }}