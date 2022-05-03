class Movie {
  final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final int? voteCount;
  final String? voteAverage;

  String? error;

  Movie(
      this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount,
      this.voteAverage);

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      throw Exception("Data cannot be retrieved");
    }
    return Movie(
        json['backdrop_path'],
        json['id'],
        json['original_language'],
        json['original_title'],
        json['overview'],
        json['popularity'],
        json['poster_path'],
        json['release_date'],
        json['title'],
        json['video'],
        json['vote_count'],
        json['vote_average']?.toString());
  }
}
