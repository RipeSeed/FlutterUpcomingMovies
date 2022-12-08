import 'package:animation/api/getMoviesList.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/Movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    // ignore: void_checks
    on<GetFirstPage>((event, emit) async {
      emit(LoadingMovies());
      await getListOfUpcomingMovies(1).then((value) async {
        emit(MoviesListA(value, 2));
      });
    });
    on<GetMoviesList>((event, emit) async {
      final state = this.state as MoviesListA;
      if (kDebugMode) {
        print("state is");
      }
      if (kDebugMode) {
        print(state.page);
      }
      await getListOfUpcomingMovies(state.page).then((value) {
        if (kDebugMode) {
          print("i was here ");
        }
        emit(MoviesListA(
            List.from(state.movies)..addAll(value), state.page + 1));
      });
    });
  }
}
