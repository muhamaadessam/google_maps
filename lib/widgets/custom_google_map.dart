import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../generated/assets.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition _initialCameraPosition;
  GoogleMapController? _googleMapController;
  late Location location;
  final Set<Marker> _markers = {};

  final LatLng _homeLocation = const LatLng(
    30.080346959966928,
    31.263277207445874,
  );
  late String _currentStyle;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: _homeLocation, zoom: 17);
    _currentStyle = Assets.nightMapStyle;
    location = Location();
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

  Future<void> checkAndRequestLocationService() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }
    if (permission == PermissionStatus.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> getLocationData() async {
    var customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      Assets.placeholder,
      width: 40,
      height: 40,
    );
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen((locationData) {
      _googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );

      var marker = Marker(
        markerId: MarkerId('my_location'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
        infoWindow: InfoWindow(title: 'My Location'),
        icon: customIcon,
      );
      _markers.add(marker);
      setState(() {});
    });
  }

  Future<void> initMyLocation() async {
    await checkAndRequestLocationService();
    var permission = await checkAndRequestLocationPermission();
    if (!permission) return;
    await getLocationData();
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
