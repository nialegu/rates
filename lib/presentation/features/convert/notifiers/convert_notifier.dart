// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../../../../data/entities/rate.dart';

class ConvertNotifier extends ChangeNotifier {
  List<Rate> _rates;

  // Magic number
  final double commissionPercent = 3.0;

  final convertTextControllerFROM = TextEditingController();
  final convertTextControllerTO = TextEditingController();
  final amountController = TextEditingController();

  late FixedExtentScrollController pickerControllerFROM;
  late FixedExtentScrollController pickerControllerTO;

  Rate _rateFROM;
  Rate _rateTO;
  double _amountFROM = 0;
  double _amountTO = 0;
  double _result = 0;

  ConvertNotifier(this._rates)
      : _rateFROM = _rates.first,
        _rateTO = _rates[1] {
    if (_rates.length >= 2) {
      rateFROM = _rateFROM;
      rateTO = _rateTO;
    }
    amountController.text = "0.00";
    amountController.addListener(() => calculateResult());
  }

  void update() {
    updateRateFROM();
    updateRateTO();
    calculateResult();
    notifyListeners();
  }

  set rates(List<Rate> rates) {
    _rates = rates;
    update();
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
    calculateResult();
  }

  void selectRateTO(List<Rate> cachedRates) {
    rateTO = rates.firstWhere(
      (e) => cachedRates[pickerControllerTO.selectedItem].id == e.id,
      orElse: () => cachedRates[pickerControllerTO.selectedItem],
    );
    calculateResult();
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

  double get amountFROM => _amountFROM;
  double get amountTO => _amountTO;
  double get result => _result;

  void calculateResult() {
    _amountFROM = double.tryParse(amountController.text) ?? 0;
    final amountFROMUsd = _amountFROM * double.parse(rateFROM.rateUsd);
    _amountTO = amountFROMUsd / double.parse(rateTO.rateUsd);
    _result = amountTO * (1 + commissionPercent / 100);
    notifyListeners();
  }
}
