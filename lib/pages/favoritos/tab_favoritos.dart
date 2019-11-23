import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movie_page.dart';
import 'package:flutter_movies_udemy/utils/nav.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:flutter_movies_udemy/widgets/text_empty.dart';
import 'package:flutter_movies_udemy/widgets/text_error.dart';

class TabFavoritos extends StatefulWidget {
  @override
  _TabFavoritosState createState() => _TabFavoritosState();
}

class _TabFavoritosState extends State<TabFavoritos>
    with AutomaticKeepAliveClientMixin<TabFavoritos> {
  @override
  bool get wantKeepAlive => true;

  FavoritosBloc get favoritosBloc => BlocProvider.getBloc<FavoritosBloc>();

  @override
  void initState() {
    super.initState();

    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Movie> movies = snapshot.data.documents
            .map<Movie>((document) => Movie.fromJson(document.data) )
            .toList();

        return _griView(movies, context, true);
      },
    );
  }

  _griView(List<Movie> movies, context, gridOn) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: gridOn
          ? GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _item(movies, index, context);
              },
            )
          : ListView.builder(
              itemExtent: 600,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _item(movies, index, context);
              },
            ),
    );
  }

  _item(List<Movie> movies, index, context) {
    Movie m = movies[index];

    // Tag para a animação do Hero
    m.tag = m.title + "-fav";

    return Material(
      child: InkWell(
        child: Hero(
          tag: m.tag,
          child: Image.network(
            m.urlFoto,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          _onClickMovie(m);
        },
      ),
    );
  }

  void _onClickMovie(Movie m) {
    push(context, MoviePage(m));
  }

  Future<void> _onRefresh() {
    return favoritosBloc.fetch();
  }

  Future<void> _onRefreshError() {
    return favoritosBloc.fetch(isRefresh: true);
  }
}
