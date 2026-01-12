import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/services/firebase/remote_config_service.dart';
import 'package:imdumb/core/services/local/local_storage_service.dart';
import 'package:imdumb/main.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _welcomeMessage = 'IMDUMB';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRemoteConfig();
  }

  Future<void> _loadRemoteConfig() async {
    try {
      final remoteConfigService = getIt<RemoteConfigService>();
      final localStorageService = getIt<LocalStorageService>();

      // Inicializar Remote Config
      await remoteConfigService.initialize();
      await remoteConfigService.fetchAndActivate();

      // Obtener welcome_message desde Firebase Remote Config
      final welcomeMessage = await remoteConfigService.getString(
        'welcome_message',
        defaultValue: 'IMDUMB',
      );

      // Guardar en almacenamiento local (SharedPreferences)
      await localStorageService.setString('welcome_message', welcomeMessage);

      if (mounted) {
        setState(() {
          _welcomeMessage = welcomeMessage;
          _isLoading = false;
        });

        // Navegar a HomeScreen después de 2 segundos
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.router.replace(const HomeRoute());
          }
        });
      }
    } catch (e) {
      // Si hay error, intentar obtener desde almacenamiento local
      try {
        final localStorageService = getIt<LocalStorageService>();
        final savedMessage = await localStorageService.getString('welcome_message');
        if (mounted) {
          setState(() {
            _welcomeMessage = savedMessage ?? 'IMDUMB';
            _isLoading = false;
          });
        }
      } catch (_) {
        // Si también falla, usar valor por defecto
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }

      // Navegar a HomeScreen después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.router.replace(const HomeRoute());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Text(
                  _welcomeMessage,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
