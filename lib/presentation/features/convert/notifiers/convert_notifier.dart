// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';

class ConvertNotifier extends ChangeNotifier {
  List<Rate> _rates;
  final convertFromTextController = TextEditingController();
  final convertToTextController = TextEditingController();
  final amountController = TextEditingController();

  late FixedExtentScrollController pickerFromController;
  late FixedExtentScrollController pickerToController;

  late Rate _fromRate;
  late Rate _toRate;
  late String amount;

  ConvertNotifier(this._rates) {
    if (_rates.length >= 2) {
      fromRate = rates.first;
      toRate = rates[1];
    }
    amountController.text = "0.00";
  }

  set rates(List<Rate> rates) {
    _rates = rates;
    notifyListeners();
  }

  List<Rate> get rates => _rates;

  set fromRate(Rate rate) {
    _fromRate = rate;
    pickerFromController =
        FixedExtentScrollController(initialItem: findRateIndex(fromRate));
    convertFromTextController.text = rate.symbol;
  }

  Rate get fromRate => _fromRate;

  set toRate(Rate rate) {
    _toRate = rate;
    pickerToController =
        FixedExtentScrollController(initialItem: findRateIndex(toRate));
    convertToTextController.text = rate.symbol;
  }

  Rate get toRate => _toRate;

  void selectFromRate(List<Rate> cachedRates) {
    fromRate = rates.firstWhere(
      (e) => cachedRates[pickerFromController.selectedItem].id == e.id,
      orElse: () => cachedRates[pickerFromController.selectedItem],
    );
  }

  void selectToRate(List<Rate> cachedRates) {
    toRate = rates.firstWhere(
      (e) => cachedRates[pickerToController.selectedItem].id == e.id,
      orElse: () => cachedRates[pickerToController.selectedItem],
    );
  }

  int findRateIndex(Rate rate) =>
      _rates.indexOf(_rates.firstWhere((e) => e.id == rate.id));
}
