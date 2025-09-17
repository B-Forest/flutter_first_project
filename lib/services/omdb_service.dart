import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OmdbService {
  final String? apiKey = dotenv.env['OMBD_KEY_API']; // mets ta clé

  Future<List<dynamic>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse("https://www.omdbapi.com/?apikey=$apiKey&s=$query");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["Response"] == "True") {
        final movies = List<Map<String, dynamic>>.from(data["Search"]);
        return movies;
      } else {
        return [];
      }
    } else {
      throw Exception("Erreur API OMDb : ${response.statusCode}");
    }
  }

  /// Convertit "2019–" ou "1990–1993" en entier
  static int parseYear(String? yearStr) {
    if (yearStr == null || yearStr.isEmpty) return 0;
    final match = RegExp(r'^\d{4}').firstMatch(yearStr);
    if (match != null) {
      return int.tryParse(match.group(0)!) ?? 0;
    }
    return 0;
  }
}
