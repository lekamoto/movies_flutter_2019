import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/home/drawer.dart';
import 'package:flutter_movies_udemy/pages/login/login_page.dart';
import 'package:flutter_movies_udemy/pages/movies/tab_movies.dart';
import 'package:flutter_movies_udemy/utils/nav.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _onClickLogout(context),
            )
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: "Filmes",
              icon: Icon(Icons.movie),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            )
          ]),
        ),
        body: TabBarView(children: [
          TabMovies(),
          Container(
            color: Colors.orange,
          )
        ]),
        drawer: DrawerMenu(),
      ),
    );
  }

  _onClickLogout(context) {
    pushReplacement(context, LoginPage());
  }
}
