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
    _initialCameraPosition = CameraPosition(target: _homeLocation, zoom: 19);
    _currentLocation = _homeLocation;
    _currentStyle = Assets.nightMapStyle;
    initMarkers();
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
                // icon: const Icon(Icons.add),
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
                // icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
