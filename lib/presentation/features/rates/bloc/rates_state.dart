part of 'rates_bloc.dart';

@freezed
class RatesState with _$RatesState {
  const factory RatesState.initial(List<Rate> rates) = _Initial;

  const factory RatesState.canPushRatesPage(List<Rate> rates) = _CanPushRatesPage;

  const factory RatesState.loading() = _Loading;

  const factory RatesState.fetchFailed(dynamic error) = _FetchFailed;
}
