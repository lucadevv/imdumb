import 'package:get_it/get_it.dart';
import 'package:imdumb/core/injection/home/home_injection.dart';
import 'package:imdumb/core/injection/movies_list/movies_list_injection.dart';
import 'package:imdumb/core/injection/movie_detail/movie_detail_injection.dart';
import 'package:imdumb/core/routes/app_router.dart';
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
  })  : _getIt = getIt,
        _baseUrl = baseUrl,
        _accessToken = accessToken {
    _init();
  }

  void _init() {
    _getIt.registerLazySingleton<AppRouter>(() => AppRouter());
    _getIt.registerLazySingleton<ApiServices>(
      () => DioApiServicesImpl(_baseUrl, accessToken: _accessToken),
    );
    _homeFeteaure();
  }

  void _homeFeteaure() {
    HomeInjection(getIt: _getIt);
    MoviesListInjection(getIt: _getIt);
    MovieDetailInjection(getIt: _getIt);
  }
}
