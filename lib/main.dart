import 'package:flutter/material.dart';
import 'package:fondecran/category_image.dart';
import 'package:fondecran/unsplash_image.dart';
import 'package:fondecran/unsplash_categories.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'  as DotEnv;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fondecran/network.dart';
import 'item_list_categories.dart';
import 'item_list_img.dart';

Future main() async {
  await DotEnv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
late Future<List<UnsplashImage>> futureImage;

late Future<List<UnsplashCategories>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage();
    futureCategory = fetchCategory();
  }


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
                width: double.infinity,
                height: 100,
                child: FutureBuilder<List<UnsplashCategories>>(
                  future: fetchCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.map((e) => ItemListCat(catUrl: e, catTitle: e, fun: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryImg(catTitle: e, photoList: fetchCategoryImages(e.listPhotos), catUrl: e,)));
                        })).toList()
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                      // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ) ,
              Container(
                width: double.infinity,
                height: 685,
                child: FutureBuilder<List<UnsplashImage>>(
                  future: fetchImage(),
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
            ]
          ),
        )
      )
    );
  }
}