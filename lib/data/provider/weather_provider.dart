import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_freezed.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_model.dart';

import '../../presentation/screen/weather/weather_view_model.dart';

final keyProvider = StateProvider<String>((ref) {
  return '';
});

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});

final stateSearchWeatherModel = StateProvider<List<WeatherModel>>((ref) {
  final searchState = ref.watch(weatherProvider);
  final key = ref.watch(keyProvider);

  return searchState.list
      .where((element) => element.timestamp.toString().contains(key))
      .toList();
});
