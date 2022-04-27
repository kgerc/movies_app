import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String backdropPath;
  final double rating;

  MovieItemWidget(this.id, this.title, this.backdropPath, this.rating);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Row(
      children: <Widget>[
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/original/${backdropPath}',
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
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'muli',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
