import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation_model.dart';

part 'observation_freezed.freezed.dart';

@freezed
abstract class ObservationState with _$ObservationState {
  const factory ObservationState({
    @Default(1) int page,
    @Default([]) List<ObservationWeatherModel> list,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _ObservationState;

  const ObservationState._();
}
