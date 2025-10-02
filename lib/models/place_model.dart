import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String name;
  final int id;
  final LatLng latLog;

  PlaceModel({required this.name, required this.id, required this.latLog});
}

List<PlaceModel> places = [
  PlaceModel(
    name: 'Home',
    id: 1,
    latLog: const LatLng(30.080346959966928, 31.263277207445874),
  ),
  PlaceModel(
    name: 'Work',
    id: 2,
    latLog: const LatLng(30.06135618246489, 31.351897773425733),
  ),
];
