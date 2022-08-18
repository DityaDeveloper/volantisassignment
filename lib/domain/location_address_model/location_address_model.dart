class LocationAddressModel {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  LocationAddressModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        latitude = map['latitude'],
        longitude = map['longitude'];
}
