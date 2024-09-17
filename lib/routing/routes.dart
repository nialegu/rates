import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/constants/routing_string_constants.dart';
import '../presentation/core/screens/loader_screen.dart';
import '../presentation/core/screens/root_screen.dart';
import '../presentation/features/authorization/authorization_screen.dart';

part 'navigation_bar_routes/rates_routes.dart';
part 'navigation_bar_routes/convert_routes.dart';
part 'loader_route.dart';

final router = GoRouter(
  // TODO
  // navigatorKey: rootNavigatorKey,
  initialLocation: RoutingStringConstants.authPath,
  // TODO
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      path: RoutingStringConstants.authPath,
      name: RoutingStringConstants.authName,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: AuthorizationScreen(),
      ),
    ),
    _loader,
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        _ratesRoutes,
        _convertRoutes,
      ],
    )
  ],
);

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
