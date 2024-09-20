import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_colors.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/logout_button.dart';
import 'notifiers/convert_notifier.dart';
import 'widgets/currency_picker.dart';

class ConvertScreen extends StatelessWidget {
  const ConvertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final convertNotifier = context.read<ConvertNotifier>();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverSafeArea(
          sliver: SliverAppBar(
            title: Text("Convert"),
            actions: [LogoutButton(), SizedBox(width: 5)],
          ),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AppTextFormField(
            labelText: "From",
            textEditingController: convertNotifier.convertFromTextController,
            trailing: const Icon(Icons.keyboard_arrow_down),
            readOnly: true,
            onTap: () => showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              shape: const Border(),
              builder: (context) => CurrencyPicker(
                rates: convertNotifier.rates,
                onRateConfirmed: () => convertNotifier.selectFromRate(convertNotifier.rates),
                pickerController: convertNotifier.pickerFromController,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppTextFormField(
            labelText: "To",
            textEditingController: convertNotifier.convertToTextController,
            trailing: const Icon(Icons.keyboard_arrow_down),
            readOnly: true,
            onTap: () => showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              shape: const Border(),
              builder: (context) => CurrencyPicker(
                rates: convertNotifier.rates,
                onRateConfirmed: () => convertNotifier.selectToRate(convertNotifier.rates),
                pickerController: convertNotifier.pickerToController,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              color: AppColors.greyLight,
            ),
          ),
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
        ],
      ),
    );
  }
}
