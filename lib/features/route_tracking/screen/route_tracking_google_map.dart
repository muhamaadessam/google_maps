import 'package:flutter/material.dart';
import 'package:google_maps/features/route_tracking/models/place_autocomplete/place_model.dart';
import 'package:google_maps/features/route_tracking/widgets/customTextFormField.dart';
import 'package:google_maps/utils/google_maps_places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/location_service.dart';
import '../models/place_details/place_details_model.dart';

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
  late TextEditingController _editingController;
  late List<PlaceModel> places;
  late PlaceDetailsModel? placeDetails;
  String? sessionToken;
  late Uuid uuid;

  GoogleMapsPlacesService googleMapsPlacesService = GoogleMapsPlacesService();

  @override
  void initState() {
    super.initState();
    _markers = {};
    _initialCameraPosition = CameraPosition(target: LatLng(30, 31), zoom: 6);
    locationService = LocationService();
    _editingController = TextEditingController();
    uuid = const Uuid();
    places = [];
    fetchPredictions();
  }

  void fetchPredictions() {
    _editingController.addListener(() async {
      if (_editingController.text.isNotEmpty) {
        sessionToken ??= uuid.v4();
        var result = await googleMapsPlacesService.getPlaceAutocomplete(
          input: _editingController.text,
          sessionToken: sessionToken!,
        );
        places.clear();
        places.addAll(result);
        setState(() {});
      } else {
        places.clear();
        setState(() {});
      }
    });
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
            top: MediaQuery.paddingOf(context).top + 16,
            right: 16,
            left: 16,
            child: Column(
              spacing: 16,
              children: [
                CustomTextField(
                  controller: _editingController,
                  fillColor: Colors.white,
                  borderRadius: 30,
                  hint: 'Search here',
                  hintStyle: TextStyle(),
                  borderSide: BorderSide(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () async {
                        placeDetails = await googleMapsPlacesService
                            .getPlaceDetails(placeId: places[index].placeId!);
                        _editingController.clear();
                        var placeLatLog = LatLng(
                          placeDetails!.location!.latitude!,
                          placeDetails!.location!.longitude!,
                        );
                        _googleMapController.animateCamera(
                          CameraUpdate.newLatLng(placeLatLog),
                        );
                        Marker currentLocationMarker = Marker(
                          markerId: const MarkerId('current_position'),
                          position: placeLatLog,
                          infoWindow: const InfoWindow(
                            title: 'Current Position',
                          ),
                        );
                        _markers.add(currentLocationMarker);
                        sessionToken = null;
                        places.clear();
                        setState(() {});
                      },
                      title: Text(places[index].text?.text ?? ''),
                      leading: Icon(Icons.pin_drop_outlined),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(height: 0),
                    itemCount: places.length,
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
