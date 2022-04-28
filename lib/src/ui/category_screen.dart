import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/genrebloc/genre_bloc.dart';
import 'package:movies_app/src/blocs/genrebloc/genre_event.dart';
import 'package:movies_app/src/blocs/genrebloc/genre_state.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_state.dart';
import 'package:movies_app/src/models/genre.dart';
import 'package:movies_app/src/models/movie.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategory({Key? key, this.selectedGenre = 28})
      : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  late int selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext conte) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(
          create: (_) => GenreBloc()..add(GenreEventStarted()),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStarted(selectedGenre, '')),
        ),
      ],
      child: _buildGenre(context),
    );
  }

  Widget _buildGenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            if (state is GenreLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is GenreLoaded) {
              List<Genre> genres = state.genreList;
              return Container(
                height: 45,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    Genre genre = genres[index];
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Genre genre = genres[index];
                              print("genre $genre");
                              selectedGenre = genre.id;
                              print("selc genre $selectedGenre");
                              context
                                  .read<MovieBloc>()
                                  .add(MovieEventStarted(selectedGenre, ''));
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: (genre.id == selectedGenre)
                                  ? Colors.black45
                                  : Colors.white,
                            ),
                            child: Text(
                              genre.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (genre.id == selectedGenre)
                                    ? Colors.white
                                    : Colors.black45,
                                fontFamily: 'muli',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            'new playing'.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontFamily: 'muli',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Center();
            } else if (state is MovieLoaded) {
              List<Movie> movieList = state.movieList;
              Movie movieListitem = state.movieList[0];
              print("movie list $movieList");
              print("movie list item $movieListitem");
              return Container(
                height: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    Movie movie = movieList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 160,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) => Container(
                              width: 160,
                              height: 180,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 160,
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img_not_found.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 160,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(
                                movie.voteAverage!,
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
