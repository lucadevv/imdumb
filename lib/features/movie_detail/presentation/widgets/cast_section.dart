import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/cast_card.dart';

class CastSection extends StatelessWidget {
  final List<CastEntity> casts;

  const CastSection({
    super.key,
    required this.casts,
  });

  @override
  Widget build(BuildContext context) {
    if (casts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.spaceh,
        Text(
          'Elenco',
          style: context.appTextTheme.titleLarge,
        ),
        12.spaceh,
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 12),
            itemCount: casts.length,
            itemBuilder: (context, index) {
              final cast = casts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CastCard(cast: cast),
              );
            },
          ),
        ),
      ],
    );
  }
}
