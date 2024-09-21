import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';
import '../../../core/utils/app_colors.dart';

class RateTile extends StatelessWidget {
  final Rate rate;

  const RateTile({super.key, required this.rate});

  Widget get placeholder => Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(color: AppColors.greyLight),
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: rate.imagePath,
          placeholder: (context, url) => placeholder,
          errorListener: (error) => debugPrint(
              "Currency image ${rate.symbol} ERROR: ${error.toString()}"),
          errorWidget: (context, url, error) => CachedNetworkImage(
            imageUrl: rate.alternateImagePath,
            placeholder: (context, url) => placeholder,
            errorListener: (error) => debugPrint(
                "Currency image ${rate.symbol} ERROR: ${error.toString()}"),
            errorWidget: (context, url, error) => placeholder,
          ),
          width: 24,
          height: 24,
        ),
      ),
      title: Text(rate.symbol),
      trailing: Text(
        "\$${rate.coursePreservationAccuracy}",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
            ),
      ),
    );
  }
}
