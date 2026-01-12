import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';

class RecommendationModal extends StatelessWidget {
  final MovieDetailEntity movieDetail;
  final TextEditingController commentController;
  final VoidCallback onConfirm;

  const RecommendationModal({
    super.key,
    required this.movieDetail,
    required this.commentController,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColor.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: context.viewInsetsBottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.appColor.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            16.spaceh,
            Text(
              movieDetail.title,
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
            24.spaceh,
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Comentario',
                hintText: 'Escribe tu comentario...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 5,
            ),
            24.spaceh,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
