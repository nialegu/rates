import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';
import '../../../core/utils/app_colors.dart';

class CurrencyPicker extends StatelessWidget {
  final void Function() onRateConfirmed;
  final List<Rate> rates;
  final FixedExtentScrollController pickerController;

  const CurrencyPicker({
    super.key,
    required this.onRateConfirmed,
    required this.rates,
    required this.pickerController
  }) ;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () => {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.75, color: AppColors.greyLight),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onRateConfirmed();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: CupertinoPicker(
              itemExtent: 64,
              scrollController: pickerController,
              selectionOverlay: const ListTile(
                shape: Border(
                  top: BorderSide(width: 0.75, color: AppColors.greyLight),
                  bottom: BorderSide(width: 0.75, color: AppColors.greyLight),
                ),
              ),
              onSelectedItemChanged: (int index) {
                debugPrint('Selected currency: ${rates[index].symbol}');
              },
              children:
                  rates.map((e) => Center(child: Text(e.symbol))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
