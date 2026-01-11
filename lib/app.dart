import 'package:flutter/material.dart';
import 'package:imdumb/core/routes/app_router.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/main.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<AppRouter>().config(),
      title: 'IMDUMB',
      theme: AppTheme.dark(),
    );
  }
}
