import 'package:animation/models/Movies.dart';
import 'package:animation/shared/heart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Details extends StatelessWidget {
  final Movies movie;
  const Details({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
                child: Hero(
              tag: "image${movie.title}",
              child: Image.network(
                dotenv.env["IMAGE_URL"]! + movie.posterPath,
                height: 360,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            )),
            const SizedBox(height: 30),
            ListTile(
                title: Text(
                  movie.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[800]),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Movie have ',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      TextSpan(
                        text: '${movie.voteAverage}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 206, 100)),
                      ),
                      TextSpan(
                        text: " rating on IMDb",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                trailing: Heart()),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                movie.overview,
                style: TextStyle(color: Colors.grey[600], height: 1.4),
              ),
            ),
          ],
        ));
  }
}
