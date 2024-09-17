part of '../routes.dart';

final _ratesRoutes = StatefulShellBranch(
  routes: [
    GoRoute(
      path: RoutingStringConstants.ratesPath,
      name: RoutingStringConstants.ratesName,
      builder: (context, state) => const Placeholder(),
    )
  ],
);
