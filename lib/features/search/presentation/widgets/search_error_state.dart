import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Widget para el estado de error de búsqueda
class SearchErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const SearchErrorState({
    super.key,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? 'Error al buscar películas',
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
      ),
    );
  }
}
