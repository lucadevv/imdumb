import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:imdumb/core/services/firebase/remote_config_service.dart';

/// SOLID: Single Responsibility Principle (SRP)
/// 
/// Esta clase tiene una única responsabilidad: implementar la lógica
/// de Firebase Remote Config. No maneja UI, no maneja persistencia,
/// solo encapsula la comunicación con Firebase Remote Config.
class RemoteConfigServiceImpl implements RemoteConfigService {
  FirebaseRemoteConfig? _remoteConfig;

  @override
  Future<void> initialize() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    
    // Para desarrollo: mínimo intervalo de fetch muy bajo para obtener cambios rápidamente
    // En producción debería ser mayor (ej: Duration(hours: 1))
    await _remoteConfig!.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero, // Permite fetch inmediato para desarrollo
      ),
    );

    // Valores por defecto
    await _remoteConfig!.setDefaults({
      'welcome_message': 'IMDUMB',
    });
  }

  @override
  Future<String> getString(String key, {String defaultValue = ''}) async {
    if (_remoteConfig == null) {
      await initialize();
    }
    
    try {
      return _remoteConfig!.getString(key);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  Future<bool> fetchAndActivate() async {
    if (_remoteConfig == null) {
      await initialize();
    }
    
    try {
      return await _remoteConfig!.fetchAndActivate();
    } catch (e) {
      return false;
    }
  }
}
