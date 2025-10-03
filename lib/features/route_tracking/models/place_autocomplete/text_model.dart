
import 'matches_model.dart';

class TextModel {
  String? text;
  List<MatchesModel>? matches;

  TextModel({this.text, this.matches});

  TextModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['matches'] != null) {
      matches = <MatchesModel>[];
      json['matches'].forEach((v) {
        matches!.add(new MatchesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}