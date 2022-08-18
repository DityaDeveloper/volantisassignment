import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:location/location.dart';
import 'package:volantisassignmenttoaditya/data/repo/shared_pref.dart';
import 'package:volantisassignmenttoaditya/presentation/widget/utils/primary_button.dart';

import '../../screen/dashboard/dashboard.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    _getUserLocation();
  }

  void navHelper() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
  }

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
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
    // set to userlocation;
    _userLocation = locationData;
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        _userLocation!.latitude!, _userLocation!.longitude!);

    var first = placemarks[0];

    debugPrint(
        ' ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea},${first.street}, ${first.postalCode},${first.thoroughfare}, ${first.subThoroughfare}');

    setState(() {
      debugPrint(
          "saving current latitude : ${_userLocation!.latitude}, longitude : ${_userLocation!.longitude}");
      DityaSharedPreferences.instance.setStringValue(
          "currentlatitude", _userLocation!.latitude.toString());
      DityaSharedPreferences.instance.setStringValue(
          "currentlongitude", _userLocation!.longitude.toString());
      DityaSharedPreferences.instance
          .setStringValue("currentaddress", first.subLocality.toString());
    });

    navHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Get Location'),
            Text(_userLocation.toString()),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
