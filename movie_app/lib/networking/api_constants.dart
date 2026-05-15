import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/trailer_model.dart';

class ApiConstants {
  static const apiKey = '04b78d051e507f27149bf325f7356003';
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String trendingDay = '$baseUrl/trending/movie/day?api_key=$apiKey';
  static String upComingMovies = '$baseUrl/trending/movie/week?api_key=$apiKey';
  static String topRatedMovies = '$baseUrl/movie/top_rated?api_key=$apiKey';
  //static String upComingMovies = '$baseUrl/movie/upcoming?api_key=$apiKey';
  static String nowPlayingMovies = '$baseUrl/movie/now_playing?api_key=$apiKey';
}

class Api {
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(ApiConstants.trendingDay));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Something wrong');
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(ApiConstants.topRatedMovies));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Something wrong');
    }
  }

  Future<List<MovieModel>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(ApiConstants.upComingMovies));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Something wrong');
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse(ApiConstants.nowPlayingMovies));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Something wrong');
    }
  }

  Future<TrailerModel> getTrailer(int movieId) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key${ApiConstants.apiKey}',
      ),
    );

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailer');
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/search/movie?api_key=${ApiConstants.apiKey}&query=$encodedQuery',
      ),
    );
    if (query.isEmpty) return [];
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Something wrong');
    }
  }
}
