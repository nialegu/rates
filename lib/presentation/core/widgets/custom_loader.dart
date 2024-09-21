import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:custom_circular_progress/utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double raduis;
  final Color colorSeed;

  const CustomLoader(
      {super.key, this.raduis = 20, this.colorSeed = AppColors.blue,});

  @override
  Widget build(BuildContext context) {
    return CustomCircularProgress(
      details: const IndicatorDetails(value: 0.375, itemCount: 8),
      color: colorSeed,
      backgroundColor: colorSeed.withOpacity(0.4),
      radius: raduis,
      stopColorController: true,
      unitSize: Size(raduis / 2, raduis / 2),
      animationDuration: const Duration(seconds: 3),
    );
  }
}
