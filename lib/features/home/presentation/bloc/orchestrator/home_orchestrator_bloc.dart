import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/features/home/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genre_movies/genre_movies_bloc.dart';

part 'home_orchestrator_event.dart';
part 'home_orchestrator_state.dart';

/// SOLID: Single Responsibility Principle (SRP)
/// 
/// Este bloc tiene una única responsabilidad: orquestar la carga de datos
/// de todos los blocs relacionados con la pantalla home.
/// No carga datos directamente, solo coordina cuando cada bloc debe cargar
/// sus propios datos, manteniendo una separación clara de responsabilidades.
class HomeOrchestratorBloc
    extends Bloc<HomeOrchestratorEvent, HomeOrchestratorState> {
  final PopularMoviesBloc _popularMoviesBloc;
  final NowPlayingMoviesBloc _nowPlayingMoviesBloc;
  final TopRatedMoviesBloc _topRatedMoviesBloc;
  final GenresBloc _genresBloc;
  final GenreMoviesBloc _genreMoviesBloc;

  StreamSubscription? _popularMoviesSubscription;
  StreamSubscription? _nowPlayingMoviesSubscription;
  StreamSubscription? _topRatedMoviesSubscription;
  StreamSubscription? _genresSubscription;
  StreamSubscription? _genreMoviesSubscription;

  HomeOrchestratorBloc({
    required PopularMoviesBloc popularMoviesBloc,
    required NowPlayingMoviesBloc nowPlayingMoviesBloc,
    required TopRatedMoviesBloc topRatedMoviesBloc,
    required GenresBloc genresBloc,
    required GenreMoviesBloc genreMoviesBloc,
  }) : _popularMoviesBloc = popularMoviesBloc,
       _nowPlayingMoviesBloc = nowPlayingMoviesBloc,
       _topRatedMoviesBloc = topRatedMoviesBloc,
       _genresBloc = genresBloc,
       _genreMoviesBloc = genreMoviesBloc,
       super(HomeOrchestratorState.initial()) {
    _startListening();
    on<LoadAllHomeDataEvent>(_loadAllHomeDataEvent);
  }

  void _startListening() {
    _popularMoviesSubscription = _popularMoviesBloc.stream.listen((
      popularMoviesState,
    ) {
      emit(state.copyWith(popularMoviesState: popularMoviesState));
    });

    _nowPlayingMoviesSubscription = _nowPlayingMoviesBloc.stream.listen((
      nowPlayingMoviesState,
    ) {
      emit(state.copyWith(nowPlayingMoviesState: nowPlayingMoviesState));
    });

    _topRatedMoviesSubscription = _topRatedMoviesBloc.stream.listen((
      topRatedMoviesState,
    ) {
      emit(state.copyWith(topRatedMoviesState: topRatedMoviesState));
    });

    _genresSubscription = _genresBloc.stream.listen((genresState) {
      emit(state.copyWith(genresState: genresState));
    });

    _genreMoviesSubscription = _genreMoviesBloc.stream.listen((
      genreMoviesState,
    ) {
      emit(state.copyWith(genreMoviesState: genreMoviesState));
    });
  }

  Future<void> _loadAllHomeDataEvent(
    LoadAllHomeDataEvent event,
    Emitter<HomeOrchestratorState> emit,
  ) async {
    emit(state.copyWith(effect: const LoadAllHomeDataEffect()));

    try {
      _popularMoviesBloc.add(const FetchPopularMoviesEvent());
      _nowPlayingMoviesBloc.add(const FetchNowPlayingMoviesEvent());
      _topRatedMoviesBloc.add(const FetchTopRatedMoviesEvent());
      _genresBloc.add(const FetchGenresEvent());

      // Esperar un momento para que los eventos se procesen
      await Future.delayed(const Duration(milliseconds: 100));

      emit(state.copyWith(effect: null));
    } catch (e) {
      emit(state.copyWith(effect: null));
    }
  }

  Future<void> loadAllData() async {
    add(const LoadAllHomeDataEvent());
  }

  @override
  Future<void> close() {
    _popularMoviesSubscription?.cancel();
    _nowPlayingMoviesSubscription?.cancel();
    _topRatedMoviesSubscription?.cancel();
    _genresSubscription?.cancel();
    _genreMoviesSubscription?.cancel();
    return super.close();
  }
}
