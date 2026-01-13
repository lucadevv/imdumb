import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';
import 'package:imdumb/core/widgets/atoms/cached_image.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';

class CastCard extends StatelessWidget {
  final CastEntity cast;

  const CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 120,
              height: 120,
              color: context.appColor.surfaceContainer,
              child: cast.profileUrlW185 != null
                  ? CachedImage(
                      imageUrl: cast.profileUrlW185,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                      placeholder: Shimmer.fromColors(
                        baseColor: context.appColor.surfaceContainer,
                        highlightColor: context.appColor.surfaceContainerHigh,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: context.appColor.surfaceContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      errorWidget: Container(
                        width: 120,
                        height: 120,
                        color: context.appColor.surfaceContainer,
                        child: const Icon(Icons.person, size: 56),
                      ),
                    )
                  : const Center(child: Icon(Icons.person, size: 56)),
            ),
          ),
          8.spaceh,
          Flexible(
            child: Text(
              cast.name,
              style: context.appTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
          if (cast.character != null) ...[
            4.spaceh,
            Flexible(
              child: Text(
                cast.character!,
                style: context.appTextTheme.bodySmall?.copyWith(
                  color: context.appColor.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
