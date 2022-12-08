import 'package:animation/api/getMoviesList.dart';
import 'package:animation/bloc/movies_bloc.dart';
import 'package:animation/models/Movies.dart';
import 'package:animation/screens/details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:intl/intl.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  List<Movies> movieList = [];
  int page = 1;
  bool loadingFlag = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesBloc>().add(GetFirstPage());
    });

    //getMoviesData();
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
            movie.title == null ? "No Titile" : movie.title!,
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
          child: movie.posterPath == null
              ? const Icon(
                  Icons.movie,
                  size: 50,
                )
              : Image.network(dotenv.env["IMAGE_URL"]! + movie.posterPath!,
                  height: 50.0, width: 50.0, scale: 1.5, fit: BoxFit.cover),
        ),
      ),
      trailing: SizedBox(
        height: 100,
        width: 55,
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

  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesListA) {
        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isTop = metrics.pixels == 0;
              if (isTop) {
                if (kDebugMode) {
                  print('At the top');
                }
              } else {
                if (!loadingFlag) {
                  context.read<MoviesBloc>().add(GetMoviesList());
                }
                if (kDebugMode) {
                  print('At the bottom');
                }
              }
            }
            return true;
          },
          child: AnimatedList(
            key: _listKey,
            initialItemCount: (state).movies.length,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: animation.drive(_offset),
                child: _buildTile((state).movies[index]),
              );
            },
          ),
        );
        } else {
          return const Center(child: Text("hello there"));
        }
      },
    );
  }

  // void getMoviesData() async {
  //   getListOfUpcomingMovies(page).then((value) {
  //     setState(() {
  //       loadingFlag = false;
  //       movieList.addAll(value);
  //     });
  //   });
  // }
}
