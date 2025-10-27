import 'package:location/location.dart';

class LocationService {
  final Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    print('checkAndRequestLocationService');
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationServiceException();
      }
    }
    print('serviceEnabled: $serviceEnabled');
  }

  Future<void> checkAndRequestLocationPermission() async {
    print('checkAndRequestLocationPermission');
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
    print('permission: $permission');
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocationData() async {
    print('getLocationData');
    try {
      await checkAndRequestLocationService();
      await checkAndRequestLocationPermission();

      return location.getLocation();
    } catch (e) {
      print(e);
      throw e;
    }
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
