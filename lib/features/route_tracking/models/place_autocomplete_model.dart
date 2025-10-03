import 'package:google_maps/features/route_tracking/models/structured_format_model.dart';
import 'package:google_maps/features/route_tracking/models/text_model.dart';

class PlaceAutocompleteModel {
  String? place;
  String? placeId;
  TextModel? text;
  StructuredFormatModel? structuredFormat;
  List<String>? types;

  PlaceAutocompleteModel(
      {this.place, this.placeId, this.text, this.structuredFormat, this.types});

  PlaceAutocompleteModel.fromJson(Map<String, dynamic> json) {
    final placePrediction = json['placePrediction'] ?? {}; // 👈 safe access

    place = placePrediction['place'];
    placeId = placePrediction['placeId'];
    text = placePrediction['text'] != null
        ? TextModel.fromJson(placePrediction['text'])
        : null;
    structuredFormat = placePrediction['structuredFormat'] != null
        ? StructuredFormatModel.fromJson(placePrediction['structuredFormat'])
        : null;
    types = (placePrediction['types'] as List?)?.cast<String>(); // 👈 null-safe
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place'] = place;
    data['placeId'] = placeId;
    if (text != null) {
      data['text'] = text!.toJson();
    }
    if (structuredFormat != null) {
      data['structuredFormat'] = structuredFormat!.toJson();
    }
    data['types'] = types;
    return data;
  }
}








