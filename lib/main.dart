import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/injection/app_injection.dart';

final GetIt getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const baseUrl = String.fromEnvironment('base_url');
  const accessToken = String.fromEnvironment('access_token');
  AppInjection(getIt: getIt, baseUrl: baseUrl, accessToken: accessToken);
  runApp(const App());
}
