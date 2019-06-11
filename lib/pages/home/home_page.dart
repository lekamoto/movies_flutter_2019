import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/events/events.dart';
import 'package:flutter_movies_udemy/pages/favoritos/tab_favoritos.dart';
import 'package:flutter_movies_udemy/pages/home/drawer.dart';
import 'package:flutter_movies_udemy/pages/login/login_page.dart';
import 'package:flutter_movies_udemy/pages/movies/tab_movies.dart';
import 'package:flutter_movies_udemy/utils/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("build home");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Filmes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _onClickLogout(context),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "Filmes",
              icon: Icon(Icons.movie),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TabMovies(),
          TabFavoritos(),
        ],
      ),
      drawer: DrawerMenu(),
    );
  }

  _onClickLogout(context) {
    pushReplacement(context, LoginPage());
  }
}
