import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genre_movies/genre_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/orchestrator/home_orchestrator_bloc.dart';
import 'package:imdumb/features/home/presentation/home_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_widget_helper.dart';

/// Mocks para los blocs
class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}

class MockNowPlayingMoviesBloc extends Mock implements NowPlayingMoviesBloc {}

class MockTopRatedMoviesBloc extends Mock implements TopRatedMoviesBloc {}

class MockGenresBloc extends Mock implements GenresBloc {}

class MockGenreMoviesBloc extends Mock implements GenreMoviesBloc {}

class MockHomeOrchestratorBloc extends Mock implements HomeOrchestratorBloc {}

void main() {
  group('HomeScreen Widget Tests', () {
    late MockPopularMoviesBloc mockPopularMoviesBloc;
    late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
    late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
    late MockGenresBloc mockGenresBloc;
    late MockGenreMoviesBloc mockGenreMoviesBloc;
    late MockHomeOrchestratorBloc mockOrchestratorBloc;

    setUp(() {
      mockPopularMoviesBloc = MockPopularMoviesBloc();
      mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      mockGenresBloc = MockGenresBloc();
      mockGenreMoviesBloc = MockGenreMoviesBloc();
      mockOrchestratorBloc = MockHomeOrchestratorBloc();
    });

    /// Helper para crear el widget testeable con todos los blocs
    Widget makeTestableHomeScreen() {
      return TestWidgetHelper.makeTestableWidgetWithMultiBloc(
        blocProviders: [
          BlocProvider<PopularMoviesBloc>.value(value: mockPopularMoviesBloc),
          BlocProvider<NowPlayingMoviesBloc>.value(
            value: mockNowPlayingMoviesBloc,
          ),
          BlocProvider<TopRatedMoviesBloc>.value(value: mockTopRatedMoviesBloc),
          BlocProvider<GenresBloc>.value(value: mockGenresBloc),
          BlocProvider<GenreMoviesBloc>.value(value: mockGenreMoviesBloc),
          BlocProvider<HomeOrchestratorBloc>.value(value: mockOrchestratorBloc),
        ],
        widget: const HomeScreen(),
      );
    }

    testWidgets('debería renderizar el AppBar con título IMDUMB', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockPopularMoviesBloc.state,
      ).thenReturn(PopularMoviesState.initial());
      when(
        () => mockNowPlayingMoviesBloc.state,
      ).thenReturn(NowPlayingMoviesState.initial());
      when(
        () => mockTopRatedMoviesBloc.state,
      ).thenReturn(TopRatedMoviesState.initial());
      when(() => mockGenresBloc.state).thenReturn(GenresState.initial());
      when(
        () => mockGenreMoviesBloc.state,
      ).thenReturn(GenreMoviesState.initial());
      when(
        () => mockOrchestratorBloc.state,
      ).thenReturn(HomeOrchestratorState.initial());
      whenListen(
        mockPopularMoviesBloc,
        Stream.value(PopularMoviesState.initial()),
      );
      whenListen(
        mockNowPlayingMoviesBloc,
        Stream.value(NowPlayingMoviesState.initial()),
      );
      whenListen(
        mockTopRatedMoviesBloc,
        Stream.value(TopRatedMoviesState.initial()),
      );
      whenListen(mockGenresBloc, Stream.value(GenresState.initial()));
      whenListen(mockGenreMoviesBloc, Stream.value(GenreMoviesState.initial()));
      whenListen(
        mockOrchestratorBloc,
        Stream.value(HomeOrchestratorState.initial()),
      );

      await tester.pumpWidget(makeTestableHomeScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('IMDUMB'), findsWidgets);
    });

    testWidgets('debería mostrar secciones cuando hay datos', (tester) async {
      // Arrange
      final movies = [
        PopularMovieEntity(
          adult: false,
          backdropPath: '/test.jpg',
          id: 1,
          originalLanguage: 'en',
          originalTitle: 'Test Movie',
          overview: 'Test overview',
          popularity: 100.0,
          posterPath: '/poster.jpg',
          releaseDate: DateTime(2024, 1, 1),
          title: 'Test Movie',
          video: false,
          voteAverage: 8.0,
          voteCount: 1000,
        ),
      ];

      when(() => mockPopularMoviesBloc.state).thenReturn(
        PopularMoviesState.initial().copyWith(
          status: PopularMoviesStatus.success,
          movies: movies,
        ),
      );
      when(() => mockNowPlayingMoviesBloc.state).thenReturn(
        NowPlayingMoviesState.initial().copyWith(
          status: NowPlayingMoviesStatus.success,
          movies: movies,
        ),
      );
      when(() => mockTopRatedMoviesBloc.state).thenReturn(
        TopRatedMoviesState.initial().copyWith(
          status: TopRatedMoviesStatus.success,
          movies: movies,
        ),
      );
      when(() => mockGenresBloc.state).thenReturn(
        GenresState.initial().copyWith(
          status: GenresStatus.success,
          genres: [const GenreEntity(id: 28, name: 'Acción')],
        ),
      );
      when(
        () => mockGenreMoviesBloc.state,
      ).thenReturn(GenreMoviesState.initial());
      when(
        () => mockOrchestratorBloc.state,
      ).thenReturn(HomeOrchestratorState.initial());

      whenListen(
        mockPopularMoviesBloc,
        Stream.value(
          PopularMoviesState.initial().copyWith(
            status: PopularMoviesStatus.success,
            movies: movies,
          ),
        ),
      );
      whenListen(
        mockNowPlayingMoviesBloc,
        Stream.value(
          NowPlayingMoviesState.initial().copyWith(
            status: NowPlayingMoviesStatus.success,
            movies: movies,
          ),
        ),
      );
      whenListen(
        mockTopRatedMoviesBloc,
        Stream.value(
          TopRatedMoviesState.initial().copyWith(
            status: TopRatedMoviesStatus.success,
            movies: movies,
          ),
        ),
      );
      whenListen(
        mockGenresBloc,
        Stream.value(
          GenresState.initial().copyWith(
            status: GenresStatus.success,
            genres: [const GenreEntity(id: 28, name: 'Acción')],
          ),
        ),
      );
      whenListen(mockGenreMoviesBloc, Stream.value(GenreMoviesState.initial()));
      whenListen(
        mockOrchestratorBloc,
        Stream.value(HomeOrchestratorState.initial()),
      );

      await tester.pumpWidget(makeTestableHomeScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Películas Populares'), findsOneWidget);
      expect(find.text('En Cartelera'), findsOneWidget);
      
      final topRatedFinder = find.text('Top Rated');
      if (topRatedFinder.evaluate().isEmpty) {
        final scrollView = find.byType(CustomScrollView);
        if (scrollView.evaluate().isNotEmpty) {
          await tester.drag(scrollView.first, const Offset(0, -500));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));
        }
      }
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('debería mostrar botón de menú y permitir abrir drawer', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockPopularMoviesBloc.state,
      ).thenReturn(PopularMoviesState.initial());
      when(
        () => mockNowPlayingMoviesBloc.state,
      ).thenReturn(NowPlayingMoviesState.initial());
      when(
        () => mockTopRatedMoviesBloc.state,
      ).thenReturn(TopRatedMoviesState.initial());
      when(() => mockGenresBloc.state).thenReturn(GenresState.initial());
      when(
        () => mockGenreMoviesBloc.state,
      ).thenReturn(GenreMoviesState.initial());
      when(
        () => mockOrchestratorBloc.state,
      ).thenReturn(HomeOrchestratorState.initial());

      whenListen(
        mockPopularMoviesBloc,
        Stream.value(PopularMoviesState.initial()),
      );
      whenListen(
        mockNowPlayingMoviesBloc,
        Stream.value(NowPlayingMoviesState.initial()),
      );
      whenListen(
        mockTopRatedMoviesBloc,
        Stream.value(TopRatedMoviesState.initial()),
      );
      whenListen(mockGenresBloc, Stream.value(GenresState.initial()));
      whenListen(mockGenreMoviesBloc, Stream.value(GenreMoviesState.initial()));
      whenListen(
        mockOrchestratorBloc,
        Stream.value(HomeOrchestratorState.initial()),
      );

      await tester.pumpWidget(makeTestableHomeScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final menuButton = find.byIcon(Icons.menu);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(Drawer), findsOneWidget);
    });
  });
}
