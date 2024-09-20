import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/logout_button.dart';
import 'notifiers/convert_notifier.dart';
import 'widgets/convertation_result.dart';
import 'widgets/currency_picker.dart';

class ConvertScreen extends StatelessWidget {
  const ConvertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverSafeArea(
          sliver: SliverAppBar(
            title: Text("Convert"),
            actions: [LogoutButton(), SizedBox(width: 5)],
          ),
        ),
      ],
      body: Consumer<ConvertNotifier>(
        builder: (context, convertNotifier, child) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AppTextFormField(
              labelText: "From",
              textEditingController: convertNotifier.convertTextControllerFROM,
              trailing: const Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () => showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                shape: const Border(),
                builder: (context) => CurrencyPicker(
                  rates: convertNotifier.rates,
                  onRateConfirmed: () =>
                      convertNotifier.selectRateFROM(convertNotifier.rates),
                  pickerController: convertNotifier.pickerControllerFROM,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              labelText: "To",
              textEditingController: convertNotifier.convertTextControllerTO,
              trailing: const Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () => showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                shape: const Border(),
                builder: (context) => CurrencyPicker(
                  rates: convertNotifier.rates,
                  onRateConfirmed: () =>
                      convertNotifier.selectRateTO(convertNotifier.rates),
                  pickerController: convertNotifier.pickerControllerTO,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                color: AppColors.greyLight,
              ),
            ),
            // TODO add a limit on the number of decimal places and change the empty to 0.00
            // TODO remove validation
            AppTextFormField(
              labelText: "Amount",
              textEditingController: convertNotifier.amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter amount";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ConvertationResult(
              rateFROM: convertNotifier.rateFROM.symbol,
              rateTO: convertNotifier.rateTO.symbol,
              amountFROM: convertNotifier.amountFROM.toStringAsFixed(2),
              amountTO: convertNotifier.amountTO.toStringAsFixed(2),
              commissionPercent: convertNotifier.commissionPercent,
              result: convertNotifier.result.toStringAsFixed(2),
            ),
          ],
        ),
      ),
    );
  }
}
