import 'package:google_maps/features/route_tracking/models/secondary_text_model.dart';
import 'package:google_maps/features/route_tracking/models/text_model.dart';

class StructuredFormatModel {
  TextModel? mainText;
  SecondaryTextModel? secondaryText;

  StructuredFormatModel({this.mainText, this.secondaryText});

  StructuredFormatModel.fromJson(Map<String, dynamic> json) {
    mainText = json['mainText'] != null
        ? TextModel.fromJson(json['mainText'])
        : null;
    if (json['secondaryText'] != null) {
      secondaryText = SecondaryTextModel.fromJson(json['secondaryText']);
    } else {
      secondaryText = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mainText != null) {
      data['mainText'] = mainText!.toJson();
    }
    if (secondaryText != null) {
      data['secondaryText'] = secondaryText!.toJson();
    }
    return data;
  }
}
