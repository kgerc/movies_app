class MovieItem {
  final String backdropPath;
  final int id;
  final String title;
  final double rating;

  String? error;

  MovieItem(this.backdropPath, this.id, this.title, this.rating);

  factory MovieItem.fromJson(dynamic json) {
    if (json == null) {
      throw Exception("Data cannot be retrieved");
    }

    return MovieItem(
        json['backdrop_path'], json['id'], json['title'], json['rating']);
  }
}
