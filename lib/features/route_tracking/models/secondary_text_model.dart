class SecondaryTextModel {
  String? text;

  SecondaryTextModel({this.text});

  SecondaryTextModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}