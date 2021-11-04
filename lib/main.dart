import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UnsplashImage> fetchImage() async {
  final response = await http
      .get(Uri.parse('https://api.unsplash.com/photos/random?client_id=nG1EZPZ93FLgN2I16rZgVDQU8sn9wt2CyBPdhpQ_KYk'));

  if (response.statusCode == 200) {
    return UnsplashImage.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
class UnsplashImage{
  String id;
  String? description;
  String regularUrl;
  String fullUrl;
  String rawUrl; //For downloading image only
  String userName; //Attribution to the photographer
  String userProfileUrl; //Photographer's profile
  String userProfileImage; //Photographer's profile image
  int likes;
  String? blurHash; //Optional
  String? downloadLocation; //Optional
  Color? color; //Optional

  UnsplashImage({
    required this.id,
    required this.description,
    required this.regularUrl,
    required this.fullUrl,
    required this.rawUrl,
    required this.userName,
    required this.userProfileUrl,
    required this.userProfileImage,
    required this.likes,
    required this.blurHash,
    required this.downloadLocation,
    required this.color,
  });

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      id: json['id'],
      description: json['description'],
      regularUrl: json['urls']['regular'],
      fullUrl: json['urls']['full'],
      rawUrl: json['urls']['raw'],
      userName: json['user']['name'],
      userProfileUrl: json['user']['links']['self'],
      userProfileImage: json['user']['profile_image']['small'],
      likes: json['likes'],
      blurHash: json['blur_hash'],
      downloadLocation: json['title'],
      color: json['color'],
    );
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
  
late Future<UnsplashImage> futureImage;

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage();
  }

  List<UnsplashImage> imageUrlListToDisplay = [
    



    // "https://picsum.photos/id/1005/800/800",
    // "https://picsum.photos/id/1004/800/800",
    // "https://picsum.photos/id/1000/800/800",
    // "https://picsum.photos/id/1005/800/800",
    // "https://picsum.photos/id/1004/800/800",
    // "https://picsum.photos/id/1000/800/800",
    // "https://picsum.photos/id/1005/800/800",
    // "https://picsum.photos/id/1004/800/800",
    // "https://picsum.photos/id/1000/800/800",
    // "https://picsum.photos/id/1005/800/800",
    // "https://picsum.photos/id/1004/800/800",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Text("Home"),
      ),
      body: SafeArea(
        child: FutureBuilder<UnsplashImage>(
            future: futureImage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.id);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
      //   child: Container(
      //     child: GridView.count(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10,
      //       children: imageUrlListToDisplay
      //         .map((item) => Card(
      //           color: Colors.transparent,
      //           elevation: 0,
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: MaterialButton(
      //               onPressed: () { 

      //                },
      //               child: Image.network(
      //                 item,
      //               )
      //             ),
      //           ),
      //         ))
      //       .toList(),
      // ))
      ),
    );
  }
}

