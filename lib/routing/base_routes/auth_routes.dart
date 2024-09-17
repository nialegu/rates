part of '../app_router.dart';

RouteBase _authRoutes(SharedPreferences prefs) => GoRoute(
      path: RoutingStringConstants.authPath,
      name: RoutingStringConstants.authName,
      redirect: (context, state) async {
        if (prefs.getBool(PrefsStringConstants.loggedIn) ?? false) {
          return RoutingStringConstants.ratesPath;
        }
        return null;
      },
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: AuthorizationScreen(),
      ),
    );
