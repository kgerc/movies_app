import 'package:equatable/equatable.dart';
import 'package:movies_app/src/models/movie_item.dart';

abstract class MovieItemState extends Equatable {
  const MovieItemState();

  @override
  List<Object> get props => [];
}

class MovieItemLoading extends MovieItemState {}

class MovieItemLoaded extends MovieItemState {
  final List<MovieItem> movieList;
  const MovieItemLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieItemError extends MovieItemState {}
