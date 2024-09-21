import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';
import 'rate_logo.dart';

class RateTile extends StatelessWidget {
  final Rate rate;

  const RateTile({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: RateLogo(rate: rate),
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
