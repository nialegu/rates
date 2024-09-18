part of '../app_router.dart';

final _ratesRoutes = StatefulShellBranch(
  routes: [
    GoRoute(
      path: RoutingStringConstants.ratesPath,
      name: RoutingStringConstants.ratesName,
      builder: (context, routerState) => const RatesScreen(),
    )
  ],
);
