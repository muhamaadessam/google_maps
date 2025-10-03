import 'package:location/location.dart';

class LocationService {
  final Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocationData() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return location.getLocation();
  }
}

class LocationServiceException implements Exception {
  final String? message;

  LocationServiceException({this.message});
}

class LocationPermissionException implements Exception {
  final String? message;

  LocationPermissionException({this.message});
}
