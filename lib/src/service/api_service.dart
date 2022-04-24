import 'package:movies_app/src/models/genre.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/src/models/movie_detail.dart';
import 'package:movies_app/src/models/movie_image.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=9d1c050a146a1e8b2f9f5367d66691c9';
  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final response = await _dio.get('$baseUrl/movie/now_playing?$apiKey');
      print('Response $response');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stackTrace) {
      throw Exception(
          'Exception occured: $error with stack trace: $stackTrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      print('movieid $movieId');
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      print('reponse data $response');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);
      movieDetail.trailerId = await getYoutubeId(movieId);
      movieDetail.movieImage = await getMovieImage(movieId);
      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<Movie> searchMovie(String searchString) async {
    try {
      final url = '$baseUrl/search/movie?query=$searchString&$apiKey';
      print("movieSearch url $url");
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      if (movies.length > 0) {
        return Movie.fromJson(movies[0]);
      } else {
        throw Exception('Movie not found');
      }
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
