import 'package:animation/api/getMoviesList.dart';
import 'package:animation/models/Movies.dart';
import 'package:animation/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  List<Movies> movieList = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getMoviesData();
  }

  Widget _buildTile(Movies movie) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              movie: movie,
            ),
          ),
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Coming in ${DateFormat("yyyy-MM-dd").format(movie.releaseDate)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue[300],
            ),
          ),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: "image${movie.title}",
          child: Image.network(dotenv.env["IMAGE_URL"]! + movie.posterPath,
              height: 50.0, width: 50.0, scale: 1.5, fit: BoxFit.cover),
        ),
      ),
      trailing: SizedBox(
        height: 100,
        width: 50,
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Color.fromARGB(255, 255, 206, 100),
            ),
            Text('${movie.voteAverage}')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: _listKey,
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        return _buildTile(movieList[index]);
      },
    );
  }

  void getMoviesData() async {
    getListOfUpcomingMovies().then((value) {
      setState(() {
        movieList = value;
      });
    });
  }
}
