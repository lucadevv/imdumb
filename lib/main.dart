import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/config/app_config.dart';
import 'package:imdumb/core/injection/app_injection.dart';
import 'package:imdumb/firebase_options.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Schema/Targets: Usa AppConfig para centralizar la configuración
  AppInjection(
    getIt: getIt,
    baseUrl: AppConfig.baseUrl,
    accessToken: AppConfig.accessToken,
  );

  runApp(const App());
}
