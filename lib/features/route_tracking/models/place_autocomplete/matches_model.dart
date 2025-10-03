class MatchesModel {
  int? endOffset;

  MatchesModel({this.endOffset});

  MatchesModel.fromJson(Map<String, dynamic> json) {
    endOffset = json['endOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endOffset'] = this.endOffset;
    return data;
  }
}