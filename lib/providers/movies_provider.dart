import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '8778b13fa20ce000337921ac02afb855';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    print("provider inicializado");
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async{
    print("getOnDisplayMovies");
    var url =
      Uri.https(_baseUrl, '/3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }
  getPopularMovies() async{
    print("getPopularMovies");
    var url =
      Uri.https(_baseUrl, '/3/movie/popular', {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      });
    final result = await http.get(url);
    final popularResponse = NowPlayingResponse.fromJson(result.body);
    popularMovies = popularResponse.results;
  }
}