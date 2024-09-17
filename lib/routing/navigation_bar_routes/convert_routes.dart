part of '../app_router.dart';

final _convertRoutes = StatefulShellBranch(
  routes: [
    GoRoute(
      path: RoutingStringConstants.convertPath,
      name: RoutingStringConstants.convertName,
      builder: (context, state) => const Placeholder(),
    )
  ],
);
