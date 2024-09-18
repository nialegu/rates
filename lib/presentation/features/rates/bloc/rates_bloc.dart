import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entities/rate.dart';

part 'rates_event.dart';
part 'rates_state.dart';
part 'rates_bloc.freezed.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  RatesBloc() : super(const _Initial([])) {
    on<RatesEvent>(_onEvent);
  }

  _onEvent(RatesEvent event, Emitter<RatesState> emit) async {
    await event.when(
      started: () async {
        emit(const RatesState.loading());
        await Future.delayed(const Duration(seconds: 2), () {
          emit(const RatesState.canPushRatesPage([]));
        });
      },
      update: () {},
      forceUpdate: () {},
    );
  }
}
