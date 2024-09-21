import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';

class ConvertationResult extends StatelessWidget {
  final String rateFROM;
  final String rateTO;
  final String amountFROM;
  final String amountTO;
  final double commissionPercent;
  final String result;

  const ConvertationResult(
      {super.key,
      required this.rateFROM,
      required this.rateTO,
      required this.amountFROM,
      required this.amountTO,
      required this.commissionPercent,
      required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteGrey,
      ),
      child: Column(
        children: [
          Text(
            "$amountFROM $rateFROM",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset("assets/images/convert.svg"),
          ),
          Text(
            "$result $rateTO",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.blue),
          ),
          const SizedBox(height: 10),
          Text(
              "($amountTO $rateTO + ${commissionPercent % 1 == 0 ? commissionPercent.toInt() : commissionPercent}%)")
        ],
      ),
    );
  }
}
