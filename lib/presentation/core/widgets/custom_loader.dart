import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:custom_circular_progress/utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double raduis;

  const CustomLoader({super.key, this.raduis = 20});

  @override
  Widget build(BuildContext context) {
    return CustomCircularProgress(
      details: const IndicatorDetails(value: 0.375, itemCount: 8),
      color: AppColors.blue,
      backgroundColor: AppColors.blue.withOpacity(0.4),
      radius: raduis,
      stopColorController: true,
      unitSize: Size(raduis / 2, raduis / 2),
      animationDuration: const Duration(seconds: 3),
    );
  }
}
