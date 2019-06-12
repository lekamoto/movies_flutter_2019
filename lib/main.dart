import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_movies_udemy/pages/login/login_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_movies_udemy/pages/movies/movies_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => MoviesBloc()),
        Bloc((i) => FavoritosBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: LoginPage(),
      ),
    );
  }
}
