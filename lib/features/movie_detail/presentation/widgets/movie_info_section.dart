import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';

class MovieInfoSection extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const MovieInfoSection({
    super.key,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieDetail.title,
          style: context.appTextTheme.headlineMedium,
        ),
        8.spaceh,
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            4.spacew,
            Text(
              movieDetail.formattedVoteAverage,
              style: context.appTextTheme.titleMedium,
            ),
            16.spacew,
            if (movieDetail.runtime != null)
              Text(
                movieDetail.formattedRuntime,
                style: context.appTextTheme.bodyMedium,
              ),
          ],
        ),
        if (movieDetail.formattedGenres.isNotEmpty) ...[
          8.spaceh,
          Text(
            movieDetail.formattedGenres,
            style: context.appTextTheme.bodySmall,
          ),
        ],
        16.spaceh,
        Text(
          'Descripción',
          style: context.appTextTheme.titleLarge,
        ),
        8.spaceh,
        Html(
          data: movieDetail.overview,
          style: {
            'body': Style(
              margin: Margins.zero,
              padding: HtmlPaddings.zero,
              fontSize: FontSize(
                context.appTextTheme.bodyMedium?.fontSize ?? 14,
              ),
              color: context.appTextTheme.bodyMedium?.color,
              lineHeight: LineHeight(
                context.appTextTheme.bodyMedium?.height ?? 1.5,
              ),
            ),
          },
        ),
      ],
    );
  }
}
