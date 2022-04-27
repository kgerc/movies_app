import 'package:equatable/equatable.dart';

abstract class MovieItemEvent extends Equatable {
  const MovieItemEvent();
}

class MovieItemEventStarted extends MovieItemEvent {
  final int movieId;
  final String query;

  const MovieItemEventStarted(this.movieId, this.query);

  @override
  List<Object> get props => [];
}
