import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:volantisassignmenttoaditya/domain/forcast_weather_model/forcast_weather_model.dart';

import '../../../data/repo/shared_pref.dart';
import '../../../data/repo/weather_data_source.dart';
import '../../../domain/forcast_weather_model/forcast_weather_freezed.dart';
import '../../../domain/forcast_weather_model/forcast_weather_response_model.dart';

class ForcastWeatherNotifier extends StateNotifier<ForcastWeatherState> {
  ForcastWeatherNotifier() : super(const ForcastWeatherState()) {
    _initGet();
  }

  WeatherDataSource forcasDataSource = WeatherDataSource();
  List? tempList = [];

  double? lat;
  double? long;

  Future<void> refresh() async {
    _initGet();
  }

  Future<void> getCountryForcast(String country, String city) async {
    _initGetCountry(country, city);
  }

  _initGet() async {
    await DityaSharedPreferences.instance
        .getStringValue("currentlatitude")
        .then((value) => lat = double.tryParse(value!));
    await DityaSharedPreferences.instance
        .getStringValue("currentlongitude")
        .then((value) => long = double.tryParse(value!));
    debugPrint("get current location : ${lat.toString()} - ${long.toString()}");

    state = state.copyWith(isLoading: true);
    final response =
        await forcasDataSource.loadDailyForecastWeatherList(lat!, long!);

    if (response == null) {
      state = state.copyWith(isLoading: false);

      return;
    }

    final List<dynamic> parsed = response!['response'][0]['periods'];

    List<ForcastWeatherModel> responseModelList =
        ForcastWeatherResponse.fromJson(parsed).list;
    debugPrint('list : ${response.toString()}');
    state = state.copyWith(isLoading: false, list: responseModelList);
  }

  _initGetCountry(String country, String city) async {
    state = state.copyWith(isLoading: true);
    final response = await forcasDataSource
        .loadDailyForecastWeatherListWithCountry(country, city);
    if (response == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final List<dynamic> parsed = response!['response'][0]['periods'];

    List<ForcastWeatherModel> responseModelList =
        ForcastWeatherResponse.fromJson(parsed).list;
    debugPrint('list : ${response.toString()}');
    state = state.copyWith(isLoading: false, list: responseModelList);
  }

  loadMorePost(double lat, double long) async {
    StringBuffer bf = StringBuffer();

    bf.write('try to request loading ${state.isLoading} ');
    if (state.isLoading) {
      bf.write(' fail');
      return;
    }
    bf.write(' success');
    debugPrint(bf.toString());
    state = state.copyWith(
        isLoading: false, isLoadMoreDone: false, isLoadMoreError: false);

    List<dynamic>? response =
        await forcasDataSource.loadDailyForecastWeatherList(lat, long);

    List<ForcastWeatherModel> responseModelList =
        ForcastWeatherResponse.fromJson(response!).list;

    if (responseModelList.isEmpty) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    debugPrint('load more ${responseModelList.length}');
    if (responseModelList.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: true,
      );
    }
  }
}
