import 'package:animation/api/getMoviesList.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/Movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetFirstPage>((event, emit) async {
      //event.listKey.currentState!.insertItem(0);
      await getListOfUpcomingMovies(1).then((value) async {
        emit(MoviesListA(value, 2, event.listKey));
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
      List<Movies> m = List.from(state.movies);
      await getListOfUpcomingMovies(state.page).then((value) {
        state.addItemToExistingList(newMovies: value, page: state.page + 1);
      });
    });
  }
}
