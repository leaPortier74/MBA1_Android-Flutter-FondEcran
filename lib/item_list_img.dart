import 'package:flutter/material.dart';

class ItemListImg extends StatelessWidget {

  final String url;
  
  const ItemListImg (
    { required this.url }
  ) : super();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child : Card(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image : NetworkImage(url),
              fit: BoxFit.cover
            )
          ),
          child: MaterialButton(
            onPressed: () { 
              
            },
          )
        ),
      )
    );
  }}