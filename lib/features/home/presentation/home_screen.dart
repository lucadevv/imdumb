import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genre_movies/genre_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/orchestrator/home_orchestrator_bloc.dart';

import 'package:imdumb/main.dart';
import 'package:imdumb/features/home/presentation/widgets/home_app_bar.dart';
import 'package:imdumb/features/home/presentation/widgets/popular_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/now_playing_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/top_rated_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/genre_movies_section.dart';
import 'package:imdumb/features/home/presentation/widgets/background_image_widget.dart';
import 'package:imdumb/features/home/presentation/widgets/genres_drawer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final popularMoviesBloc = PopularMoviesBloc(
      fetchAllPopularMovieUsecase: getIt<FetchAllPopularMovieUsecase>(),
    );

    final nowPlayingMoviesBloc = NowPlayingMoviesBloc(
      fetchAllNowPlayingMovieUsecase: getIt<FetchAllNowPlayingMovieUsecase>(),
    );

    final topRatedMoviesBloc = TopRatedMoviesBloc(
      fetchAllTopRatedMovieUsecase: getIt<FetchAllTopRatedMovieUsecase>(),
    );

    final genresBloc = GenresBloc(
      fetchAllGenresUsecase: getIt<FetchAllGenresUsecase>(),
    );

    final genreMoviesBloc = GenreMoviesBloc(
      fetchMoviesByGenreUsecase: getIt<FetchMoviesByGenreUsecase>(),
    );

    final orchestratorBloc = HomeOrchestratorBloc(
      popularMoviesBloc: popularMoviesBloc,
      nowPlayingMoviesBloc: nowPlayingMoviesBloc,
      topRatedMoviesBloc: topRatedMoviesBloc,
      genresBloc: genresBloc,
      genreMoviesBloc: genreMoviesBloc,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: popularMoviesBloc),
        BlocProvider.value(value: nowPlayingMoviesBloc),
        BlocProvider.value(value: topRatedMoviesBloc),
        BlocProvider.value(value: genresBloc),
        BlocProvider.value(value: genreMoviesBloc),
        BlocProvider.value(value: orchestratorBloc),
      ],
      child: BlocProvider.value(
        value: orchestratorBloc,
        child: Builder(
          builder: (context) {
            orchestratorBloc.loadAllData();
            return this;
          },
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const GenresDrawer(),
      body: SizedBox.expand(
        child: Stack(
          children: [
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                return BackgroundImageWidget(
                  currentIndex: _currentCarouselIndex,
                  movies: state.movies,
                );
              },
            ),
            CustomScrollView(
        slivers: [
                HomeAppBar(),
                PopularMoviesSection(
                  onPageChanged: (index) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                NowPlayingMoviesSection(),
                TopRatedMoviesSection(),
                GenreMoviesSections(),
        ],
            ),
          ],
        ),
      ),
    );
  }
}
