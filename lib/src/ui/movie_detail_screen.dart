import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/moviedetailbloc/movie_detail_bloc.dart';
import 'package:movies_app/src/blocs/moviedetailbloc/movie_detail_event.dart';
import 'package:movies_app/src/blocs/moviedetailbloc/movie_detail_state.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/models/movie_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            MovieDetailBloc()..add(MovieDetailEventStarted(movie.id)),
        child: WillPopScope(
          child: Scaffold(
            body: _buildDetailBody(context),
          ),
          onWillPop: () async => true,
        ));
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoading) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is MovieDetailLoaded) {
        MovieDetail movieDetail = state.detail;
        return Stack(
          children: [
            ClipPath(
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/img_not_found.jpg'),
                      ),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 120),
                  child: GestureDetector(
                    onTap: () async {
                      final youtubeUrl =
                          'https://www.youtube.com/embed/${movieDetail.trailerId}';
                      if (await canLaunch(youtubeUrl)) {
                        await launch(youtubeUrl);
                      }
                    },
                    child: Center(
                        child: Column(
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          color: Colors.yellow,
                          size: 65,
                        ),
                        Text(
                          movieDetail.title!.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'muli'),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )),
                  ),
                ),
              ],
            )
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
