import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/earthquake_model.dart';

class DisasterService {
  final String _baseUrl = "https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json";

  Future<EarthquakeModel?> fetchLatestEarthquake() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final gempaJson = data['Infogempa']['gempa'][0];
        return EarthquakeModel.fromJson(gempaJson);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
