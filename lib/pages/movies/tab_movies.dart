import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movies_bloc.dart';
import 'package:flutter_movies_udemy/utils/nav.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:flutter_movies_udemy/widgets/text_error.dart';

import 'movie_page.dart';

class TabMovies extends StatefulWidget {
  @override
  _TabMoviesState createState() => _TabMoviesState();
}

class _TabMoviesState extends State<TabMovies> {
  final _bloc = MoviesBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.moviesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        Response<List<Movie>> response = snapshot.data;

        return response.isOk()
            ? _griView(response.result, context, true)
            : Center(
                child: TextError(response.msg, onRefresh: _onRefreshError,),
              );
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

    return Material(
      child: InkWell(
        child: _img(m.urlFoto),
        onTap: () {
          _onClickMovie(m);
        },
      ),
    );
  }

  _img(img) {
    return Container(
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    );
  }

  void _onClickMovie(Movie m) {
    push(context, MoviePage(m));
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }

  Future<void> _onRefreshError() {
    return _bloc.fetch(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }
}
