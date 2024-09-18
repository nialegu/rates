part of 'rates_bloc.dart';

@freezed
class RatesState with _$RatesState {
  const factory RatesState.initial(List<Rate> rates) = _Initial;

  const factory RatesState.loading() = _Loading;

  const factory RatesState.hiddenLoading() = _HiddenLoading;

  const factory RatesState.fetchFailed(dynamic error) = _FetchFailed;
}
