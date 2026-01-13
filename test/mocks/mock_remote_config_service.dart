import 'package:imdumb/core/services/firebase/remote_config_service.dart';
import 'package:mocktail/mocktail.dart';

/// Mock de RemoteConfigService para tests
/// 
/// Permite mockear los valores de Firebase Remote Config
class MockRemoteConfigService extends Mock implements RemoteConfigService {}
