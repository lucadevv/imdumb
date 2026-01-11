import 'package:auto_route/auto_route.dart';
import 'package:imdumb/core/routes/public_routes.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...PublicRoutes.getList()];
}
