import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/widgets/now_playing_movies_section.dart';
import 'package:mocktail/mocktail.dart';

class MockNowPlayingMoviesBloc extends Mock
    implements NowPlayingMoviesBloc {}

void main() {
  late MockNowPlayingMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockNowPlayingMoviesBloc();
  });

  final tMovies = [
    PopularMovieEntity(
      adult: false,
      backdropPath: '/test.jpg',
      id: 1,
      originalLanguage: 'en',
      originalTitle: 'Now Playing Movie',
      overview: 'Test overview',
      popularity: 100.0,
      posterPath: '/poster.jpg',
      releaseDate: DateTime(2024, 1, 1),
      title: 'Now Playing Movie',
      video: false,
      voteAverage: 8.0,
      voteCount: 1000,
    ),
  ];

  testWidgets('debería mostrar título de la sección', (tester) async {
    final state = NowPlayingMoviesState.initial().copyWith(
      status: NowPlayingMoviesStatus.success,
      movies: tMovies,
    );
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocProvider<NowPlayingMoviesBloc>.value(
                value: mockBloc,
                child: const NowPlayingMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('En Cartelera'), findsOneWidget);
  });

  testWidgets('debería mostrar películas en lista horizontal', (tester) async {
    final state = NowPlayingMoviesState.initial().copyWith(
      status: NowPlayingMoviesStatus.success,
      movies: tMovies,
    );
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocProvider<NowPlayingMoviesBloc>.value(
                value: mockBloc,
                child: const NowPlayingMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Now Playing Movie'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('debería mostrar botón "Ver más"', (tester) async {
    final state = NowPlayingMoviesState.initial().copyWith(
      status: NowPlayingMoviesStatus.success,
      movies: tMovies,
    );
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocProvider<NowPlayingMoviesBloc>.value(
                value: mockBloc,
                child: const NowPlayingMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Ver más'), findsOneWidget);
  });

  testWidgets('debería mostrar error state cuando falla', (tester) async {
    final state = NowPlayingMoviesState.initial().copyWith(
      status: NowPlayingMoviesStatus.failure,
      errorMessage: 'Error de conexión',
    );
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocProvider<NowPlayingMoviesBloc>.value(
                value: mockBloc,
                child: const NowPlayingMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Error de conexión'), findsOneWidget);
  });
}
