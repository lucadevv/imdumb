import 'package:get_it/get_it.dart';
import 'package:imdumb/core/database/app_database.dart';
import 'package:imdumb/core/injection/home/home_injection.dart';
import 'package:imdumb/core/injection/movies_list/movies_list_injection.dart';
import 'package:imdumb/core/injection/movie_detail/movie_detail_injection.dart';
import 'package:imdumb/core/injection/search/search_injection.dart';
import 'package:imdumb/core/routes/app_router.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/core/services/firebase/firebase_analytics_service_impl.dart';
import 'package:imdumb/core/services/firebase/remote_config_service.dart';
import 'package:imdumb/core/services/firebase/remote_config_service_impl.dart';
import 'package:imdumb/core/services/local/local_storage_service.dart';
import 'package:imdumb/core/services/local/shared_preferences_service_impl.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/core/services/network/dio_services_impl.dart';

class AppInjection {
  final GetIt _getIt;
  final String _baseUrl;
  final String _accessToken;

  AppInjection({
    required GetIt getIt,
    required String baseUrl,
    required String accessToken,
  }) : _getIt = getIt,
       _baseUrl = baseUrl,
       _accessToken = accessToken {
    _init();
  }

  void _init() {
    if (!_getIt.isRegistered<AppRouter>()) {
      _getIt.registerLazySingleton<AppRouter>(() => AppRouter());
    }
    if (!_getIt.isRegistered<AppDatabase>()) {
      _getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
    }
    if (!_getIt.isRegistered<ApiServices>()) {
      _getIt.registerLazySingleton<ApiServices>(
        () => DioApiServicesImpl(_baseUrl, accessToken: _accessToken),
      );
    }
    if (!_getIt.isRegistered<RemoteConfigService>()) {
      _getIt.registerLazySingleton<RemoteConfigService>(
        () => RemoteConfigServiceImpl(),
      );
    }
    if (!_getIt.isRegistered<LocalStorageService>()) {
      _getIt.registerLazySingleton<LocalStorageService>(
        () => SharedPreferencesServiceImpl(),
      );
    }
    if (!_getIt.isRegistered<AnalyticsService>()) {
      _getIt.registerLazySingleton<AnalyticsService>(
        () => FirebaseAnalyticsServiceImpl(),
      );
    }
    _homeFeteaure();
  }

  void _homeFeteaure() {
    HomeInjection(getIt: _getIt);
    MoviesListInjection(getIt: _getIt);
    MovieDetailInjection(getIt: _getIt);
    SearchInjection(getIt: _getIt);
  }
}
