import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_analytics_service.dart';

class TestWidgetHelper {
  static void setupGetIt() {
    if (!GetIt.instance.isRegistered<AnalyticsService>()) {
      final mockAnalytics = MockAnalyticsService();
      
      // Configurar el mock para que devuelva Future<void> en lugar de null
      when(() => mockAnalytics.logEvent(any(), parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Future<void>.value());
      when(() => mockAnalytics.logScreenView(any(), parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Future<void>.value());
      when(() => mockAnalytics.setUserProperty(any(), any()))
          .thenAnswer((_) async => Future<void>.value());
      
      GetIt.instance.registerSingleton<AnalyticsService>(mockAnalytics);
    }
  }

  static Widget makeTestableWidget({required Widget widget, ThemeData? theme}) {
    setupGetIt();
    return MaterialApp(
      theme: theme ?? AppTheme.dark(),
      home: Scaffold(body: widget),
    );
  }

  static Widget makeTestableWidgetWithBloc<
    T extends StateStreamableSource<Object?>
  >({required Widget widget, required T bloc, ThemeData? theme}) {
    setupGetIt();
    return MaterialApp(
      theme: theme ?? AppTheme.dark(),
      home: Scaffold(
        body: BlocProvider<T>.value(value: bloc, child: widget),
      ),
    );
  }

  static Widget makeTestableWidgetWithMultiBloc({
    required Widget widget,
    required List<BlocProvider> blocProviders,
    ThemeData? theme,
  }) {
    setupGetIt();
    return MaterialApp(
      theme: theme ?? AppTheme.dark(),
      home: Scaffold(
        body: MultiBlocProvider(providers: blocProviders, child: widget),
      ),
    );
  }
}
