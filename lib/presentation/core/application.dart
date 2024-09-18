import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/constants/routing_string_constants.dart';
import '../features/authorization/bloc/authorization_bloc.dart';
import '../../routing/app_router.dart';
import '../features/rates/bloc/rates_bloc.dart';
import 'utils/theme/theme.dart';

class Application extends StatelessWidget {
  final SharedPreferences prefs;

  const Application({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(prefs: prefs).router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthorizationBloc()..add(const AuthorizationEvent.started()),
        ),
        BlocProvider(
          create: (context) => RatesBloc(),
        ),
      ],
      child: BlocListener<RatesBloc, RatesState>(
        listener: (context, state) {
          state.whenOrNull(
            initial: (_) => router.pushReplacementNamed(RoutingStringConstants.ratesName),
          );
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          // Navigation
          routerConfig: router,
          // Theme
          theme: theme,
        ),
      ),
    );
  }
}
