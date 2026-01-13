import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/widgets/atoms/cached_image.dart';
import 'package:imdumb/core/widgets/molecules/rating_row.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/main.dart';

/// Molecule: Card reutilizable para mostrar películas en listas horizontales
///
/// Widget que muestra:
/// - Imagen del poster (con cache y placeholder/error)
/// - Título de la película
/// - Rating con estrella y año (opcional)
/// - Navegación al detalle al hacer tap
///
/// Este widget reemplaza las múltiples variantes:
/// - _NowPlayingMovieCard
/// - _TopRatedMovieCard
/// - _GenreMovieCard
/// - _MovieCard (grid)
class MoviePosterCard extends StatelessWidget {
  final PopularMovieEntity movie;
  final double width;
  final double height;
  final double borderRadius;
  final bool showYear;
  final int titleMaxLines;

  const MoviePosterCard({
    super.key,
    required this.movie,
    this.width = 160,
    this.height = 280,
    this.borderRadius = 12,
    this.showYear = false,
    this.titleMaxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('movie_poster_card_${movie.id}'),
      onTap: () async {
        // Guardar el router antes del await para evitar usar context después de async gap
        final router = context.router;
        
        // SOLID: Dependency Inversion Principle (DIP)
        // El widget depende de la abstracción AnalyticsService, no de la implementación concreta.
        try {
          final analyticsService = getIt<AnalyticsService>();
          await analyticsService.logEvent(
            'movie_selected',
            parameters: {'movie_id': movie.id, 'movie_title': movie.title},
          );
        } catch (e) {
          // Silenciar errores de analytics para no afectar la experiencia del usuario
          debugPrint('Error al registrar analytics: $e');
        }

        router.push(MovieDetailRoute(movieId: movie.id));
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedImage(
                  imageUrl: movie.posterThumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: context.appColor.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.spaceh,
                    RatingRow(
                      rating: movie.formattedVoteAverage,
                      year: showYear ? movie.releaseYear : null,
                      starSize: 14,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
