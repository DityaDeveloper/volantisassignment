import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_model.dart';

part 'weather_freezed.freezed.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default(1) int page,
    @Default([]) List<WeatherModel> list,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _WeatherState;

  const WeatherState._();
}
