// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:imdumb/features/home/presentation/home_screen.dart' as _i1;
import 'package:imdumb/features/movie_detail/presentation/movie_detail_screen.dart'
    as _i2;
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart'
    as _i7;
import 'package:imdumb/features/movies_list/presentation/movies_list_screen.dart'
    as _i3;
import 'package:imdumb/features/splash/presentation/splash_screen.dart' as _i4;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i1.HomeScreen());
    },
  );
}

/// generated route for
/// [_i2.MovieDetailScreen]
class MovieDetailRoute extends _i5.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i6.Key? key,
    required int movieId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         MovieDetailRoute.name,
         args: MovieDetailRouteArgs(key: key, movieId: movieId),
         initialChildren: children,
       );

  static const String name = 'MovieDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailRouteArgs>();
      return _i5.WrappedRoute(
        child: _i2.MovieDetailScreen(key: args.key, movieId: args.movieId),
      );
    },
  );
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({this.key, required this.movieId});

  final _i6.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movieId: $movieId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieDetailRouteArgs) return false;
    return key == other.key && movieId == other.movieId;
  }

  @override
  int get hashCode => key.hashCode ^ movieId.hashCode;
}

/// generated route for
/// [_i3.MoviesListScreen]
class MoviesListRoute extends _i5.PageRouteInfo<MoviesListRouteArgs> {
  MoviesListRoute({
    _i6.Key? key,
    required _i7.MovieListType type,
    int? genreId,
    String? genreName,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         MoviesListRoute.name,
         args: MoviesListRouteArgs(
           key: key,
           type: type,
           genreId: genreId,
           genreName: genreName,
         ),
         initialChildren: children,
       );

  static const String name = 'MoviesListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MoviesListRouteArgs>();
      return _i5.WrappedRoute(
        child: _i3.MoviesListScreen(
          key: args.key,
          type: args.type,
          genreId: args.genreId,
          genreName: args.genreName,
        ),
      );
    },
  );
}

class MoviesListRouteArgs {
  const MoviesListRouteArgs({
    this.key,
    required this.type,
    this.genreId,
    this.genreName,
  });

  final _i6.Key? key;

  final _i7.MovieListType type;

  final int? genreId;

  final String? genreName;

  @override
  String toString() {
    return 'MoviesListRouteArgs{key: $key, type: $type, genreId: $genreId, genreName: $genreName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MoviesListRouteArgs) return false;
    return key == other.key &&
        type == other.type &&
        genreId == other.genreId &&
        genreName == other.genreName;
  }

  @override
  int get hashCode =>
      key.hashCode ^ type.hashCode ^ genreId.hashCode ^ genreName.hashCode;
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}
