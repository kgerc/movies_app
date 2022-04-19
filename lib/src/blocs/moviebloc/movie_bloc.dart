import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_state.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/service/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = ApiService();
    yield MovieLoading();
    try {
      List<Movie> movieList = [];
      if (movieId == 0) {
        movieList = await service.getNowPlayingMovie();
      }
      print('Movie list $movieList');
      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      yield MovieError();
    }
  }
}
