part of '../app_router.dart';

final _loaderRoutes = GoRoute(
  path: RoutingStringConstants.loaderPath,
  name: RoutingStringConstants.loaderName,
  builder: (context, state) => const Scaffold(body: Loader()),
);
