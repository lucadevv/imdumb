import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Widget para el estado vacío de búsqueda
class SearchEmptyState extends StatelessWidget {
  final String message;

  const SearchEmptyState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: context.appColor.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
