import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:volantisassignmenttoaditya/data/repo/shared_pref.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_freezed.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_model.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_response_model.dart';

import '../../../data/repo/weather_data_source.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(const WeatherState()) {
    _initGet();
  }

  WeatherDataSource weatherDataSource = WeatherDataSource();
  List? tempList = [];
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  LocationData? userLocation;
  double? lat;
  double? long;

  Future<void> refresh() async {
    _initGet();
  }

  Future<void> getCountryWeather(String country, String city) async {
    _initGetWithCountry(country, city);
  }

  _initGet() async {
    await DityaSharedPreferences.instance
        .getStringValue("currentlatitude")
        .then((value) => lat = double.tryParse(value!));
    await DityaSharedPreferences.instance
        .getStringValue("currentlongitude")
        .then((value) => long = double.tryParse(value!));
    debugPrint("get current latitude : ${lat.toString()}");
    state = state.copyWith(isLoading: true);
    var currentDate = DateTime.now();
    String toCurrentHours = DateFormat('HH').format(currentDate);
    final response = await weatherDataSource.loadDailyWeatherList(
        toCurrentHours, lat!, long!);
    // final response = await weatherDataSource.loadDailyWeatherList(
    //     toCurrentHours, -6.3535408, 106.8097541);
    if (response == null) {
      state = state.copyWith(isLoading: false, list: []);
      return;
    }

    final List<dynamic> parsed = response!['response'][0]['periods'];

    List<WeatherModel> responseModelList =
        WeatherResponse.fromJson(parsed).list;
    debugPrint('list : ${response.toString()}');
    state = state.copyWith(isLoading: false, list: responseModelList);
  }

  _initGetWithCountry(String country, String city) async {
    var currentDate = DateTime.now();
    String toCurrentHours = DateFormat('HH').format(currentDate);
    debugPrint("this hours : $toCurrentHours");
    state = state.copyWith(isLoading: true);
    final response = await weatherDataSource.loadDailyWeatherListWithCountry(
        toCurrentHours, country, city);
    if (response == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final List<dynamic> parsed = response!['response'][0]['periods'];

    List<WeatherModel> responseModelList =
        WeatherResponse.fromJson(parsed).list;
    debugPrint('list : ${response.toString()}');
    state = state.copyWith(isLoading: false, list: responseModelList);
  }

  loadMorePost(double lat, double long) async {
    var currentDate = DateTime.now();
    String toCurrentHours = DateFormat('HH').format(currentDate);
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

    final response =
        await weatherDataSource.loadDailyWeatherList(toCurrentHours, lat, long);

    final List<dynamic> parsed = response!['response'][0]['periods'];

    List<WeatherModel> responseModelList =
        WeatherResponse.fromJson(parsed).list;

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
