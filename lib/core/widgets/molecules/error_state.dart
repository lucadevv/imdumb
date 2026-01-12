import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';

/// Molecule: Estado de error con mensaje y botón de reintentar
/// 
/// Widget reutilizable que muestra:
/// - Mensaje de error
/// - Botón "Reintentar" para volver a intentar la acción
/// 
/// Este widget reemplaza el patrón repetido en múltiples pantallas.
class ErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String retryLabel;

  const ErrorState({
    super.key,
    this.errorMessage,
    this.onRetry,
    this.retryLabel = 'Reintentar',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ?? 'Error al cargar',
            style: TextStyle(color: context.appColor.error),
            textAlign: TextAlign.center,
          ),
          16.spaceh,
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: Text(retryLabel),
            ),
        ],
      ),
    );
  }
}
