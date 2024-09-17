import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        currentIndex: navigationShell.currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
      body: navigationShell,
    );
  }

  List<BottomNavigationBarItem> get _bottomNavigationBarItems => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.abc),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: "",
        ),
      ];
}
