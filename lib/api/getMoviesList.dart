import 'dart:convert';

import 'package:animation/models/Movies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<Movies>> getListOfUpcomingMovies(int page) async {
  final listKey = GlobalKey<AnimatedListState>();
  var url =
      "${dotenv.env["API_URL"]}3/movie/upcoming?api_key=${dotenv.env["API_KEY"]}&&page=$page";
  final uu = Uri.parse(url);
  if (kDebugMode) {
    print(uu);
  }

  var response = await http.get(Uri.parse(url));
  List<Movies> movies = [];
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    List<dynamic> list = result["results"];
    for (var element in list) {
      Movies toAdd = Movies.fromJson(element);
      // ignore: unnecessary_null_comparison
      if (toAdd == null) {
      } else {
        movies.add(toAdd);
        // if (kDebugMode) {
        //   print(listKey);
        // }
        // listKey.currentState!.insertItem(
        //   list.length - 1,
        // );
      }
    }
  } else {
    print(response.statusCode);
  }
  return movies;
}
