import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movie_db.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosBloc {
  // progress
  final _progress = BehaviorSubject<bool>();
  get progressStream => _progress.stream;

  // favoritos
  final _flagFavoritos = BehaviorSubject<bool>();
  get getFavoritos => _flagFavoritos.stream;

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

  Future<bool> isFavorito(Movie m) async {
    final db = MovieDB.getInstance();

    final b = await db.exists(m);

    setFavorito(b);

    return b;
  }

  void setFavorito(bool b) {
    _flagFavoritos.sink.add(b);
  }

  Future<bool> favoritar(Movie m) async {
    final db = MovieDB.getInstance();

    final exists = await db.exists(m);

    try {
      if (exists) {
        await db.deleteMovie(m);
        return false;
      } else {
        await db.saveMovie(m);
        return true;
      }
    } finally {

    }
  }

  close() {
    _progress.close();
    _movies.close();
    _flagFavoritos.close();
  }


}
