import 'package:animation/api/getMoviesList.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/Movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetFirstPage>((event, emit) {
      getListOfUpcomingMovies(1).then((value) {
        emit(MoviesList(value));
        emit(const MoviesPage(2));
      });
    });
    on<GetMoviesList>((event, emit) {
      final page = this.state as MoviesPage;
      final state = this.state as MoviesList;
      getListOfUpcomingMovies(page.page).then((value) {
        emit(MoviesList(state.movies..addAll(value)));
        emit(MoviesPage(page.page + 1));
      });
    });
  }
}
