import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Widget para el estado de error de la lista de películas
class MoviesListErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const MoviesListErrorState({
    super.key,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ?? 'Error al cargar las películas',
            style: TextStyle(color: context.appColor.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
        ],
      ),
    );
  }
}
