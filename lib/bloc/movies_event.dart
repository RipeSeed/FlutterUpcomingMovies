part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesList extends MoviesEvent {
  final List<Movies> movies;

  const GetMoviesList({required this.movies});

  @override
  List<Object> get props => [movies];
}

class GetFirstPage extends MoviesEvent {}
