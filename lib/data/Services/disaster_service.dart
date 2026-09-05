import 'package:http/http.dart' as http;
import 'dart:convert';

class DisasterService {
  final String _baseUrl = "https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json";

  Future<Map<String, dynamic>?> fetchLatestEarthquake() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Data BMKG memiliki struktur tertentu, mengambil gempa pertama
        return data['Infogempa']['gempa'][0];
      }
    } catch (e) {
      // Log error internally, do not expose to end user
      return null;
    }
    return null;
  }
}
