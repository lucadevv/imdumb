import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Atom: Componente básico para mostrar imágenes con cache
/// 
/// Wrapper de CachedNetworkImage con placeholder y error widget estandarizados.
/// Usa los colores del tema de la aplicación para mantener consistencia visual.
class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildErrorWidget(context);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ?? _buildPlaceholder(context),
      errorWidget: (context, url, error) =>
          errorWidget ?? _buildErrorWidget(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: context.appColor.surfaceContainer,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: context.appColor.surfaceContainer,
      child: const Icon(Icons.movie, size: 48),
    );
  }
}
