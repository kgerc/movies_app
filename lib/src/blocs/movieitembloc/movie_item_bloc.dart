import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/src/blocs/movieitembloc/movie_item__bloc_event.dart';
import 'package:movies_app/src/blocs/movieitembloc/movie_item_bloc_state.dart';
import 'package:movies_app/src/models/movie_item.dart';
import 'package:movies_app/src/service/api_service.dart';

class MovieItemBloc extends Bloc<MovieItemEvent, MovieItemState> {
  MovieItemBloc() : super(MovieItemLoading());

  @override
  Stream<MovieItemState> mapEventToState(MovieItemEvent event) async* {
    if (event is MovieItemEventStarted) {
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<MovieItemState> _mapMovieEventStateToState() async* {
    final service = ApiService();
    yield MovieItemLoading();
    try {
      List<MovieItem> movieList = [];
      movieList = await service.getMoviesFromDb();
      yield MovieItemLoaded(movieList);
    } on Exception catch (e) {
      yield MovieItemError();
    }
  }
}
