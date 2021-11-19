import 'package:flutter/material.dart';
import 'package:fondecran/unsplash_categories.dart';


class CategoryImg extends StatelessWidget {

  final UnsplashCategories catUrl;
  final UnsplashCategories catTitle;
  
  const CategoryImg (
    { required this.catUrl, required this.catTitle }
  ) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 100.0,
                margin: const EdgeInsets.only(
                  top: 0.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle,
                ),
                child: Image.network(catUrl.coverPhoto)
              ),
              const SizedBox(height: 10,),
              Text(
                catTitle.title, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                )
              ),
              const SizedBox(height: 20,),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                children : [
                  Card(
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image : NetworkImage(catUrl.listPhotos),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }
}
