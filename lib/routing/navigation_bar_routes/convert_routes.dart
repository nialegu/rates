part of '../app_router.dart';

final _convertRoutes = StatefulShellBranch(
  routes: [
    GoRoute(
      path: RoutingStringConstants.convertPath,
      name: RoutingStringConstants.convertName,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) =>
            ConvertNotifier(context.read<RatesBloc>().cachedRates),
        child: BlocListener<RatesBloc, RatesState>(
          listener: (context, state) => state.whenOrNull(
            initial: (rates) => context.read<ConvertNotifier>().rates = rates,
          ),
          child: const ConvertScreen(),
        ),
      ),
    )
  ],
);
