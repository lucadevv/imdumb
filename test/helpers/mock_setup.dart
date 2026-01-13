import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/core/services/firebase/remote_config_service.dart';
import 'package:imdumb/core/services/local/local_storage_service.dart';
import 'package:imdumb/core/services/network/api_services.dart';

import 'package:mocktail/mocktail.dart';

import '../mocks/mock_analytics_service.dart';
import '../mocks/mock_api_services.dart';
import '../mocks/mock_local_storage_service.dart';
import '../mocks/mock_remote_config_service.dart';

/// Helper para configurar mocks en tests
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta clase tiene una única responsabilidad: configurar los mocks
/// necesarios para los tests, centralizando la lógica de setup.
class MockSetup {
  static MockApiServices? _mockApiServices;
  static MockRemoteConfigService? _mockRemoteConfigService;
  static MockLocalStorageService? _mockLocalStorageService;
  static MockAnalyticsService? _mockAnalyticsService;

  /// Configura los mocks básicos para unit tests
  static void setupUnitTests() {
    _mockApiServices = MockApiServices();
    _mockRemoteConfigService = MockRemoteConfigService();
    _mockLocalStorageService = MockLocalStorageService();
    _mockAnalyticsService = MockAnalyticsService();
  }

  /// Configura los mocks para widget tests
  static void setupWidgetTests() {
    setupUnitTests();
  }

  static void setupIntegrationTests(GetIt getIt) {
    setupUnitTests();

    getIt.registerSingleton<ApiServices>(_mockApiServices!);
    getIt.registerSingleton<RemoteConfigService>(_mockRemoteConfigService!);
    getIt.registerSingleton<LocalStorageService>(_mockLocalStorageService!);
    getIt.registerSingleton<AnalyticsService>(_mockAnalyticsService!);

    _setupDefaultBehaviors();
  }

  static void _setupDefaultBehaviors() {
    // Registrar fallback values para parámetros opcionales
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue('');

    when(
      () => _mockRemoteConfigService!.initialize(),
    ).thenAnswer((_) async => {});
    when(
      () => _mockRemoteConfigService!.fetchAndActivate(),
    ).thenAnswer((_) async => true);
    when(
      () => _mockRemoteConfigService!.getString(
        any(),
        defaultValue: any(named: 'defaultValue', that: isA<String>()),
      ),
    ).thenAnswer((invocation) async {
      final defaultValue = invocation.namedArguments[#defaultValue] as String?;
      return defaultValue?.isNotEmpty == true ? defaultValue! : 'IMDUMB';
    });

    when(
      () => _mockLocalStorageService!.getString(any()),
    ).thenAnswer((_) async => null);
    when(
      () => _mockLocalStorageService!.setString(any(), any()),
    ).thenAnswer((_) async => true);
    when(
      () => _mockLocalStorageService!.getBool(any()),
    ).thenAnswer((_) async => null);
    when(
      () => _mockLocalStorageService!.setBool(any(), any()),
    ).thenAnswer((_) async => true);
    when(
      () => _mockLocalStorageService!.getInt(any()),
    ).thenAnswer((_) async => null);
    when(
      () => _mockLocalStorageService!.setInt(any(), any()),
    ).thenAnswer((_) async => true);
    when(
      () => _mockLocalStorageService!.remove(any()),
    ).thenAnswer((_) async => true);
    when(() => _mockLocalStorageService!.clear()).thenAnswer((_) async => true);
    when(
      () => _mockLocalStorageService!.containsKey(any()),
    ).thenAnswer((_) async => false);

    when(
      () => _mockAnalyticsService!.logEvent(
        any(),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => _mockAnalyticsService!.logScreenView(
        any(),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => _mockAnalyticsService!.setUserProperty(any(), any()),
    ).thenAnswer((_) async {});
  }

  /// Obtiene el mock de ApiServices
  static MockApiServices get apiServices => _mockApiServices!;

  /// Obtiene el mock de RemoteConfigService
  static MockRemoteConfigService get remoteConfigService =>
      _mockRemoteConfigService!;

  /// Obtiene el mock de LocalStorageService
  static MockLocalStorageService get localStorageService =>
      _mockLocalStorageService!;

  /// Obtiene el mock de AnalyticsService
  static MockAnalyticsService get analyticsService => _mockAnalyticsService!;

  static void reset() {
    _mockApiServices = null;
    _mockRemoteConfigService = null;
    _mockLocalStorageService = null;
    _mockAnalyticsService = null;
  }
}
