import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movie_db.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosBloc {
  // progress
  final _progress = BehaviorSubject<bool>();
  get progressStream => _progress.stream;

  // stream
  final _movies = BehaviorSubject<Response<List<Movie>>>();
  get moviesStream => _movies.stream;

  Future fetch({bool isRefresh = false}) async {
    _progress.sink.add(true);

    try {
      if (isRefresh) {
        _movies.sink.add(null);
      }

      final db = MovieDB.getInstance();
      final list = await db.getMovies();
      final movies = Response(true, result: list);

      _movies.sink.add(movies);

      return movies;
    } finally {
      _progress.sink.add(false);
    }
  }

  close() {
    _progress.close();
    _movies.close();
  }
}
