import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volantisassignmenttoaditya/domain/forcast_weather_model/forcast_weather_freezed.dart';
import 'package:volantisassignmenttoaditya/domain/forcast_weather_model/forcast_weather_model.dart';
import '../../presentation/screen/forecast/forecast_view_model.dart';

final keyProvider = StateProvider<String>((ref) {
  return '';
});

final forcastProvider =
    StateNotifierProvider<ForcastWeatherNotifier, ForcastWeatherState>((ref) {
  return ForcastWeatherNotifier();
});

final forcastSearchProvider = StateProvider<List<ForcastWeatherModel>>((ref) {
  final searchState = ref.watch(forcastProvider);
  final key = ref.watch(keyProvider);

  return searchState.list
      .where((element) => element.timestamp.toString().contains(key))
      .toList();
});
