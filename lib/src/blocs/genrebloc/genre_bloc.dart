import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/genrebloc/genre_event.dart';
import 'package:movies_app/src/blocs/genrebloc/genre_state.dart';
import 'package:movies_app/src/models/genre.dart';
import 'package:movies_app/src/service/api_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<GenreState> _mapMovieEventStateToState() async* {
    final service = ApiService();
    yield GenreLoading();
    try {
      List<Genre> genreList = await service.getGenreList();

      yield GenreLoaded(genreList);
    } on Exception catch (e) {
      print(e);
      yield GenreError();
    }
  }
}
