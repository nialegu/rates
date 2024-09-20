import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants/prefs_string_constants.dart';
import '../data/constants/routing_string_constants.dart';
import '../presentation/core/screens/loader_screen.dart';
import '../presentation/core/screens/root_screen.dart';
import '../presentation/features/authorization/authorization_screen.dart';
import '../presentation/features/convert/convert_screen.dart';
import '../presentation/features/convert/notifiers/convert_notifier.dart';
import '../presentation/features/rates/bloc/rates_bloc.dart';
import '../presentation/features/rates/rates_screen.dart';

part 'base_routes/auth_routes.dart';
part 'base_routes/loader_routes.dart';
part 'navigation_bar_routes/rates_routes.dart';
part 'navigation_bar_routes/convert_routes.dart';

class AppRouter {
  final SharedPreferences prefs;

  AppRouter({required this.prefs});

  late final router = GoRouter(
    initialLocation: RoutingStringConstants.authPath,
    routes: [
      _authRoutes(prefs),
      _loaderRoutes,
      _navigationBarRoutes,
    ],
  );

  final _navigationBarRoutes = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) =>
        _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: RootScreen(navigationShell: navigationShell)),
    redirect: (context, routerState) async {
      if (routerState.fullPath != RoutingStringConstants.ratesPath) {
        return null;
      }
      final ratesBloc = context.read<RatesBloc>();
      return ratesBloc.state.maybeWhen(
        initial: (_) {
          if (ratesBloc.cachedRates.isEmpty) {
            ratesBloc.add(const RatesEvent.started());
            return RoutingStringConstants.loaderPath;
          }
          return null;
        },
        fetchFailed: (error) => null,
        orElse: () {
          ratesBloc.add(const RatesEvent.started());
          return RoutingStringConstants.loaderPath;
        },
      );
    },
    branches: [
      _ratesRoutes,
      _convertRoutes,
    ],
  );
}

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
