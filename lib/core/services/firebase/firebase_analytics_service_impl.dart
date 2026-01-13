import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta clase tiene una única responsabilidad: implementar la lógica
/// de Firebase Analytics. No maneja UI, no maneja lógica de negocio,
/// solo encapsula la comunicación con Firebase Analytics.
///
/// SOLID: Open/Closed Principle (OCP)
///
/// Esta implementación está abierta para extensión (se puede heredar)
/// pero cerrada para modificación. Si en el futuro necesitamos cambiar
/// a otro proveedor de analytics (Google Analytics, Mixpanel, etc.),
/// solo necesitamos crear una nueva implementación de AnalyticsService
/// sin modificar este código.
///
/// Patrón aplicado: Adapter Pattern
/// Adapta la API de Firebase Analytics a nuestra interfaz AnalyticsService,
/// proporcionando una abstracción que facilita el cambio de implementación.
class FirebaseAnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _analytics;

  /// Constructor que recibe FirebaseAnalytics como dependencia
  /// Permite la inyección de dependencias y facilita las pruebas
  FirebaseAnalyticsServiceImpl({FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters?.map(
          (key, value) => MapEntry(key, value as Object),
        ),
      );
    } catch (e) {
      // Silenciar errores de analytics para no afectar la experiencia del usuario
      // En producción, podría enviarse a un servicio de logging
      debugPrint(' Error al registrar evento de analytics: $e');
    }
  }

  @override
  Future<void> logScreenView(
    String screenName, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        parameters: parameters?.map(
          (key, value) => MapEntry(key, value as Object),
        ),
      );
    } catch (e) {
      // Silenciar errores de analytics para no afectar la experiencia del usuario
      debugPrint(' Error al registrar vista de pantalla: $e');
    }
  }

  @override
  Future<void> setUserProperty(String name, String? value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      // Silenciar errores de analytics para no afectar la experiencia del usuario
      debugPrint(' Error al establecer propiedad de usuario: $e');
    }
  }
}
