/// Utility class for parsing dates from different formats
/// 
/// SOLID: Single Responsibility Principle (SRP)
/// 
/// Esta clase tiene una única responsabilidad: parsear fechas de diferentes formatos.
/// Centraliza la lógica de parsing para evitar duplicación de código
/// y facilitar el mantenimiento.
/// 
/// Patrón aplicado: Utility Pattern (Helper Class)
class DateParser {
  /// Parsea una fecha desde un valor dinámico (puede ser String, null, etc.)
  /// 
  /// Retorna null si:
  /// - El valor es null
  /// - No es un String
  /// - El String está vacío
  /// - No se puede parsear
  static DateTime? parseReleaseDate(dynamic releaseDate) {
    if (releaseDate == null) return null;
    if (releaseDate is! String) return null;
    if (releaseDate.isEmpty) return null;
    try {
      return DateTime.parse(releaseDate);
    } catch (e) {
      return null;
    }
  }

  /// Parsea una fecha desde un String opcional
  /// 
  /// Utilidad específica para casos donde se garantiza que es String?
  static DateTime? parseDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
