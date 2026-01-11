part of 'genres_bloc.dart';

enum GenresStatus { initial, loading, success, failure }

class GenresState extends Equatable {
  final List<GenreEntity> genres;
  final GenresStatus status;
  final String? errorMessage;

  const GenresState({
    required this.genres,
    required this.status,
    this.errorMessage,
  });

  GenresState copyWith({
    List<GenreEntity>? genres,
    GenresStatus? status,
    String? errorMessage,
  }) =>
      GenresState(
        genres: genres ?? this.genres,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory GenresState.initial() => const GenresState(
        genres: [],
        status: GenresStatus.initial,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [genres, status, errorMessage];
}
