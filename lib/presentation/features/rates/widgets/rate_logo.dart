import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';
import '../../../core/utils/app_colors.dart';

class RateLogo extends StatelessWidget {
  final Rate rate;
  final int nestedLevel;

  const RateLogo({super.key, required this.rate, this.nestedLevel = 1});

  Widget get placeholder => Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(color: AppColors.greyLight),
      );

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: switch (nestedLevel) {
        (1) => rate.imagePath,
        (2) => rate.alternateImagePath,
        (_) => rate.imagePath
      },
      placeholder: (context, url) => placeholder,
      errorListener: (error) => debugPrint(
          "Currency image ${rate.symbol} ERROR: ${error.toString()}"),
      errorWidget: (context, url, error) => nestedLevel == 2
          ? placeholder
          : RateLogo(
              rate: rate,
              nestedLevel: nestedLevel + 1,
            ),
      width: 24,
      height: 24,
    );
  }
}
