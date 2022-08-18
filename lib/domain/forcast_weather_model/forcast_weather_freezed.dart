import 'package:freezed_annotation/freezed_annotation.dart';

import 'forcast_weather_model.dart';

part 'forcast_weather_freezed.freezed.dart';

@freezed
abstract class ForcastWeatherState with _$ForcastWeatherState {
  const factory ForcastWeatherState({
    @Default(1) int page,
    @Default([]) List<ForcastWeatherModel> list,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _ForcastWeatherState;

  const ForcastWeatherState._();
}
