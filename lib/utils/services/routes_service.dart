import 'package:dio/dio.dart';
import 'package:google_maps/features/route_tracking/models/routes/routes_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/network/dio_helper.dart';

class RoutesService {
  final String baseURL =
      'https://routes.googleapis.com/directions/v2:computeRoutes';

  Future<List<RouteModel>> getRoutes({required LatLng origin,required LatLng destination}) async {
    var data = {
      "origin": {
        "location": {
          "latLng": {"latitude": origin.latitude, "longitude": origin.longitude},
        },
      },
      "destination": {
        "location": {
          "latLng": {"latitude": destination.latitude, "longitude": destination.longitude},
        },
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false,
      },
      "languageCode": "en-US",
      "units": "METRIC",
    };
    final response = await DioHelper.postData(
      endPoint: baseURL,
      data: data,
      options: Options(
        headers: {
          'X-Goog-FieldMask':
          'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['routes'] != null) {
        return (response.data['routes'] as List)
            .map((e) => RouteModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception(response.data['error']['message']);
    }
  }
}
