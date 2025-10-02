import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController _googleMapController;

  final LatLng _workLocation = const LatLng(
    30.06135618246489,
    31.351897773425733,
  );
  final LatLng _homeLocation = const LatLng(
    30.080346959966928,
    31.263277207445874,
  );
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: _homeLocation, zoom: 19);
    _currentLocation = _homeLocation;
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
          },
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton.large(
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
            child: Text(
              'Go to ${_currentLocation == _homeLocation
                  ? "Work"
                  : _workLocation == _currentLocation
                  ? "Home"
                  : "Unknown"}',
            ),
            // icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
