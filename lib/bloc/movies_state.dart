part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesPage extends MoviesState {
  final int page;

  const MoviesPage(this.page);

  @override
  List<Object> get props => [page];
}

class MoviesTotalPages extends MoviesState {
  final int pages;
  const MoviesTotalPages(this.pages);

  @override
  List<Object> get props => [pages];
}

class MoviesInitial extends MoviesState {
  final List<Movies> movies = [];
  MoviesInitial();

  @override
  List<Object> get props => [movies];
}

class MoviesListA extends MoviesState {
  final GlobalKey<AnimatedListState> listKey;
  List<Movies> movies = [];
  int page;
  MoviesListA(movies, this.page, this.listKey) {
    print("i called with ${movies.length}");
    Future ft = Future(() {});
    for (var item in movies) {
      ft = ft.then(
        (value) => Future.delayed(
          const Duration(milliseconds: 100),
          () {
            this.movies.add(item);
            listKey.currentState!.insertItem(this.movies.length - 1);
          },
        ),
      );
    }
    print("lenth is ${this.movies.length}");
  }

  //add item to existing list
  addItemToExistingList({required List<Movies> newMovies, required int page}) {
    for (var item in newMovies) {
      movies.add(item);
      listKey.currentState!.insertItem(movies.length - 1);
    }
    this.page = page;
  }

  @override
  List<Object> get props => [movies, page];
}
