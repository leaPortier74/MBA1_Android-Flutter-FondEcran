import 'package:flutter/material.dart';
import 'package:fondecran/unsplash_image.dart';

import 'details_photos.dart';

class ItemListImg extends StatelessWidget {

  final UnsplashImage img;
  
  const ItemListImg (
    { required this.img }
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
              image : NetworkImage(img.regularUrl),
              fit: BoxFit.cover
            )
          ),
          child: MaterialButton(
            onPressed: () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPhoto(img: img,)),
              );
            },
          )
        ),
      )
    );
  }}