part of '../app_router.dart';

final _loaderRoutes = GoRoute(
  path: RoutingStringConstants.loaderPath,
  name: RoutingStringConstants.loaderName,
  pageBuilder: (context, state) => _buildPageWithDefaultTransition(
      context: context,
      state: state,
      child: const Scaffold(body: LoaderScreen())),
  builder: (context, state) => const Scaffold(body: LoaderScreen()),
);
