import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_state.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/src/ui/category_screen.dart';
import 'package:movies_app/src/ui/movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStarted(0, '')),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu, color: Colors.black45),
          title: Text(
            'Movies Web'.toUpperCase(),
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'muli',
                ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(),
            )
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is MovieLoaded) {
                List<Movie> movies = state.movieList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index, _) {
                        Movie movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailScreen(null, movie),
                                ));
                          },
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/image/img_not_found.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 15,
                                  left: 15,
                                ),
                                child: Text(
                                  movie.title.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'muli',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(microseconds: 1000),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [SizedBox(height: 12), BuildWidgetCategory()],
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Text("Something went wrong"),
                );
              }
            },
          )
        ]),
      ));
    });
  }
}
