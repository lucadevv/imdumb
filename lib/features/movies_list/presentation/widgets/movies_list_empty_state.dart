import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Widget para el estado vacío de la lista de películas
class MoviesListEmptyState extends StatelessWidget {
  const MoviesListEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No hay películas disponibles',
        style: TextStyle(color: context.appColor.onSurface),
      ),
    );
  }
}
