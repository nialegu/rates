import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:custom_circular_progress/utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularProgress(
            details: const IndicatorDetails(value: 0.375, itemCount: 8),
            color: AppColors.blue,
            backgroundColor: AppColors.blue.withOpacity(0.4),
            radius: 20,
            stopColorController: true,
            unitSize: const Size(10, 10),
            animationDuration: const Duration(seconds: 3),
          ),
          const SizedBox(height: 10),
          Text(
            "Rates loading...",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.grey),
          )
        ],
      ),
    );
  }
}
