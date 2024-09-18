part of 'rates_bloc.dart';

@freezed
class RatesEvent with _$RatesEvent {
  const factory RatesEvent.started() = _Started;

  const factory RatesEvent.update() = _Update;

  const factory RatesEvent.forceUpdate() = _ForceUpdate;
}