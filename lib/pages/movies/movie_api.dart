import 'dart:convert' as convert;

import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:http/http.dart' as http;

class MoviesApi {
  static bool FAKE = false;

  static Future<Response<List<Movie>>> getMovies() async {
    try {
      // await Future.delayed(Duration(seconds: 1));

      final url =
          "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";
      print("> get: $url");

      final response = await http.get(url);
      String json = response.body;

      // Parser
      final map = convert.json.decode(json);
//      print("< json: $map");

      final mapMovies = map["results"];

      List<Movie> movies =
          mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();

      return Response(true, result: movies);
    } catch (error) {
      print("MovieApi error $error");

      return Response(false, msg: "Erro ao carregar os filmes");
    }
  }
}
