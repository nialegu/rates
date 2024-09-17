part of 'routes.dart';

final _loader = GoRoute(
      path: RoutingStringConstants.loaderPath,
      name: RoutingStringConstants.loaderName,
      builder: (context, state) => const LoaderScreen());