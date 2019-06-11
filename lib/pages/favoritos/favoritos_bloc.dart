import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movie_db.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:rxdart/rxdart.dart';


class FavoritosBloc {
  // progress
  final _progressController = BehaviorSubject<bool>();

  get progressStream => _progressController.stream;

  // stream
  final _moviesController = BehaviorSubject<Response<List<Movie>>>();

  get moviesStream => _moviesController.stream;

  Future fetch({bool isRefresh = false}) async {
    _progressController.sink.add(true);

    try {
      if (isRefresh) {
        _moviesController.sink.add(null);
      }

      final db = MovieDB.getInstance();
      final list = await db.getMovies();
      print("get db movies ${list.length}");
      final movies = Response(true, result: list);

      _moviesController.sink.add(movies);

      return movies;
    } finally {
      _progressController.sink.add(false);
    }
  }

  Future<bool> favoritar(Movie m) async {
    final db = MovieDB.getInstance();

    final exists = await db.exists(m);

    try {
      if (exists) {
        int count = await db.getCount();
        print(count);
        await db.deleteMovie(m);
        final movies = await db.getMovies();
        print(movies.length);
        return false;
      } else {
        await db.saveMovie(m);
        return true;
      }
    } finally {

    }
  }

  close() {
    _progressController.close();
    _moviesController.close();
  }
}
