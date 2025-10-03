class Matches {
  int? endOffset;

  Matches({this.endOffset});

  Matches.fromJson(Map<String, dynamic> json) {
    endOffset = json['endOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endOffset'] = this.endOffset;
    return data;
  }
}