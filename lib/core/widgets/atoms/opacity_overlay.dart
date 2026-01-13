import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Atom: Overlay de opacidad optimizado para reemplazar BackdropFilter
/// 
/// Este widget proporciona un efecto visual similar al blur pero con mejor performance
/// usando solo opacidad de color negro. Es más eficiente que BackdropFilter que requiere
/// procesamiento de imagen en tiempo real.
/// 
/// Uso:
/// ```dart
/// OpacityOverlay(
///   opacity: 0.7,
///   color: Colors.black,
/// )
/// ```
class OpacityOverlay extends StatelessWidget {
  /// Opacidad del overlay (0.0 a 1.0)
  final double opacity;
  
  /// Color base del overlay (por defecto negro)
  final Color? color;
  
  /// Si se debe usar el color del tema en lugar de negro
  final bool useThemeColor;
  
  /// Opacidad adicional del color del tema si useThemeColor es true
  final double? themeColorOpacity;

  const OpacityOverlay({
    super.key,
    this.opacity = 0.7,
    this.color,
    this.useThemeColor = false,
    this.themeColorOpacity,
  });

  @override
  Widget build(BuildContext context) {
    Color overlayColor;
    
    if (useThemeColor) {
      final baseColor = context.appColor.surfaceContainer;
      overlayColor = themeColorOpacity != null
          ? baseColor.withValues(alpha: themeColorOpacity!)
          : baseColor.withValues(alpha: 0.9);
    } else {
      overlayColor = color ?? Colors.black.withValues(alpha: opacity);
    }

    return Container(
      color: overlayColor,
    );
  }
}
