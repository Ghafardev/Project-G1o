class EarthquakeModel {
  final String date;
  final String time;
  final String magnitude;
  final String region;
  final String depth;

  EarthquakeModel({
    required this.date,
    required this.time,
    required this.magnitude,
    required this.region,
    required this.depth,
  });

  factory EarthquakeModel.fromJson(Map<String, dynamic> json) {
    return EarthquakeModel(
      date: json['Tanggal'] ?? '',
      time: json['Jam'] ?? '',
      magnitude: json['Magnitude'] ?? '',
      region: json['Wilayah'] ?? '',
      depth: json['Kedalaman'] ?? '',
    );
  }
}
