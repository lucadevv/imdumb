import 'package:imdumb/core/services/local/local_storage_service.dart';
import 'package:mocktail/mocktail.dart';

/// Mock de LocalStorageService para tests
/// 
/// Permite mockear el almacenamiento local (SharedPreferences)
class MockLocalStorageService extends Mock implements LocalStorageService {}
