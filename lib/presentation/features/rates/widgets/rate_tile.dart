import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';

class RateTile extends StatelessWidget {
  final Rate rate;

  const RateTile({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.currency_bitcoin),
      title: Text(rate.symbol),
      trailing: Text("\$${rate.rateUsd}"),
    );
  }
}
