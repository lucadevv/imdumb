import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Molecule: Estado vacío con mensaje
/// 
/// Widget reutilizable que muestra un mensaje cuando no hay contenido disponible.
class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({
    super.key,
    this.message = 'No hay información disponible',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: context.appColor.onSurface),
        textAlign: TextAlign.center,
      ),
    );
  }
}
