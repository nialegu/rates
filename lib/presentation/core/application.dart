import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/authorization/bloc/authorization_bloc.dart';
import '../../routing/app_router.dart';
import 'utils/theme/theme.dart';

class Application extends StatelessWidget {
  final SharedPreferences prefs;

  const Application({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorizationBloc()..add(const AuthorizationEvent.started()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // Navigation
        routerConfig: AppRouter(prefs: prefs).router,
        // Theme
        theme: theme,
      ),
    );
  }
}
