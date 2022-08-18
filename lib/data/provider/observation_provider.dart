import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volantisassignmenttoaditya/domain/observation_model/observation_freezed.dart';
import 'package:volantisassignmenttoaditya/domain/observation_model/observation_model.dart';

import '../../presentation/screen/observation/observation_view_model.dart';

final keyProvider = StateProvider<String>((ref) {
  return '';
});

final observationProvider =
    StateNotifierProvider<ObservationWeatherNotifier, ObservationState>((ref) {
  return ObservationWeatherNotifier();
});

final stateSearchobservationModel =
    StateProvider<List<ObservationWeatherModel>>((ref) {
  final searchState = ref.watch(observationProvider);
  final key = ref.watch(keyProvider);

  return searchState.list
      .where((element) => element.timestamp.toString().contains(key))
      .toList();
});
