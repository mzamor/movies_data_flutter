import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/src/model/actors_model.dart';
import 'package:movies_app/src/model/movie_model.dart';

class MoviesProvider {
  String _api_key = 'b14cfcf6707108431d0b4ff37ba282d4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popular_page = 0;
  bool _loading = false;
  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _getMovieRequest(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getInCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _api_key,
      'language': _language,
    });
    return await _getMovieRequest(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    _popular_page++;

    if (_loading) return [];

    _loading = true;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _api_key,
      'language': _language,
      'page': _popular_page.toString()
    });

    final res = await _getMovieRequest(url);
    _popular.addAll(res);
    popularSink(_popular);
    _loading = false;
    return res;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url,'3/movie/$movieId/credits', {
      'api_key': _api_key,
      'language': _language,
    });

    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

}
