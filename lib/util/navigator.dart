import 'package:flutter/material.dart';

/*
goToMovieDetails(BuildContext context, MediaItem movie) {
  MediaProvider provider =
      (movie.type == MediaType.movie) ? MovieProvider() : ShowProvider();
  _pushWidgetWithFade(context, MediaDetailScreen(movie, provider));
}

goToSeasonDetails(BuildContext context, MediaItem show, TvSeason season) =>
    _pushWidgetWithFade(context, SeasonDetailScreen(show, season));

goToActorDetails(BuildContext context, Actor actor) {
  _pushWidgetWithFade(context, ActorDetailScreen(actor));
}

goToSearch(BuildContext context) {
  _pushWidgetWithFade(context, SearchScreen());
}*/
/*
goToFavorites(BuildContext context) {
  _pushWidgetWithFade(context, FavoriteScreen());
}*/

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
        PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return widget;
            }),
      );
}
