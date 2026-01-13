/// SOLID: Dependency Inversion Principle (DIP)
/// 
/// Esta interfaz abstracta define el contrato para el servicio de Analytics.
/// Las clases de alto nivel (presentation, use cases) dependen de esta abstracción,
/// no de implementaciones concretas (Firebase Analytics, etc.). Esto permite cambiar
/// la implementación sin afectar el código cliente.
///
/// Patrón aplicado: Strategy Pattern & Dependency Inversion Principle
/// Permite cambiar fácilmente entre diferentes proveedores de analytics
/// (Firebase Analytics, Google Analytics, Mixpanel, etc.) sin modificar el código cliente.
abstract class AnalyticsService {
  /// Registra un evento personalizado
  /// 
  /// [eventName] - Nombre del evento (ej: 'movie_selected', 'genre_selected')
  /// [parameters] - Parámetros opcionales del evento (clave-valor)
  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters});

  /// Registra que se visualizó una pantalla
  /// 
  /// [screenName] - Nombre de la pantalla (ej: 'home_screen', 'movie_detail_screen')
  /// [parameters] - Parámetros opcionales adicionales
  Future<void> logScreenView(String screenName, {Map<String, dynamic>? parameters});

  /// Establece una propiedad del usuario
  /// 
  /// [name] - Nombre de la propiedad
  /// [value] - Valor de la propiedad
  Future<void> setUserProperty(String name, String? value);
}
