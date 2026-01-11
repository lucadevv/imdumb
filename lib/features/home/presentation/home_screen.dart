import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/bloc/home_bloc.dart';

import 'package:imdumb/main.dart';
import 'package:imdumb/features/home/presentation/widgets/home_app_bar.dart';
import 'package:imdumb/features/home/presentation/widgets/popular_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/now_playing_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/top_rated_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/genre_movies_section.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(
              fetchAllPopularMovieUsecase: getIt<FetchAllPopularMovieUsecase>(),
              fetchAllNowPlayingMovieUsecase:
                  getIt<FetchAllNowPlayingMovieUsecase>(),
              fetchAllTopRatedMovieUsecase:
                  getIt<FetchAllTopRatedMovieUsecase>(),
              fetchAllGenresUsecase: getIt<FetchAllGenresUsecase>(),
              fetchMoviesByGenreUsecase: getIt<FetchMoviesByGenreUsecase>(),
            )
            ..add(const FetchAllPopularMovieEvent())
            ..add(const FetchAllNowPlayingMovieEvent())
            ..add(const FetchAllTopRatedMovieEvent())
            ..add(const FetchAllGenresEvent()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
          PopularMoviesSection(),
          NowPlayingMoviesSection(),
          TopRatedMoviesSection(),
          GenreMoviesSections(),
        ],
      ),
    );
  }
}
