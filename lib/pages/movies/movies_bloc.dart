import 'package:flutter_movies_udemy/pages/movies/movie_api.dart';
import 'package:flutter_movies_udemy/pages/movies/movie_db.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:rxdart/rxdart.dart';

import 'movie.dart';

class MoviesBloc {
  // progress
  final _progressController = BehaviorSubject<bool>();

  get progressStream => _progressController.stream;

  // stream
  final _moviesController = BehaviorSubject<Response<List<Movie>>>();

  get moviesStream => _moviesController.stream;

  Future fetch(bool modeFavoritos, {bool isRefresh = false}) async {
    _progressController.sink.add(true);

    try {
      if (isRefresh) {
        _moviesController.sink.add(null);
      }

      Response<List<Movie>> movies;

      if (modeFavoritos) {
        final db = MovieDB.getInstance();
        final list = await db.getMovies();
        movies = Response(true, result: list);
      } else {
        movies = await MoviesApi.getMovies();
      }

      _moviesController.sink.add(movies);

      return movies;
    } finally {
      _progressController.sink.add(false);
    }
  }

  Future<bool> favoritar(Movie m) async {
    final db = MovieDB.getInstance();

    final exists = await db.exists(m);

    if (exists) {
      db.deleteMovie(m);
      return false;
    } else {
      await db.saveMovie(m);
      return true;
    }
  }

  close() {
    _progressController.close();
    _moviesController.close();
  }
}
