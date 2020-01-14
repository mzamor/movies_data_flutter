import 'dart:convert';

import 'package:movies_app/src/model/movie_model.dart';

import 'package:http/http.dart' as http;

class MoviesProvider{
  String _api_key = 'b14cfcf6707108431d0b4ff37ba282d4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _getMovieRequest(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

    Future<List<Movie>> getInCinema() async{
      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key': _api_key,
        'language': _language
      });
      return await _getMovieRequest(url);
    }

  Future<List<Movie>> getPopularMovies() async{
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _api_key,
      'language': _language
    });
    return await _getMovieRequest(url);
  }
}