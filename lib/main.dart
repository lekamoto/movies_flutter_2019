import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/login/login_bloc.dart';
import 'package:flutter_movies_udemy/pages/login/login_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //Bloc((i) => LoginBloc()),
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
