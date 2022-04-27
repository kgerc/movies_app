import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/ui/movie_detail_screen.dart';
import 'package:provider/provider.dart';

class MovieItemWidget extends StatelessWidget {
  final String id;
  final String databaseId;
  final String title;
  final String backdropPath;
  final double rating;

  MovieItemWidget(
      this.id, this.databaseId, this.title, this.backdropPath, this.rating);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            var movie = Movie(null, int.parse(id), null, null, null, null, null,
                null, null, null, null, null);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailScreen(null, movie, rating, databaseId),
                ));
          },
          child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/original/${backdropPath}',
              imageBuilder: (context, imageProvider) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
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
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 160,
                height: 180,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.only(top: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'title'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'muli',
                ),
              ),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontSize: 15,
                  fontFamily: 'muli',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'your rating'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'muli',
                ),
              ),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 10,
                itemSize: 19,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
