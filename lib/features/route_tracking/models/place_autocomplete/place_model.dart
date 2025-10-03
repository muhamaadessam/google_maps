
import 'package:google_maps/features/route_tracking/models/place_autocomplete/structured_format_model.dart';
import 'package:google_maps/features/route_tracking/models/place_autocomplete/text_model.dart';

class PlaceModel {
  String? place;
  String? placeId;
  TextModel? text;
  StructuredFormatModel? structuredFormat;
  List<String>? types;

  PlaceModel(
      {this.place, this.placeId, this.text, this.structuredFormat, this.types});

  PlaceModel.fromJson(Map<String, dynamic> json) {
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








