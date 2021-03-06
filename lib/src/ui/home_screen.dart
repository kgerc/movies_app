import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/src/blocs/moviebloc/movie_bloc_state.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/src/service/api_service.dart';
import 'package:movies_app/src/ui/app_drawer.dart';
import 'package:movies_app/src/ui/category_screen.dart';
import 'package:movies_app/src/ui/movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  String searchQuery = "";
  final apiRepository = ApiService();
  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = new TextEditingController();
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
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.black45),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Container(
            child: Center(
              child: TextField(
                controller: searchBarController,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        final movie = await apiRepository
                            .searchMovie(searchBarController.text);
                        if (movie.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red[600],
                              content: Text(movie.error!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                                  textAlign: TextAlign.center),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(null, movie, null, null),
                              ));
                        }
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchBarController.text = "";
                      },
                    ),
                    hintText: 'Find a movie...',
                    border: InputBorder.none),
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.yellow[800],
                child: const Text('KG'),
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
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
                                  builder: (context) => MovieDetailScreen(
                                      null, movie, null, null),
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
                                  movie.title!.toUpperCase(),
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
