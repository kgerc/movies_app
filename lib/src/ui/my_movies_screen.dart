import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/movieitembloc/movie_item__bloc_event.dart';
import 'package:movies_app/src/blocs/movieitembloc/movie_item_bloc.dart';
import 'package:movies_app/src/blocs/movieitembloc/movie_item_bloc_state.dart';
import 'package:movies_app/src/models/movie_item.dart';
import 'package:movies_app/src/service/api_service.dart';
import 'package:movies_app/src/ui/app_drawer.dart';
import 'package:movies_app/src/ui/movie_detail_screen.dart';
import 'package:movies_app/src/ui/movie_item_widget.dart';

class MyMoviesScreen extends StatelessWidget {
  final apiRepository = ApiService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieItemBloc>(
          create: (_) => MovieItemBloc()..add(MovieItemEventStarted(0, '')),
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
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<MovieItemBloc, MovieItemState>(
      builder: (context, state) {
        if (state is MovieItemLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is MovieItemLoaded) {
          List<MovieItem> movies = state.movieList;
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              itemBuilder: (_, i) => Column(
                children: [
                  MovieItemWidget(
                      movies[i].id.toString(),
                      movies[i].databaseId,
                      movies[i].title,
                      movies[i].backdropPath,
                      movies[i].rating),
                  Divider(),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Text("No movies found"),
          );
        }
      },
    );
  }
}
