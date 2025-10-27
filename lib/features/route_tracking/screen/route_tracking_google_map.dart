import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps/features/route_tracking/models/place_autocomplete/place_model.dart';
import 'package:google_maps/features/route_tracking/widgets/customTextFormField.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/services/google_maps_places_service.dart';
import '../../../utils/services/location_service.dart';
import '../../../utils/services/routes_service.dart';
import '../models/place_details/place_details_model.dart';

class RouteTrackingGoogleMap extends StatefulWidget {
  const RouteTrackingGoogleMap({super.key});

  @override
  State<RouteTrackingGoogleMap> createState() => _RouteTrackingGoogleMapState();
}

class _RouteTrackingGoogleMapState extends State<RouteTrackingGoogleMap> {
  late final GoogleMapController _googleMapController;
  late final LocationService _locationService;
  late final GoogleMapsPlacesService _placesService;
  late final RoutesService _routesService;
  late final TextEditingController _searchController;
  late final Uuid _uuid;
  Timer? _debounce;

  CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(30, 31),
    zoom: 6,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<PlaceModel> _predictions = [];

  LatLng? _currentLocation;
  LatLng? _destination;
  PlaceDetailsModel? _placeDetails;
  String? _sessionToken;

  @override
  void initState() {
    super.initState();
    _locationService = LocationService();
    _placesService = GoogleMapsPlacesService();
    _routesService = RoutesService();
    _searchController = TextEditingController();
    _uuid = const Uuid();

    _initListeners();
  }

  void _initListeners() {
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () async {
        final input = _searchController.text;
        if (input.isEmpty) {
          setState(_predictions.clear);
          return;
        }

        _sessionToken ??= _uuid.v4();
        final results = await _placesService.getPlaceAutocomplete(
          input: input,
          sessionToken: _sessionToken!,
        );

        if (!mounted) return;
        setState(() {
          _predictions
            ..clear()
            ..addAll(results);
        });
      });
    });
  }

  Future<void> _initMap(GoogleMapController controller) async {
    _googleMapController = controller;

    await _initMyLocation();
  }

  Future<void> _initMyLocation() async {
    try {
      _locationService.getRealTimeLocationData((locationData) {
        _currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        _addMarker(_currentLocation!, 'current_position', 'Current Position');

        final newPosition = CameraPosition(target: _currentLocation!, zoom: 18);
        _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(newPosition),
        );

        if (mounted) {
          setState(() => _initialCameraPosition = newPosition);
        }
      });
    } catch (e) {
      debugPrint('Error initializing location: $e');
    }
  }

  Future<void> _handlePlaceSelection(PlaceModel place) async {
    try {
      _placeDetails = await _placesService.getPlaceDetails(
        placeId: place.placeId!,
      );

      final lat = _placeDetails?.location?.latitude;
      final lng = _placeDetails?.location?.longitude;
      if (lat == null || lng == null) return;

      _destination = LatLng(lat, lng);
      _searchController.clear();
      _sessionToken = null;

      _addMarker(_destination!, 'destination', 'Destination');
      await _drawRoute();

      // _googleMapController.animateCamera(CameraUpdate.newLatLng(_destination!));

      if (mounted) {
        setState(_predictions.clear);
      }
    } catch (e) {
      debugPrint('Error handling place selection: $e');
    }
  }

  void _addMarker(LatLng position, String id, String title) {
    _markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
        infoWindow: InfoWindow(title: title),
      ),
    );
  }

  Future<void> _drawRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final routes = await _routesService.getRoutes(
      origin: _currentLocation!,
      destination: _destination!,
    );

    if (routes.isEmpty) return;

    final decodedPoints = PolylinePoints.decodePolyline(
      routes.first.encodedPolyline,
    );

    final polylinePoints = decodedPoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ),
    );

    LatLngBounds bounds = getLatLongBounds(polylinePoints);

    _googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 64),
    );
    setState(() {});
  }

  LatLngBounds getLatLongBounds(List<LatLng> polylinePoints) {
    var southwestLatitude = polylinePoints.first.latitude;
    var southwestLongitude = polylinePoints.first.longitude;
    var northeastLatitude = polylinePoints.first.latitude;
    var northeastLongitude = polylinePoints.first.longitude;

    for (var point in polylinePoints) {
      southwestLongitude = min(southwestLongitude, point.longitude);
      southwestLatitude = min(southwestLatitude, point.latitude);
      northeastLongitude = max(northeastLongitude, point.longitude);
      northeastLatitude = max(northeastLatitude, point.latitude);
    }

    return LatLngBounds(
      southwest: LatLng(southwestLatitude, southwestLongitude),
      northeast: LatLng(northeastLatitude, northeastLongitude),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top + 16;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _initMap,
            markers: _markers,
            polylines: _polylines,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: topPadding,
            right: 16,
            left: 16,
            child: Column(
              spacing: 16,
              children: [
                CustomTextField(
                  controller: _searchController,
                  fillColor: Colors.white,
                  borderRadius: 30,
                  hint: 'Search here',
                  hintStyle: const TextStyle(),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                if (_predictions.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _predictions.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (context, index) {
                        final place = _predictions[index];
                        return ListTile(
                          onTap: () => _handlePlaceSelection(place),
                          title: Text(place.text?.text ?? ''),
                          leading: const Icon(Icons.pin_drop_outlined),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
