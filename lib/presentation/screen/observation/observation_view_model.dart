import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:volantisassignmenttoaditya/domain/observation_model/observation_freezed.dart';
import 'package:volantisassignmenttoaditya/domain/observation_model/observation_model.dart';

import '../../../data/repo/shared_pref.dart';
import '../../../data/repo/weather_data_source.dart';
import '../../../domain/observation_model/observation_response.dart';

class ObservationWeatherNotifier extends StateNotifier<ObservationState> {
  ObservationWeatherNotifier() : super(const ObservationState()) {
    _initGet();
  }

  WeatherDataSource weatherDataSource = WeatherDataSource();
  List? tempList = [];
  double? lat;
  double? long;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> refresh() async {
    _initGet();
  }

  Future<void> getCountryObservation(String country, String city) async {
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

    final response =
        await weatherDataSource.loadDailyObservationWeather(lat!, long!);
    if (response == null) {
      state = state.copyWith(isLoading: false, list: []);
      return;
    } else {
      List<ObservationWeatherModel> responseModelList = [];
      final Map<String, dynamic> parsed = response!['response']['ob'];

      parsed.forEach((k, v) =>
          responseModelList.add(ObservationWeatherModel.fromJsonMap(parsed)));

      debugPrint('list  : ${response.toString()}');
      state = state.copyWith(isLoading: false, list: responseModelList);
    }
  }

  _initGetWithCountry(String country, String city) async {
    state = state.copyWith(isLoading: true);
    final response = await weatherDataSource
        .loadDailyObservationWeatherWithCountry(country, city);
    if (response == true) {
      debugPrint("data found");
      state = state.copyWith(isLoading: false);
      return;
    }

    List<ObservationWeatherModel> responseModelList = [];

    final Map<String, dynamic> parsed = response!['response']['ob'];
    parsed.forEach((k, v) =>
        responseModelList.add(ObservationWeatherModel.fromJsonMap(parsed)));

    debugPrint('list  : ${response.toString()}');
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
        await weatherDataSource.loadDailyObservationWeather(lat, long);

    List<ObservationWeatherModel> responseModelList =
        ObservationWeatherResponse.fromJson(response!).list;

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

  refreshGPS() async {
    debugPrint("starting to refresh gps");
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    _userLocation = locationData;
    debugPrint(
        "saving current latitude : ${_userLocation!.latitude}, longitude : ${_userLocation!.longitude}");
    await DityaSharedPreferences.instance
        .setStringValue("currentlatitude", _userLocation!.latitude.toString());
    await DityaSharedPreferences.instance.setStringValue(
        "currentlongitude", _userLocation!.longitude.toString());
  }
}
