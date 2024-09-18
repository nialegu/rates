import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entities/rate.dart';
import '../../../../repositories/rates_repository.dart';

part 'rates_event.dart';
part 'rates_state.dart';
part 'rates_bloc.freezed.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final RatesRepository _ratesRepository = RatesRepository();
  late final StreamSubscription _fetchDataPeriodicSubscription;
  DateTime loadStamp = DateTime.now().add(const Duration(seconds: -30));

  List<Rate> _cachedRates = [];
  List<Rate> get cachedRates => _cachedRates;

  RatesBloc() : super(const _Initial([])) {
    on<RatesEvent>(_onEvent);
  }

  _onEvent(RatesEvent event, Emitter<RatesState> emit) async {
    await event.when(
      started: () async {
        emit(const RatesState.loading());
        await _ratesRepository.fetchIterable().then((rates) {
          _cachedRates = rates.toList();
          emit(RatesState.initial(rates.toList()));
        }).catchError((error) {
          debugPrint("Fetch rates error: ${error.toString()}");
          emit(RatesState.fetchFailed(error));
        }).whenComplete(() {
          _fetchDataPeriodicSubscription =
              Stream.periodic(const Duration(seconds: 30), (_) {})
                  .listen((_) => add(const RatesEvent.update()));
        });
      },
      update: () async {
        emit(const RatesState.hiddenLoading());
        await _ratesRepository.fetchIterable().then((rates) {
          _cachedRates = rates.toList();
          emit(RatesState.initial(rates.toList()));
          debugPrint("Refresh rates");
        }).catchError((error) {
          debugPrint("Fetch rates error: ${error.toString()}");
          emit(RatesState.fetchFailed(error));
        });
      },
      forceUpdate: () async {
        if (DateTime.now().difference(loadStamp).inSeconds < 5) return;
        emit(const RatesState.loading());
        await _ratesRepository.fetchIterable().then((rates) {
          _cachedRates = rates.toList();
          emit(RatesState.initial(rates.toList()));
        }).catchError((error) {
          debugPrint("Fetch rates error: ${error.toString()}");
          emit(RatesState.fetchFailed(error));
        }).whenComplete(() {
          loadStamp = DateTime.now();
        });
      },
    );
  }

  @override
  Future<void> close() async {
    await _fetchDataPeriodicSubscription.cancel();
    return super.close();
  }
}
