class RouteModel {
  final String duration;
  final int distanceMeters;
  final String encodedPolyline;

  RouteModel({
    required this.duration,
    required this.distanceMeters,
    required this.encodedPolyline,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      duration: json['duration'],
      distanceMeters: json['distanceMeters'],
      encodedPolyline: json['polyline']['encodedPolyline'],
    );
  }
}
