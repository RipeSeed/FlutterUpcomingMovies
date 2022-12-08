import 'package:animation/bloc/movies_bloc.dart';
import 'package:animation/screens/home.dart';
import 'package:animation/screens/playGround.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => MoviesBloc())),
      ],
      child: const MaterialApp(
        title: 'UpcomingMovies',
        home: Home(),
      ),
    );
  }
}
