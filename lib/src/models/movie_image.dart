import 'package:equatable/equatable.dart';
import 'package:movies_app/src/models/screenshot.dart';

class MovieImage extends Equatable {
  final List<Screenshot> backdrops;
  final List<Screenshot> posters;

  const MovieImage(this.backdrops, this.posters);

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    if (result == null) {
      throw Exception("Data cannot be retrieved");
    }

    return MovieImage(
      (result['backdrops'] as List).map((b) => Screenshot.fromJson(b)).toList(),
      (result['posters'] as List).map((b) => Screenshot.fromJson(b)).toList(),
    );
  }

  @override
  List<Object> get props => [backdrops, posters];
}
