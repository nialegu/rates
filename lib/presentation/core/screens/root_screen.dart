import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_colors.dart';

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
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              "assets/images/rates.svg",
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == 0
                    ? AppColors.blue
                    : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          label: "Rates",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              "assets/images/convert.svg",
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == 1
                    ? AppColors.blue
                    : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          label: "Convert",
        ),
      ];
}
