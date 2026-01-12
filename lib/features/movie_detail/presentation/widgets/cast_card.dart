import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/core/widgets/atoms/cached_image.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';

class CastCard extends StatelessWidget {
  final CastEntity cast;

  const CastCard({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 100,
              height: 100,
              color: context.appColor.surfaceContainer,
              child: cast.profileUrlW185 != null
                  ? CachedImage(
                      imageUrl: cast.profileUrlW185,
                      fit: BoxFit.cover,
                      placeholder: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: const Icon(Icons.person),
                    )
                  : const Icon(Icons.person, size: 48),
            ),
          ),
          6.spaceh,
          Flexible(
            child: Text(
              cast.name,
              style: context.appTextTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (cast.character != null) ...[
            2.spaceh,
            Flexible(
              child: Text(
                cast.character!,
                style: context.appTextTheme.bodySmall?.copyWith(
                  color: context.appColor.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
