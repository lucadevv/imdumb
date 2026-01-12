import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/widgets/molecules/error_state.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

class GenresDrawer extends StatelessWidget {
  const GenresDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: context.appColor.surfaceContainer.withValues(alpha: 0.9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DrawerHeader(
                  child: Center(
                    child: const Text(
                      'Géneros',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GenresBloc, GenresState>(
                    builder: (context, state) {
                      if (state.status == GenresStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == GenresStatus.failure) {
                        return ErrorState(
                          errorMessage:
                              state.errorMessage ??
                              'Error al cargar los géneros',
                          onRetry: () {
                            context.read<GenresBloc>().add(
                              const FetchGenresEvent(),
                            );
                          },
                        );
                      }

                      if (state.genres.isEmpty) {
                        return Center(
                          child: Text(
                            'No hay géneros disponibles',
                            style: TextStyle(color: context.appColor.onSurface),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemCount: state.genres.length,
                        itemBuilder: (context, index) {
                          final genre = state.genres[index];
                          return ListTile(
                            title: Text(genre.name),
                            trailing: const Icon(
                              Iconsax.arrow_right_3,
                              size: 20,
                            ),
                            onTap: () {
                              context.router.pop();
                              context.router.push(
                                MoviesListRoute(
                                  type: MovieListType.genre,
                                  genreId: genre.id,
                                  genreName: genre.name,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
