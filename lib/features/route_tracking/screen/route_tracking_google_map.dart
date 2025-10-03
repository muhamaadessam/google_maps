import 'package:flutter/material.dart';
import 'package:google_maps/utils/google_maps_places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/location_service.dart';

class RouteTrackingGoogleMap extends StatefulWidget {
  const RouteTrackingGoogleMap({super.key});

  @override
  State<RouteTrackingGoogleMap> createState() => _RouteTrackingGoogleMapState();
}

class _RouteTrackingGoogleMapState extends State<RouteTrackingGoogleMap> {
  late GoogleMapController _googleMapController;
  late CameraPosition _initialCameraPosition;
  late LocationService locationService;
  late Set<Marker> _markers;
  GoogleMapsPlacesService googleMapsPlacesService = GoogleMapsPlacesService();

  @override
  void initState() {
    super.initState();
    _markers = {};
    _initialCameraPosition = CameraPosition(target: LatLng(30, 31), zoom: 6);
    locationService = LocationService();
  }

  initMyLocation() async {
    try {
      var locationData = await locationService.getLocationData();
      var currentPosition = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker currentLocationMarker = Marker(
        markerId: const MarkerId('current_position'),
        position: currentPosition,
        infoWindow: const InfoWindow(title: 'Current Position'),
      );
      _markers.add(currentLocationMarker);
      CameraPosition cameraPosition = CameraPosition(
        target: currentPosition,
        zoom: 18,
      );
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      setState(() {
        _initialCameraPosition = cameraPosition;
      });
    } on LocationServiceException catch (e) {
      debugPrint(e.toString());
    } on LocationPermissionException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) {
            _googleMapController = controller;
            initMyLocation();
          },
          markers: _markers,
          zoomControlsEnabled: false,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton.extended(
            onPressed: () {
              googleMapsPlacesService.getPlaceAutocomplete(input: 'test');

            },
            label: const Text('Get Route'),
          ),
        ),
      ],
    );
  }
}
