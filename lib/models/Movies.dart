// To parse this JSON data, do
//
//     final Movies = MoviesFromJson(jsonString);

import 'dart:convert';

List<Movies>? MoviesFromJson(String str) {
  try {
    return List<Movies>.from(
      json.decode(str).map((x) => Movies.fromJson(x)),
    );
  } catch (e) {
    print("Exception is ${e}");
    return null;
  }
}

String MoviesToJson(List<Movies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movies {
  Movies({
    required this.adult,
     this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    required this.popularity,
     this.posterPath,
    required this.releaseDate,
    this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  String? title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
