// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';

class ConvertNotifier extends ChangeNotifier {
  List<Rate> _rates;
  final convertTextControllerFROM = TextEditingController();
  final convertTextControllerTO = TextEditingController();
  final amountController = TextEditingController();

  late FixedExtentScrollController pickerControllerFROM;
  late FixedExtentScrollController pickerControllerTO;

  late Rate _rateFROM;
  late Rate _rateTO;
  late String amount;

  ConvertNotifier(this._rates) {
    if (_rates.length >= 2) {
      rateFROM = rates.first;
      rateTO = rates[1];
    }
    amountController.text = "0.00";
  }

  set rates(List<Rate> rates) {
    _rates = rates;
    updateRateFROM();
    updateRateTO();
    notifyListeners();
  }

  List<Rate> get rates => _rates;

  set rateFROM(Rate rate) {
    _rateFROM = rate;
    pickerControllerFROM =
        FixedExtentScrollController(initialItem: findRateIndex(rateFROM));
    convertTextControllerFROM.text = rate.symbol;
  }

  Rate get rateFROM => _rateFROM;

  set rateTO(Rate rate) {
    _rateTO = rate;
    pickerControllerTO =
        FixedExtentScrollController(initialItem: findRateIndex(rateTO));
    convertTextControllerTO.text = rate.symbol;
  }

  Rate get rateTO => _rateTO;

  void selectRateFROM(List<Rate> cachedRates) {
    rateFROM = rates.firstWhere(
      (e) => cachedRates[pickerControllerFROM.selectedItem].id == e.id,
      orElse: () => cachedRates[pickerControllerFROM.selectedItem],
    );
  }

  void selectRateTO(List<Rate> cachedRates) {
    rateTO = rates.firstWhere(
      (e) => cachedRates[pickerControllerTO.selectedItem].id == e.id,
      orElse: () => cachedRates[pickerControllerTO.selectedItem],
    );
  }

  int findRateIndex(Rate rate) =>
      _rates.indexOf(_rates.firstWhere((e) => e.id == rate.id));

  void updateRateFROM() {
    rateFROM = rates.firstWhere(
      (e) => e.id == rateFROM.id,
      orElse: () => rateFROM,
    );
  }

  void updateRateTO() {
    rateTO = rates.firstWhere(
      (e) => e.id == rateTO.id,
      orElse: () => rateTO,
    );
  }
}
