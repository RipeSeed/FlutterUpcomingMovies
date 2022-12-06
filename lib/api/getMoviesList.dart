import 'dart:convert';

import 'package:animation/models/Movies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<Movies>> getListOfUpcomingMovies() async {
  var url = "${dotenv.env["API_URL"]}3/movie/upcoming?api_key=${dotenv.env["API_KEY"]}";
  final uu = Uri.parse(url);
  print(uu);

  var response = await http.get(Uri.parse(url));
  print(response.statusCode);
  List<Movies> movies = [];
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    List<dynamic> list = result["results"];
    for (var element in list) {
      movies.add(Movies.fromJson(element));
    }
    print(movies);
  } else {
    print(response.statusCode);
  }
  return movies;
}
