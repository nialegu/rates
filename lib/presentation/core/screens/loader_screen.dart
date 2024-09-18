import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_loader.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomLoader(),
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
