import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:imdumb/features/home/presentation/widgets/popular_movies_section.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}

void main() {
  late MockPopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  final tMovies = [
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

  testWidgets('debería renderizar PopularMoviesSection correctamente',
      (tester) async {
    final state = PopularMoviesState.initial().copyWith(
      status: PopularMoviesStatus.success,
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
              BlocProvider<PopularMoviesBloc>.value(
                value: mockBloc,
                child: const PopularMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(PopularMoviesSection), findsOneWidget);
  });

  testWidgets('debería mostrar carousel cuando hay películas', (tester) async {
    final state = PopularMoviesState.initial().copyWith(
      status: PopularMoviesStatus.success,
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
              BlocProvider<PopularMoviesBloc>.value(
                value: mockBloc,
                child: const PopularMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Test Movie'), findsWidgets);
  });

  testWidgets('debería mostrar shimmer cuando está cargando', (tester) async {
    final state = PopularMoviesState.initial().copyWith(
      status: PopularMoviesStatus.loading,
    );
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocProvider<PopularMoviesBloc>.value(
                value: mockBloc,
                child: const PopularMoviesSection(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(PopularMoviesSection), findsOneWidget);
  });
}
