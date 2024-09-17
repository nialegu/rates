import 'package:flutter/material.dart';

import '/routing/routes.dart';
import 'utils/theme/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Navigation
      routerConfig: router,
      // Theme
      theme: theme,
    );
  }
}