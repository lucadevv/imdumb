import 'package:auto_route/auto_route.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';

class PublicRoutes {
  const PublicRoutes._();
  static List<AutoRoute> getList() => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];
}
