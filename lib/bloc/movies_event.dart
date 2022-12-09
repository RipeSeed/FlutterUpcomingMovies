part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesList extends MoviesEvent {
  final GlobalKey<AnimatedListState> listKey;

  const GetMoviesList({required this.listKey});

  @override
  List<Object> get props => [listKey];
}

class GetFirstPage extends MoviesEvent {
  final GlobalKey<AnimatedListState> listKey;

  const GetFirstPage({required this.listKey});

  @override
  List<Object> get props => [listKey];
}
