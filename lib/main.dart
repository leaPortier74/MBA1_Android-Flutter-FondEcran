import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fondecran/unsplash_image.dart';
import 'package:fondecran/unsplash_categories.dart';
import 'package:http/http.dart' as http;

import 'item_list_categories.dart';
import 'item_list_img.dart';

Future<List<UnsplashImage>> fetchImage() async {
  final response = await http
      .get(Uri.parse('https://api.unsplash.com/photos/?client_id=nG1EZPZ93FLgN2I16rZgVDQU8sn9wt2CyBPdhpQ_KYk'));

  if (response.statusCode == 200) {
    return List<UnsplashImage>.from(jsonDecode(response.body).map((img) => UnsplashImage.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<UnsplashCategories>> fetchCategory() async {
  final response = await http
      .get(Uri.parse('https://api.unsplash.com/topics/?client_id=nG1EZPZ93FLgN2I16rZgVDQU8sn9wt2CyBPdhpQ_KYk'));

  if (response.statusCode == 200) {
    return List<UnsplashCategories>.from(jsonDecode(response.body).map((img) => UnsplashCategories.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              /* Container(
                child: FutureBuilder<List<UnsplashCategories>>(
                  future: fetchCategory(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return  ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.map((e) => ItemListCat(catUrl: e.coverPhoto)).toList()
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                      // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ), */
              Container(
                width: double.infinity,
                height: 70,
                child: FutureBuilder<List<UnsplashCategories>>(
                  future: fetchCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.map((e) => ItemListCat(catUrl: e.coverPhoto)).toList()
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                      // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ) ,
              const SizedBox(height: 50.0),
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
                        children: snapshot.data!.map((e) => ItemListImg(url: e.regularUrl)).toList()
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

