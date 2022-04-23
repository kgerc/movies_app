import 'package:movies_app/src/models/movie_image.dart';

class MovieDetail {
  final String? id;
  final String? title;
  final String? backdropPath;
  final String? budget;
  final String? homePage;
  final String? originalTitle;
  final String? overview;
  final String? releaseDate;
  final String? runtime;
  final String? voteAverage;
  final String? voteCount;

  String? trailerId;
  MovieImage? movieImage;

  MovieDetail(
      this.id,
      this.title,
      this.backdropPath,
      this.budget,
      this.homePage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.voteAverage,
      this.voteCount);

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      throw Exception("Data cannot be retrieved");
    }

    return MovieDetail(
        json['id']?.toString(),
        json['title'],
        json['backdrop_path'],
        json['budget']?.toString(),
        json['home_page'],
        json['original_title'],
        json['overview'],
        json['release_date'],
        json['runtime']?.toString(),
        json['vote_average']?.toString(),
        json['vote_count']?.toString());
  }
}
