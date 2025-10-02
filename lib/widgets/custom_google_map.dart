import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../generated/assets.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController _googleMapController;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  final LatLng _workLocation = const LatLng(
    30.06135618246489,
    31.351897773425733,
  );
  final LatLng _homeLocation = const LatLng(
    30.080346959966928,
    31.263277207445874,
  );

  late LatLng _currentLocation;
  late String _currentStyle;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: _homeLocation, zoom: 12);
    _currentLocation = _homeLocation;
    _currentStyle = Assets.nightMapStyle;
    initMarkers();
    initPolygons();
  }

  Future<void> initMapStyle() async {
    final styleJson = await rootBundle.loadString(Assets.nightMapStyle);
    _googleMapController.setMapStyle(styleJson);
    _currentStyle = Assets.nightMapStyle;
  }

  changeMapStyle(String style) async {
    final styleJson = await rootBundle.loadString(style);
    _googleMapController.setMapStyle(styleJson);
    _currentStyle = style;
  }

  initMarkers() async {
    var customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      Assets.placeholder,
      width: 40,
      height: 40,
    );
    var markers = places.map(
      (place) => Marker(
        markerId: MarkerId(place.id.toString()),
        position: place.latLog,
        infoWindow: InfoWindow(title: place.name),
        icon: customIcon,
      ),
    );
    _markers.addAll(markers);
    setState(() {});
  }

  initPolygons() {
    var polygon = Polygon(
      polygonId: PolygonId('polygon'),
      holes: [
        [
          LatLng(30.066616924119746, 31.305543653882356),
          LatLng(30.061296117428927, 31.307996444811835),
          LatLng(30.058842384828786, 31.30299529966991),
          LatLng(30.061902648696826, 31.30086105301699),
          LatLng(30.064080616708267, 31.29815342666628),
        ],
      ],
      points: List.generate(places.length, (index) => places[index].latLog),
      fillColor: Colors.red.withValues(alpha: 0.3),
      strokeColor: Colors.red,
      strokeWidth: 2,
    );
    _polygons.add(polygon);
    setState(() {});
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) {
            _googleMapController = controller;
            initMapStyle();
          },
          markers: _markers,
         polygons: _polygons,
          zoomControlsEnabled: false,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Row(
            spacing: 20,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  if (_currentLocation == _homeLocation) {
                    _currentLocation = _workLocation;
                  } else {
                    _currentLocation = _homeLocation;
                  }
                  _googleMapController.animateCamera(
                    CameraUpdate.newLatLng(_currentLocation),
                  );
                  setState(() {});
                },
                label: Text(
                  'Go to ${_currentLocation == _homeLocation
                      ? "Work"
                      : _workLocation == _currentLocation
                      ? "Home"
                      : "Unknown"}',
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  changeMapStyle(
                    _currentStyle == Assets.nightMapStyle
                        ? Assets.retroMapStyle
                        : Assets.nightMapStyle,
                  );
                  setState(() {});
                },
                label: Text(
                  'Change Map Style to ${_currentStyle == Assets.nightMapStyle
                      ? "Retro"
                      : _currentStyle == Assets.retroMapStyle
                      ? "Night"
                      : "Unknown"}',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
