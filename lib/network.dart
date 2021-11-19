import 'dart:convert';

import 'package:fondecran/unsplash_image.dart';
import 'package:fondecran/unsplash_categories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'  as DotEnv;
import 'package:flutter_dotenv/flutter_dotenv.dart';


final apiKey = env['SUPER_SECRET_API_KEY'];
final apiUrl = env['API_URL'];

Future<List<UnsplashImage>> fetchImage() async {
  final response = await http
      .get(Uri.parse('$apiUrl/photos/?client_id=$apiKey' ));
  if (response.statusCode == 200) {
    return List<UnsplashImage>.from(jsonDecode(response.body).map((img) => UnsplashImage.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<UnsplashCategories>> fetchCategory() async {
  final response = await http
      .get(Uri.parse('$apiUrl/topics/?client_id=$apiKey'));
  if (response.statusCode == 200) {
    return List<UnsplashCategories>.from(jsonDecode(response.body).map((img) => UnsplashCategories.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<UnsplashImage>> fetchCategoryImages(String url) async {
  final response = await http
      .get(Uri.parse('$url?client_id=$apiKey' ));
  if (response.statusCode == 200) {
    return List<UnsplashImage>.from(jsonDecode(response.body).map((img) => UnsplashImage.fromJson(img)));
  } else {
    throw Exception('Failed to load album');
  }
}