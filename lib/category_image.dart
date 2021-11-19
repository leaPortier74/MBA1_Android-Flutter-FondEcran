import 'package:flutter/material.dart';
import 'package:fondecran/item_list_img.dart';
import 'package:fondecran/unsplash_categories.dart';
import 'package:fondecran/unsplash_image.dart';


class CategoryImg extends StatelessWidget {

  final Future<List<UnsplashImage>> photoList;
  final UnsplashCategories catTitle;
  final UnsplashCategories catUrl;
  
  const CategoryImg (
    { required this.photoList, required this.catTitle, required this.catUrl }
  ) : super();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              Container(
                width: width,
                height: height*0.71,
                child: FutureBuilder<List<UnsplashImage>>(
                  future: photoList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        children: snapshot.data!.map((e) => ItemListImg(img: e)).toList()
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                      // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ) 
            ],
          )
        )
      )
    );
  }
}
