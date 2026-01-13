import 'package:imdumb/core/services/network/api_services.dart';
import 'package:mocktail/mocktail.dart';

/// Mock de ApiServices para tests
/// 
/// Permite mockear las respuestas de red sin hacer llamadas reales
class MockApiServices extends Mock implements ApiServices {}
