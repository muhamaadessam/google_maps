import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../generated/assets.dart';

class LiveTrackerGoogleMap extends StatefulWidget {
  const LiveTrackerGoogleMap({super.key});

  @override
  State<LiveTrackerGoogleMap> createState() => _LiveTrackerGoogleMapState();
}

class _LiveTrackerGoogleMapState extends State<LiveTrackerGoogleMap> {
  late CameraPosition _initialCameraPosition;
  GoogleMapController? _googleMapController;
  late LocationService locationService;
  final Set<Marker> _markers = {};
  bool _isFirstCall = true;

  final LatLng _homeLocation = const LatLng(
    30.080346959966928,
    31.263277207445874,
  );
  late String _currentStyle;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: _homeLocation, zoom: 20);
    _currentStyle = Assets.nightMapStyle;
    locationService = LocationService();
    initMyLocation();
  }

  Future<void> initMapStyle() async {
    final styleJson = await rootBundle.loadString(Assets.nightMapStyle);
    _googleMapController!.setMapStyle(styleJson);
    _currentStyle = Assets.nightMapStyle;
  }

  changeMapStyle(String style) async {
    final styleJson = await rootBundle.loadString(style);
    _googleMapController!.setMapStyle(styleJson);
    _currentStyle = style;
  }

  Future<void> initMyLocation() async {
    locationService.getRealTimeLocationData((locationData) async {
      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
      updateMyCamera(latLng);
      setMyLocationMarker(latLng);
    });
  }

  updateMyCamera(LatLng latLng) {
    if (_isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 1);
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      _isFirstCall = false;
    } else {
      _googleMapController?.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  setMyLocationMarker(LatLng latLng) async {
    var customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      Assets.placeholder,
      width: 40,
      height: 40,
    );
    var marker = Marker(
      markerId: MarkerId('my_location'),
      position: latLng,
      infoWindow: InfoWindow(title: 'My Location'),
      icon: customIcon,
    );
    _markers.add(marker);
    setState(() {});
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
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
