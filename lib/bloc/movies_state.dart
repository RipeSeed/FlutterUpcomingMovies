part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class LoadingMovies extends MoviesState {}

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
  //final List<Movies> movies;
  //const MoviesInitial(this.movies);
  //@override
  //List<Object> get props => [movies];
}

class MoviesListA extends MoviesState {
  final List<Movies> movies;
  final int page;

  const MoviesListA(this.movies, this.page);

  @override
  List<Object> get props => [movies];
}
