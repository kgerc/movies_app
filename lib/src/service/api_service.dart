import 'package:movies_app/src/models/movie.dart';
import 'package:dio/dio.dart';

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
}
