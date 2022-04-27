class MovieItem {
  final String databaseId;
  final String backdropPath;
  final int id;
  final String title;
  final double rating;

  String? error;

  MovieItem(
      this.databaseId, this.backdropPath, this.id, this.title, this.rating);
}
