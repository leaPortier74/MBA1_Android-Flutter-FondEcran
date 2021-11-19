import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fondecran/main.dart';
import 'package:fondecran/unsplash_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class DetailPhoto extends StatelessWidget {

  final UnsplashImage img;
  
  const DetailPhoto (
    { required this.img }
  ) : super();

  _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
      await launch(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.network(
            img.regularUrl, 
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,), 
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
            }),),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: 400.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(img.userProfileImage ?? '', fit: BoxFit.cover,),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(color: Colors.black),
                                      children: [
                                        const TextSpan(text: "Image by "),
                                        TextSpan(text: img.userName, style: const TextStyle(fontWeight: FontWeight.bold))
                                      ]
                                    )
                                  ),
                                ],
                              ),
                              Text(img.description ?? 'No have description for this photo'),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: ElevatedButton(
                                        onPressed: _saveImage,
                                        child: const Text('Download', style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(primary: Colors.black54, fixedSize: const Size(130, 30)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _launchUrl(img.userProfileUrl);
                                        },
                                        child: const Text('Show profile', style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(primary: Colors.transparent, fixedSize: const Size(130, 30)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  _saveImage() async {
  var response = await Dio().get(
         img.regularUrl,
         options: Options(responseType: ResponseType.bytes));
  await ImageGallerySaver.saveImage(
         Uint8List.fromList(response.data),
         quality: 60,);
}

  
}
