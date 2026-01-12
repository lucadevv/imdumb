/// SOLID: Dependency Inversion Principle (DIP)
/// 
/// Esta interfaz abstracta define el contrato para el servicio de Firebase Remote Config.
/// Las clases de alto nivel (presentation, use cases) dependen de esta abstracción,
/// no de implementaciones concretas. Esto permite cambiar la implementación
/// (Firebase, mock, etc.) sin afectar el código cliente.
abstract class RemoteConfigService {
  /// Inicializa el servicio de Remote Config
  Future<void> initialize();

  /// Obtiene un valor string del Remote Config
  /// Retorna el valor por defecto si no existe la clave
  Future<String> getString(String key, {String defaultValue = ''});

  /// Fuerza la actualización de los valores desde Firebase
  Future<bool> fetchAndActivate();
}
